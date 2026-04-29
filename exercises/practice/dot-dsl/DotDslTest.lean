import LeanTest
import Extra
import DotDsl

open LeanTest

def dotDslTests : TestSuite :=
  (TestSuite.empty "DotDsl")
    |>.addTest "empty graph" (do
        let tree : Extra.Tree := {
          nodes := #[],
          edges := #[],
          attrs := #[]
        }
        return assertEqual tree graph {
        })
    |>.addTest "graph with one node" (do
        let tree : Extra.Tree := {
          nodes := #[{
            name := "a",
            attrs := #[]
          }],
          edges := #[],
          attrs := #[]
        }
        return assertEqual tree graph {
            a;
        })
    |>.addTest "graph with one node with attribute" (do
        let tree : Extra.Tree := {
          nodes := #[{
            name := "a",
            attrs := #[⟨"color", "green"⟩]
          }],
          edges := #[],
          attrs := #[]
        }
        return assertEqual tree graph {
            a [color=green];
        })
    |>.addTest "graph with one edge" (do
        let tree : Extra.Tree := {
          nodes := #[{
            name := "a",
            attrs := #[]
          },
          {
            name := "b",
            attrs := #[]
          }],
          edges := #[{
            node₁ := ⟨"a", #[]⟩,
            node₂ := ⟨"b", #[]⟩,
            attrs := #[]
          }],
          attrs := #[]
        }
        return assertEqual tree graph {
            a - b;
        })
    |>.addTest "graph with one attribute" (do
        let tree : Extra.Tree := {
          nodes := #[],
          edges := #[],
          attrs := #[
            ⟨"foo", "1"⟩
          ]
        }
        return assertEqual tree graph {
            [foo=1];
        })
    |>.addTest "graph with comments" (do
        let tree : Extra.Tree := {
          nodes := #[],
          edges := #[],
          attrs := #[
            ⟨"foo", "1"⟩
          ]
        }
        return assertEqual tree graph {
            // a C-like comment;
            # a shell-like comment;
            [foo=1];
        })
    |>.addTest "graph with nodes, edges, and attributes" (do
        let tree : Extra.Tree := {
          nodes := #[{
            name := "a",
            attrs := #[⟨"color", "green"⟩]
          },
          {
            name := "b",
            attrs := #[⟨"label", "Beta!"⟩]
          },
          {
            name := "c",
            attrs := #[]
          }],
          edges := #[{
            node₁ := ⟨"a", #[]⟩,
            node₂ := ⟨"b", #[]⟩,
            attrs := #[⟨"color", "blue"⟩]
          },
          {
            node₁ := ⟨"b", #[]⟩,
            node₂ := ⟨"c", #[]⟩,
            attrs := #[]
          }],
          attrs := #[
            ⟨"bar", "true"⟩,
            ⟨"foo", "1"⟩,
            ⟨"title", "Testing Attrs"⟩
          ]
        }
        return assertEqual tree graph {
            [foo=1];
            [title="Testing Attrs"];
            a [color=green];
            b [label="Beta!"];
            b - c;
            a - b [color=blue];
            [bar=true];
        })
    |>.addTest "multiple edges on one line" (do
        let tree : Extra.Tree := {
          nodes := #[{
            name := "a",
            attrs := #[]
          },
          {
            name := "b",
            attrs := #[]
          },
          {
            name := "c",
            attrs := #[]
          },
          {
            name := "d",
            attrs := #[]
          }],
          edges := #[{
            node₁ := ⟨"a", #[]⟩,
            node₂ := ⟨"b", #[]⟩,
            attrs := #[⟨"style", "dotted"⟩]
          },
          {
            node₁ := ⟨"b", #[]⟩,
            node₂ := ⟨"c", #[]⟩,
            attrs := #[⟨"style", "dotted"⟩]
          },
          {
            node₁ := ⟨"c", #[]⟩,
            node₂ := ⟨"d", #[]⟩,
            attrs := #[⟨"style", "dotted"⟩]
          }],
          attrs := #[]
        }
        return assertEqual tree graph {
            a - b - c - d [style=dotted];
        })
    |>.addTest "only 1 edge between nodes" (do
        let tree : Extra.Tree := {
          nodes := #[{
            name := "a",
            attrs := #[]
          },
          {
            name := "b",
            attrs := #[]
          }],
          edges := #[{
            node₁ := ⟨"a", #[]⟩,
            node₂ := ⟨"b", #[]⟩,
            attrs := #[⟨"color", "blue"⟩]
          }],
          attrs := #[]
        }
        return assertEqual tree graph {
            a - b;
            a - b;
            b - a [color=blue];
        })

def main : IO UInt32 := do
  runTestSuitesWithExitCode [dotDslTests]
