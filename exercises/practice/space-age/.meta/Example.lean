namespace SpaceAge

inductive Planet where
  | Mercury : Planet
  | Venus  : Planet
  | Mars : Planet
  | Earth : Planet
  | Jupiter : Planet
  | Saturn : Planet
  | Uranus : Planet
  | Neptune : Planet

def earthlyPeriodInSeconds : Float := 60 * 60 * 24 * 365.25

def period : Planet -> Float
  | .Mercury  =>  0.2408467
  | .Venus    =>  0.61519726
  | .Earth    =>  1.0
  | .Mars     =>  1.8808158
  | .Jupiter  =>  11.862615
  | .Saturn   =>  29.447498
  | .Uranus   =>  84.016846
  | .Neptune  =>  164.79132

def age (planet : Planet) (seconds : Nat) : Float :=
  (seconds.toFloat / earthlyPeriodInSeconds) / period planet

end SpaceAge
