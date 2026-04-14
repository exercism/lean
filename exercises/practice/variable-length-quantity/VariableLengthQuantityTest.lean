import LeanTest
import VariableLengthQuantity

open LeanTest

deriving instance Repr for ByteArray

def variableLengthQuantityTests : TestSuite :=
  (TestSuite.empty "VariableLengthQuantity")
  |>.addTest "Encode a series of integers, producing a series of bytes. -> zero" (do
      let expected : ByteArray := ByteArray.mk #[
        0x00
      ]
      let input : Array Nat := #[
        0
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> arbitrary single byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x40
      ]
      let input : Array Nat := #[
        64
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> asymmetric single byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x53
      ]
      let input : Array Nat := #[
        83
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> largest single byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x7f
      ]
      let input : Array Nat := #[
        127
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> smallest double byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x81,
        0x00
      ]
      let input : Array Nat := #[
        128
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> arbitrary double byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0xc0,
        0x00
      ]
      let input : Array Nat := #[
        8192
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> asymmetric double byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x81,
        0x2d
      ]
      let input : Array Nat := #[
        173
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> largest double byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0xff,
        0x7f
      ]
      let input : Array Nat := #[
        16383
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> smallest triple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x81,
        0x80,
        0x00
      ]
      let input : Array Nat := #[
        16384
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> arbitrary triple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0xc0,
        0x80,
        0x00
      ]
      let input : Array Nat := #[
        1048576
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> asymmetric triple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x87,
        0xab,
        0x1c
      ]
      let input : Array Nat := #[
        120220
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> largest triple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0xff,
        0xff,
        0x7f
      ]
      let input : Array Nat := #[
        2097151
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> smallest quadruple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x81,
        0x80,
        0x80,
        0x00
      ]
      let input : Array Nat := #[
        2097152
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> arbitrary quadruple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0xc0,
        0x80,
        0x80,
        0x00
      ]
      let input : Array Nat := #[
        134217728
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> asymmetric quadruple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x81,
        0xd5,
        0xee,
        0x04
      ]
      let input : Array Nat := #[
        3503876
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> largest quadruple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0xff,
        0xff,
        0xff,
        0x7f
      ]
      let input : Array Nat := #[
        268435455
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> smallest quintuple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x81,
        0x80,
        0x80,
        0x80,
        0x00
      ]
      let input : Array Nat := #[
        268435456
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> arbitrary quintuple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x8f,
        0xf8,
        0x80,
        0x80,
        0x00
      ]
      let input : Array Nat := #[
        4278190080
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> asymmetric quintuple byte" (do
      let expected : ByteArray := ByteArray.mk #[
        0x88,
        0xb3,
        0x95,
        0xc2,
        0x05
      ]
      let input : Array Nat := #[
        2254790917
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> maximum 32-bit integer input" (do
      let expected : ByteArray := ByteArray.mk #[
        0x8f,
        0xff,
        0xff,
        0xff,
        0x7f
      ]
      let input : Array Nat := #[
        4294967295
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> two single-byte values" (do
      let expected : ByteArray := ByteArray.mk #[
        0x40,
        0x7f
      ]
      let input : Array Nat := #[
        64,
        127
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> two multi-byte values" (do
      let expected : ByteArray := ByteArray.mk #[
        0x81,
        0x80,
        0x00,
        0xc8,
        0xe8,
        0x56
      ]
      let input : Array Nat := #[
        16384,
        1193046
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> many multi-byte values" (do
      let expected : ByteArray := ByteArray.mk #[
        0xc0,
        0x00,
        0xc8,
        0xe8,
        0x56,
        0xff,
        0xff,
        0xff,
        0x7f,
        0x00,
        0xff,
        0x7f,
        0x81,
        0x80,
        0x00
      ]
      let input : Array Nat := #[
        8192,
        1193046,
        268435455,
        0,
        16383,
        16384
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Decode a series of bytes, producing a series of integers. -> one byte" (do
      let expected : Option (Array Nat) := some #[
        127
      ]
      let input : ByteArray := ByteArray.mk #[
        0x7f
      ]
      let actual : Option (Array Nat) := VariableLengthQuantity.decode input
      return assertEqual expected actual)
  |>.addTest "Decode a series of bytes, producing a series of integers. -> two bytes" (do
      let expected : Option (Array Nat) := some #[
        8192
      ]
      let input : ByteArray := ByteArray.mk #[
        0xc0,
        0x00
      ]
      let actual : Option (Array Nat) := VariableLengthQuantity.decode input
      return assertEqual expected actual)
  |>.addTest "Decode a series of bytes, producing a series of integers. -> three bytes" (do
      let expected : Option (Array Nat) := some #[
        2097151
      ]
      let input : ByteArray := ByteArray.mk #[
        0xff,
        0xff,
        0x7f
      ]
      let actual : Option (Array Nat) := VariableLengthQuantity.decode input
      return assertEqual expected actual)
  |>.addTest "Decode a series of bytes, producing a series of integers. -> four bytes" (do
      let expected : Option (Array Nat) := some #[
        2097152
      ]
      let input : ByteArray := ByteArray.mk #[
        0x81,
        0x80,
        0x80,
        0x00
      ]
      let actual : Option (Array Nat) := VariableLengthQuantity.decode input
      return assertEqual expected actual)
  |>.addTest "Decode a series of bytes, producing a series of integers. -> maximum 32-bit integer" (do
      let expected : Option (Array Nat) := some #[
        4294967295
      ]
      let input : ByteArray := ByteArray.mk #[
        0x8f,
        0xff,
        0xff,
        0xff,
        0x7f
      ]
      let actual : Option (Array Nat) := VariableLengthQuantity.decode input
      return assertEqual expected actual)
  |>.addTest "Decode a series of bytes, producing a series of integers. -> incomplete sequence causes error" (do
      let expected : Option (Array Nat) := none
      let input : ByteArray := ByteArray.mk #[
        0xff
      ]
      let actual : Option (Array Nat) := VariableLengthQuantity.decode input
      return assertEqual expected actual)
  |>.addTest "Decode a series of bytes, producing a series of integers. -> incomplete sequence causes error, even if value is zero" (do
      let expected : Option (Array Nat) := none
      let input : ByteArray := ByteArray.mk #[
        0x80
      ]
      let actual : Option (Array Nat) := VariableLengthQuantity.decode input
      return assertEqual expected actual)
  |>.addTest "Decode a series of bytes, producing a series of integers. -> multiple values" (do
      let expected : Option (Array Nat) := some #[
        8192,
        1193046,
        268435455,
        0,
        16383,
        16384
      ]
      let input : ByteArray := ByteArray.mk #[
        0xc0,
        0x00,
        0xc8,
        0xe8,
        0x56,
        0xff,
        0xff,
        0xff,
        0x7f,
        0x00,
        0xff,
        0x7f,
        0x81,
        0x80,
        0x00
      ]
      let actual : Option (Array Nat) := VariableLengthQuantity.decode input
      return assertEqual expected actual)
  |>.addTest "Encode a series of integers, producing a series of bytes. -> big number" (do
      let expected : ByteArray := ByteArray.mk #[
        0xc3,
        0x87,
        0x9e,
        0xe3,
        0xc9,
        0xa9,
        0xa8,
        0xd8,
        0xf3,
        0xd9,
        0x96,
        0xe5,
        0xf9,
        0x9e,
        0xdb,
        0xb8,
        0x87,
        0x8b,
        0xac,
        0xcd,
        0xe8,
        0x9e,
        0x99,
        0xfc,
        0xe6,
        0xde,
        0xb0,
        0x98,
        0x30
      ]
      let input : Array Nat := #[
        6734734192409283617213650083744412813817389736008238494387248
      ]
      let actual : ByteArray := VariableLengthQuantity.encode input
      return assertEqual expected actual)
  |>.addTest "Decode a series of bytes, producing a series of integers. -> big number" (do
      let expected : Option (Array Nat) := some #[
        553612784957720002932751723682307655243628583457373458
      ]
      let input : ByteArray := ByteArray.mk #[
        0x8b,
        0xc7,
        0xd6,
        0xcf,
        0xa5,
        0xc8,
        0xcf,
        0xc1,
        0xa5,
        0xfa,
        0x96,
        0xb7,
        0xd8,
        0xcf,
        0xcf,
        0xe6,
        0xe7,
        0xa2,
        0xd3,
        0xef,
        0xd4,
        0xf0,
        0xd6,
        0xde,
        0xfa,
        0x12
      ]
      let actual : Option (Array Nat) := VariableLengthQuantity.decode input
      return assertEqual expected actual)

def main : IO UInt32 := do
  runTestSuitesWithExitCode [variableLengthQuantityTests]
