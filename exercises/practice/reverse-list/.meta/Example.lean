import Extra

namespace ReverseList

@[csimp]
theorem custom_reverse_eq_spec_reverse : @Extra.custom_reverse = @List.reverse := by
  funext α
  funext xs
  induction xs with
  | nil         => rfl
  | cons x xs' ir => simpa [Extra.custom_reverse, List.reverse_cons] using ir

end ReverseList
