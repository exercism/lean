# Topologically sorts the top-level `concepts` array and the
# `exercises.concept` array of a track `config.json`, so that every concept
# exercise appears after every concept exercise that teaches one of its
# prerequisites. Ties are broken by preserving the original relative order
# (a stable sort), so unrelated concepts keep their existing sequence.
#
# This assumes the concept-exercise graph is already valid: every
# prerequisite is taught by exactly one concept exercise, no two exercises
# teach the same concept, and there are no cycles. `configlet lint` enforces
# all of that separately. This script defensively halts with an error if it
# still finds a prerequisite with no owning exercise, or a cycle, rather than
# producing a silently wrong order.
#
# Usage: jq -f bin/sort-concepts.jq config.json

def owner_map:
  reduce (.exercises.concept // [])[] as $e ({};
    reduce ($e.concepts // [])[] as $c (.; .[$c] = $e.slug));

. as $config
| ($config | owner_map) as $owner
| ($config.exercises.concept // []) as $conceptExercises
| (
    [ $conceptExercises[] as $e
      | ($e.prerequisites // [])[] as $p
      | select($owner[$p] == null)
      | "concept exercise '\($e.slug)' has prerequisite '\($p)', which is not taught by any concept exercise"
    ]
  ) as $unresolved
| if ($unresolved | length) > 0 then
    ($unresolved | join("\n")) | halt_error
  else . end
| {remaining: $conceptExercises, placed: [], placedSlugs: []}
| until(.remaining == [];
    .placedSlugs as $placedSlugs
    | (.remaining | map(select(
        (.prerequisites // []) | all(. as $p | ($owner[$p]) as $o | ($placedSlugs | index($o)) != null)
      ))) as $ready
    | if ($ready | length) == 0 then
        ("cycle (or unresolved ordering) among concept exercises: " +
          ([.remaining[].slug] | join(", "))) | halt_error
      else . end
    | .placed += $ready
    | .placedSlugs += ($ready | map(.slug))
    | .remaining -= $ready
  )
| .placed as $placedExercises
| ($placedExercises | map(.concepts[]?)) as $taughtInOrder
| ($config.concepts // []) as $concepts
| ($concepts | map(.slug)) as $originalConceptSlugs
| ($originalConceptSlugs - $taughtInOrder) as $untaught
| ($taughtInOrder + $untaught) as $newConceptSlugOrder
| ($concepts | map({(.slug): .}) | add // {}) as $conceptBySlug
| ($newConceptSlugOrder | map($conceptBySlug[.])) as $newConcepts
| $config
| .exercises.concept = $placedExercises
| .concepts = $newConcepts
