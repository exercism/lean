# Instructions

In this exercise, you will define the syntax and execution model for a small language inspired by the `x86-64` assembly language.

The goal is to formalize how code is written, parsed, and executed within a constrained environment.

## Execution Model

Your assembly code will be written inside a special construct:

```lean
let program := assemble!(
    -- assembly code here
)
```

This construct must produce a **program**, which simulates a function that executes the assembly code and returns a value.
This program is then invoked using the following syntax, where `a`, `b`, `c`, etc. are arguments:

```lean
let result := program(a, b, c, ...)
```

All arguments and the return value are _64-bit signed integers_.
A maximum of _6 arguments_ is allowed.

## Registers

The return value and all arguments are passed in **registers**.
Your language must support the following registers:

| register | role         |
|----------|--------------|
| `rdi`    | 1st argument |
| `rsi`    | 2nd argument |
| `rdx`    | 3rd argument |
| `rcx`    | 4th argument |
| `r8`     | 5th argument |
| `r9`     | 6th argument |
| `rax`    | return value |

Registers start with a default value of `0`, unless they are used to pass arguments to the function.

For example, in the following program, all registers have a value of `0` with the exception of `rdi`, which is initialized with `10`, and `rsi`, which is initialized with `-20`:

```lean
program(10, -20)
```

The return value of the program is always stored in `rax`.

~~~~exercism/note
Register names are _case-insensitive_.
This means that `rax`, `RAX` and `rAx` all refer to the same register.
~~~~

## Assembly code

Each line in the assembly code can be of two forms:

- **Labels** mark specific places of the program to be used by some instructions.
- **Instructions** represent operations executed by the program.

Unless modified by some instruction, the execution flow of the program proceeds linearly.
This means that a previous line is fully executed before the line after it is executed.

### Labels

Labels have the following syntax:

```lean
<label>:
```

They do not alter the value of any register or have any effect on the program other than marking specific places of the code so they can be used by instructions.

~~~~exercism/note
Labels are _case-sensitive_.
This means that `Start`, `start` and `sTart` are all different labels.
~~~~

### Two-operand instructions

Most instructions have the following syntax:

```lean
<opcode> <destination>, <source>
```

The `opcode` indicates the operation being executed, using the values of the `destination` and `source` operands.
The result of the operation is stored in the `destination` operand.

For example, the instruction `add` sums the values in the `destination` and the `source` operands and stores this result in the `destination` operand.

The `destination` operand is _always_ a register, whereas the `source` operand may be a register or a literal number.

This is a list of instructions your program must support:

| opcode | operation performed                   |
|--------|---------------------------------------|
| `mov`  | destination := source                 |
| `add`  | destination := destination + source   |
| `sub`  | destination := destination - source   |
| `mul`  | destination := destination * source   |
| `div`  | destination := destination / source   |
| `xor`  | destination := destination ^^^ source |
| `and`  | destination := destination &&& source |
| `or`   | destination := destination \|\|\| source |
| `shl`  | destination := destination <<< source |
| `shr`  | destination := destination >>> source |

Other than those, your program must support the two-operand `cmp` instruction.

This instruction does not modify any register, but instead compares the `destination` and the `source` operands and sets an internal state of the program to one of three options:

- _greater than_, if `destination` > `source`
- _equal_, if `destination` == `source`
- _lesser than_, if `destination` < `source`

How you keep track internally of this state is up to you.

### One-operand instructions

There are some instructions that alter the flow of the program, transferring execution to another point of the code.
They are called _jumping_ instructions.

They all take just one operand, which is a label that indicates the target of the jump, i.e., the point of the code where execution will continue:

```lean
<opcode> <label>
```

The `jmp` instruction _always_ makes the jump to the target label.

Other jumping instructions make the jump only if the internal state of the program is set to a specific value.
This means they are usually preceded by a `cmp` instruction.

Those are the jumping instructions your program must support:

| instruction | operation performed                                |
|-------------|----------------------------------------------------|
| `jmp`       | unconditional jump. The jump is always performed |
| `je`        | jumps if the internal state is _equal_             |
| `jl`        | jumps if the internal state is _lesser than_         |
| `jg`        | jumps if the internal state is _greater than_      |

~~~~exercism/note
Instruction opcodes, be they two-operand or one-operand, are _case-insensitive_.
This means that `add`, `ADD` and `aDd` all refer to the same instruction.
~~~~
