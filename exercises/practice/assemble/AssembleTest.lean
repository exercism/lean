import LeanTest
import Assemble

open LeanTest

def assembleTests : TestSuite :=
  (TestSuite.empty "Assemble")
  |>.addTest "Copy a value" (do
      let program := assemble!(
          mov rax, rdi
      )
      return assertEqual (10) (program(10)))
  |>.addTest "Sum and subtraction" (do
      let program := assemble!(
          mov rax, rdi
          add rax, rdi
          sub rax, rsi
      )
      return assertEqual (0) (program(10, 20)))
  |>.addTest "Multiplication and division" (do
      let program := assemble!(
          mov rax, rdi
          mul rax, rdx
          div rax, rsi
      )
      return assertEqual (120) (program(100, 5, 6)))
  |>.addTest "Bitwise operations" (do
      let program := assemble!(
          or rax, rcx
          and rax, rdi
          xor rax, rsi
          shr rax, rdx
      )
      return assertEqual (16) (program(49, 16, 1, 255)))
  |>.addTest "Skip instructions" (do
      let program := assemble!(
          mov rax, rdi
          jmp end_program
          add rax, rsi
        end_program:
      )
      return assertEqual (50000000000) (program(50000000000, -3000000000)))
  |>.addTest "Condition met" (do
      let program := assemble!(
          mov rax, rdi
          cmp rax, rsi
          jg end_program
          add rax, rsi
        end_program:
      )
      return assertEqual (40010) (program(40010, -40020)))
  |>.addTest "Condition not met" (do
      let program := assemble!(
          mov rax, rdi
          cmp rax, rsi
          jl end_program
          add rax, rsi
        end_program:
      )
      return assertEqual (-200) (program(400, -600)))
  |>.addTest "Registers are case-insensitive" (do
      let program := assemble!(
          mov RAX, rdi
          SUB rax, Rsi
      )
      return assertEqual (7020) (program(4010, -3010)))
  |>.addTest "Labels are case-sensitive" (do
      let program := assemble!(
          mov rax, rdi
          cmp rax, rsi
          jg End_program
          sub rax, rsi
        End_program:
          div rax, rdx
        end_program:
      )
      return assertEqual (401) (program(4010, -3010, 10)))
  |>.addTest "All registers are used" (do
      let program := assemble!(
          mov rax, r8
          add rax, r9
          mul rax, rdx
          sub rax, rcx
          and rax, rdi
          or rax, rsi
      )
      return assertEqual (-75586) (program(4, -75590, -10, 890, 435, -235)))
  |>.addTest "Calculate the sum of the first 10 natural numbers" (do
      let program := assemble!(
        sum_first_N:
          cmp rdi, 0
          je base_case
          add rax, rdi
          sub rdi, 1
          jmp sum_first_N
        base_case:
      )
      return assertEqual (55) (program(10)))
  |>.addTest "Count how many bits are set in 2000000000" (do
      let program := assemble!(
        pop_count:
          cmp rdi, 0
          je base_case
          add rax, 1
          mov rdx, rdi
          sub rdx, 1
          and rdi, rdx
          jmp pop_count
        base_case:
      )
      return assertEqual (13) (program(2000000000)))
  |>.addTest "Count steps in the Collatz Conjecture starting with 1000000, -1 indicates error" (do
      let program := assemble!(
        steps:
          cmp rdi, 1
          jl error
          je base_case
        loop:
          add rax, 1
          mov rdx, rdi
          and rdx, 1
          cmp rdx, 0
          je even
          mul rdi, 3
          add rdi, 1
          jmp loop
        even:
          shr rdi, 1
          cmp rdi, 1
          je base_case
          jmp loop
        error:
          mov rax, -1
        base_case:
      )
      return assertEqual (152) (program(1000000)))

def main : IO UInt32 := do
  runTestSuitesWithExitCode [assembleTests]
