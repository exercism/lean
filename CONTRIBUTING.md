# How to contribute to the Exercism Lean track

## Contributing

We 💙 our community, but **this repository does not accept unsolicited pull requests at this time**.

Please read this [community blog post][guidelines] for details.

### How to contribute

1. Open a topic on the [Lean forum][lean-forum]
2. Discuss the proposal with the maintainers
3. After receiving the go-ahead, submit a pull request

Pull requests are automatically closed and will **remain closed until approved by a maintainer**.

Pull requests must follow [Exercism's style guide][style].

Before submitting, please read:

- [Contributors Pull Request Guide][contributors-pr-guide]
- [Pull Request Guide][pr-guide]

When opening a PR:

- Clearly describe the problem and the solution
- Link to the corresponding forum discussion
- Add a link to the PR in that same discussion

If the PR touches an existing exercise, please also consider [this warning][unnecessary-test-runs].

### Using LLMs 

Exercism is both an educational platform and an open-source project.
As such, open issues in this track are not only about solving problems or adding content, but also about _involving the community_ and _providing opportunities for students to learn_.

Although the use of LLMs is not forbidden, they should be treated as an **auxiliary educational tool**.
Pull requests with reduced code quality or that fail to conform to our guidelines may be closed.

### Adding a Practice exercise

Practice exercises must follow the [Add a Practice Exercise docs][add-exercise].

All exercises must include a test generator located in:

```text
generator/Generator/Generator
```

The generator must:

- be imported by `generator/Generator/Generator.lean`
- define the required generator functions
- register them in the `dispatch` table

The Lean track provides a generator script to help with this process.
See the [generator documentation][generator-doc].

**The test file must be generated from its test generator using the generator script.**

After adding an exercise, run the `bin/sort-exercises` script to ensure the correct order in `config.json`.

### Adding a concept exercise

Concept exercises must be scaffolded with:

```text
bin/fetch-configlet && bin/configlet create --concept-exercise <slug>
```

Each concept exercise teaches exactly one concept, and has a matching `concepts/<slug>/` doc set.
This track requires two extra rules on top of Exercism's usual concept exercise guidelines, both enforced by a CI workflow:

- A concept exercise's `.docs/introduction.md` must be generated from its concept's `introduction.md`.
  Write a `.docs/introduction.md.tpl` file with a single `%{concept: <slug>}` placeholder, then run `bin/sync-concept-introductions`.
- `config.json`'s `concepts` and `exercises.concept` arrays must list no exercise before any of its prerequisites.

Concept exercises must include a test generator located in:

```text
generator/Generator/Generator
```

The generator must:

- be imported by `generator/Generator/Generator.lean`
- define the required generator functions
- register them in the `dispatch` table

The Lean track provides a generator script to help with this process.
See the [generator documentation][generator-doc].

**The test file must be generated from its test generator using the generator script.**

After adding or reordering a concept exercise, run `bin/sort-concepts` to ensure the correct order in `config.json`.

[guidelines]: https://exercism.org/blog/contribution-guidelines-nov-2023
[lean-forum]: https://forum.exercism.org/c/programming/lean/761
[style]: https://exercism.org/docs/building/markdown/style-guide
[contributors-pr-guide]: https://exercism.org/docs/building/github/contributors-pull-request-guide
[pr-guide]: https://exercism.org/docs/community/being-a-good-community-member/pull-requests
[unnecessary-test-runs]: https://exercism.org/docs/building/tracks#h-avoiding-triggering-unnecessary-test-runs
[add-exercise]: https://exercism.org/docs/building/tracks/practice-exercises/add
[generator-doc]: generators/GenerateTestFile.md
