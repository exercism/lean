# GenerateTestFile

This script implements utilities for generating test files for exercises in the track.

## Running the generator

Run the generator from the root folder using the following command:

```lean
bin/run-generator [Options] <exercise-slug> [Extra-Parameters]
```

The following options are available:

* `-s` or `--stub`       - Generates a stub test generator in `./generators/Generator/Generator/`
* `-a` or `--add`        - Adds a practice exercise to `./exercises/practice` and generates a test file if a test generator exists.
                           The author and the difficulty of the new exercise may be passed as extra parameters.
* `-g` or `--generate`   - Generates a test file in `./exercises/practice/<exercise-slug>/`
* `-r` or `--regenerate` - Regenerates all test files with a test generator, syncing all docs and test data.
                           This option does not take any parameters.

`<exercise-slug>` is a required parameter for all options except `--regenerate`.
The slug must be in kebab-case, for example: `two-fer`.

## Test generators

Generating test files requires a test generator in `./generators/Generator/Generator/`.

This test generator must be imported in `./generators/Generator/Generator.lean` and must define the following three functions:

1. `introGenerator    : String → String`
2. `testCaseGenerator : String → Std.TreeMap.Raw String Lean.Json → String`
3. `endBodyGenerator  : String → String`

These functions must also be added to the `dispatch` table in `./generators/Generator/Generator.lean`, using the exercise name in `PascalCase` as the key.
For example:

```lean
def dispatch : Std.HashMap String (introGenerator × testCaseGenerator × endBodyGenerator) :=
  Std.HashMap.ofList [
    ...
    ("TwoFer", (TwoFerGenerator.genIntro, TwoFerGenerator.genTestCase, TwoFerGenerator.genEnd))
    ...
  ]
```

Running the generator with `-s` or `--stub` automatically creates a stub test generator in the correct folder.
It also adds an import for it in `./generators/Generator/Generator.lean` and an entry for its functions in the `dispatch` table.

## Importing files

The test generator may `import Helper` in order to use helper functions defined in `./generators/Generator/Helper.lean`.

Note that all generator files are built by Lean each time this script runs.
Please keep dependencies to the minimum necessary.

In particular, *do not* import the entire `Lean` package.

## Adding test cases

Practice exercises get their test cases from `https://github.com/exercism/problem-specifications/`.

Additional test cases may be defined by the author in JSON format in an `extra.json` file in `exercises/practice/<exercise-slug>/.meta` folder.

The `testCaseGenerator` function is called for each case from `problem-specifications` and for any extra cases.
