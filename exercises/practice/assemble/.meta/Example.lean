import Std.Data.HashMap

open Lean Syntax Macro Std

structure CPU where
  regs : Vector Int64 10
  deriving Repr

structure Program where
  labels : HashMap String Nat
  ops    : Array (List String)

private def getStr (id : TSyntax `ident) : String :=
  id.getId.toString.toLower

private def regIdx (reg : String) : Fin 10 :=
  match reg with
  | "rdi" => 0
  | "rsi" => 1
  | "rdx" => 2
  | "rcx" => 3
  | "r8"  => 4
  | "r9"  => 5
  | "r10" => 6
  | "r11" => 7
  | "rax" => 8
  | "rflags" => 9
  | _     => panic! "invalid register"

private def getVal (cpu : CPU) (reg : String) : Int64 :=
  match reg.toInt? with
  | some n => n.toInt64
  | none => cpu.regs[regIdx reg]!

private def unFlag : Int64 := 1
private def eqFlag : Int64 := (1 : Int64) <<< 6
private def gtFlag : Int64 := (1 : Int64) <<< 5
private def ltFlag : Int64 := (1 : Int64) <<< 4

private def compareRegs (dest src : Int64) : Int64 := Id.run do
  let mut acc : Int64 := 0
  acc := acc ||| ((dest == src).toInt64 <<< 6)         -- equal
  acc := acc ||| ((decide (dest > src)).toInt64 <<< 5) -- greater
  acc := acc ||| ((decide (dest < src)).toInt64 <<< 4) -- lesser
  return acc

private def dispatchCondJmp (cpu : CPU) (dest : String) (labels : Std.HashMap String Nat) (flag : Int64) (RIP : Nat) : Nat :=
  if flag == unFlag || getVal cpu "rflags" &&& flag != 0 then
    if h₀: dest ∈ labels then
      labels[dest] + 1
    else panic! "Invalid label"
  else RIP + 1

declare_syntax_cat x86_dest
syntax ident : x86_dest

declare_syntax_cat x86_src
syntax ident : x86_src
syntax num   : x86_src
syntax "-" num  : x86_src

declare_syntax_cat x86_inst
syntax ident x86_dest "," x86_src  : x86_inst
syntax ident x86_dest : x86_inst
syntax ident ":" : x86_inst

syntax "assemble!(" (x86_inst)* ")" : term
syntax term "(" (term),* ")" : term

private def Program.evaluate (args : Array Int64) (program : Program) : Int64 := Id.run do
  let regs := (Array.finRange 6).foldl (init := Vector.replicate 10 0) fun acc i =>
    acc.set i (args[i]?.getD 0)

  let mut acc : CPU := { regs }
  let mut i := 0

  while h: i < program.ops.size do
    match program.ops[i] with
    | [op, dest, src] =>
      i := i + 1
      let srcVal := getVal acc src
      let destVal := getVal acc dest
      match op with
      | "mov"  => acc := { acc with regs := acc.regs.set (regIdx dest) srcVal }
      | "add"  => acc := { acc with regs := acc.regs.set (regIdx dest) (destVal + srcVal) }
      | "sub"  => acc := { acc with regs := acc.regs.set (regIdx dest) (destVal - srcVal) }
      | "xor"  => acc := { acc with regs := acc.regs.set (regIdx dest) (destVal ^^^ srcVal) }
      | "and"  => acc := { acc with regs := acc.regs.set (regIdx dest) (destVal &&& srcVal) }
      | "or"   => acc := { acc with regs := acc.regs.set (regIdx dest) (destVal ||| srcVal) }
      | "shl"  => acc := { acc with regs := acc.regs.set (regIdx dest) (destVal <<< srcVal) }
      | "shr"  => acc := { acc with regs := acc.regs.set (regIdx dest) (destVal >>> srcVal) }
      | "mul"  => acc := { acc with regs := acc.regs.set (regIdx dest) (destVal * srcVal) }
      | "div"  => acc := { acc with regs := acc.regs.set (regIdx dest) (destVal / srcVal) }
      | "cmp"  => acc := { acc with regs := acc.regs.set (regIdx "rflags") (compareRegs destVal srcVal) }
      | _ => continue
    | [op, dest] =>
      match op with
      | "jmp" => i := dispatchCondJmp acc dest program.labels unFlag i
      | "je"  => i := dispatchCondJmp acc dest program.labels eqFlag i
      | "jl"  => i := dispatchCondJmp acc dest program.labels ltFlag i
      | "jg"  => i := dispatchCondJmp acc dest program.labels gtFlag i
      | _     => i := i + 1
    | _ => i := i + 1

  return acc.regs.get $ regIdx "rax"

macro_rules
  | `(assemble!( $[$insts]* )) => do
    let mut labelNames : Array (TSyntax `term) := #[]
    let mut labelIndices : Array (TSyntax `term) := #[]
    let mut ops   : Array (TSyntax `term) := #[]

    for i in [:insts.size] do
      match insts[i]! with
      | `(x86_inst| $opId:ident $dest:x86_dest , $src:x86_src) =>
        match dest with
        | `(x86_dest| $destId:ident) =>
          match src with
          | `(x86_src| $srcId:ident) =>
            let opStr   := mkStrLit $ getStr opId
            let destStr := mkStrLit $ getStr destId
            let srcStr  := mkStrLit $ getStr srcId
            ops := ops.push (← `([$opStr, $destStr, $srcStr]))
          | `(x86_src| $srcN:num) =>
            let opStr   := mkStrLit $ getStr opId
            let destStr := mkStrLit $ getStr destId
            let srcStr := mkStrLit $ s!"{srcN.getNat}"
            ops := ops.push (← `([$opStr, $destStr, $srcStr]))
          | `(x86_src| -$srcN:num) =>
            let opStr   := mkStrLit $ getStr opId
            let destStr := mkStrLit $ getStr destId
            let srcStr := mkStrLit $ s!"-{srcN.getNat}"
            ops := ops.push (← `([$opStr, $destStr, $srcStr]))
          | _ => throwUnsupported
        | _ => throwUnsupported
      | `(x86_inst| $opId:ident $dest:x86_dest) =>
         match dest with
        | `(x86_dest| $destId:ident) =>
          let opStr   := mkStrLit $ getStr opId
          let destStr := mkStrLit $ getStr destId
          ops := ops.push (← `([$opStr, $destStr]))
        | _ => throwUnsupported
      | `(x86_inst| $labelId:ident :) =>
        labelNames := labelNames.push (mkStrLit $ getStr labelId)
        labelIndices := labelIndices.push (mkNumLit s!"{i}")
        ops := ops.push (← `([]))
      | _ => throwUnsupported

    `(({
        ops := #[$[$ops],*],
        labels := HashMap.ofList [ $[ ($labelNames, $labelIndices) ],* ]
      } : Program)
    )
  | `($program( $[$args],* )) => do
    let args' ← args.mapM fun a => `(($a : Int64))
    let result ← `(Program.evaluate #[$[$args'],*] $program)
    `(($result))
