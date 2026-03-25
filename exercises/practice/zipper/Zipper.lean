namespace Zipper

/-
  You should define:

  1. A `BinTree` type representing a binary tree where each node
     has a value, a left subtree, and a right subtree.

  2. A `Zipper` type that allows navigating within a binary tree.

  3. The following functions:
     - `fromTree`  : Create a zipper focused on the root of a tree.
     - `toTree`    : Reconstruct the full tree from a zipper.
     - `value`     : Get the value of the focused node.
     - `left`      : Move focus to the left child (returns Option).
     - `right`     : Move focus to the right child (returns Option).
     - `up`        : Move focus to the parent (returns Option).
     - `setValue`  : Set the value of the focused node.
     - `setLeft`   : Set the left subtree of the focused node.
     - `setRight`  : Set the right subtree of the focused node.
-/

end Zipper
