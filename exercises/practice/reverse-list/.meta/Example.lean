import Spec

namespace ReverseList

@[csimp]
theorem custom_reverse_eq_spec_reverse : @Spec.custom_reverse = @List.reverse := by
  funext α
  funext xs
  induction xs with
  | nil         => rfl
  | cons x xs' ir => simpa [Spec.custom_reverse, List.reverse_cons] using ir

end ReverseList
