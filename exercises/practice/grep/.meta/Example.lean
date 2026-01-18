import Std

namespace Grep

def aggregateResults (results : List String) (prepend : String := "") : String :=
  results.foldl (fun acc x => (prepend ++ x ++ "\n" ++ acc).trim) ""

def processFile
  (check : String -> Bool)
  (getResult : Nat -> String -> String -> String)
  (file : String) : IO (Except String (List String)) := do
    try
      let fileContent ← IO.FS.readFile file
      let mut results := []
      let lines := fileContent.splitOn "\n" |> (·.toArray)
      for idx in [:lines.size] do
        let line := lines[idx]!
        if check line then
          results := (getResult (idx + 1) line file) :: results
      return (.ok results)
    catch e =>
      return (.error e.toString)

def processGrep
  (pattern : String)
  (flags : List String)
  (files : List String) : IO Unit := do
    let flagsSet := Std.HashSet.ofList flags
    let adjustedPattern :=
      if flagsSet.contains "-i" then
        pattern.toLower
      else
        pattern
    let formatLine :=
      if flagsSet.contains "-i" then
        fun line => String.toLower line
      else
        fun line => line
    let getResult :=
      if flagsSet.contains "-n" then
        fun (idx : Nat) (line : String) _ => s!"{idx}:{line}"
      else
        fun _ line _ => line
    let compare :=
      if flagsSet.contains "-x" then
        fun (line : String) => s!"{formatLine line}" == adjustedPattern
      else
        fun (line : String) => formatLine line |> (·.toSlice.contains adjustedPattern)
    let check :=
      if flagsSet.contains "-v" then
        fun line => !(compare line)
      else
        compare
    match files with
    | [] => return
    | file :: [] =>
      let maybeResults <- processFile check getResult file
      match maybeResults with
      | .error _ =>
        IO.eprintln "File not found"
      | .ok results =>
        let validResults := results.filter (·!="")
        if validResults.isEmpty then
          return
        else if flagsSet.contains "-l" then
          IO.println file
        else
          IO.println (aggregateResults validResults)
    | _ =>
      for file in files do
        let maybeResults <- processFile check getResult file
        match maybeResults with
        | .error _ =>
          IO.eprintln "File not found"
        | .ok results =>
          let validResults := results.filter (·!="")
          if validResults.isEmpty then
            continue
          else if flagsSet.contains "-l" then
            IO.println file
          else
            IO.println (aggregateResults validResults s!"{file}:")

def grep (args : List String) : IO Unit := do
  match args with
  | [] => IO.eprintln "Called without arguments"
  | _ :: [] => IO.eprintln "Called without a file name"
  | pattern :: xs =>
    let flags := xs.takeWhile (fun flag => flag.startsWith "-")
    let files := xs.dropWhile (fun flag => flag.startsWith "-")
    processGrep pattern flags files

end Grep
