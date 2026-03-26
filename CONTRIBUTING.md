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

### Adding an exercise

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

[guidelines]: https://exercism.org/blog/contribution-guidelines-nov-2023
[lean-forum]: https://forum.exercism.org/c/programming/lean/761
[style]: https://exercism.org/docs/building/markdown/style-guide
[contributors-pr-guide]: https://exercism.org/docs/building/github/contributors-pull-request-guide
[pr-guide]: https://exercism.org/docs/community/being-a-good-community-member/pull-requests
[unnecessary-test-runs]: https://exercism.org/docs/building/tracks#h-avoiding-triggering-unnecessary-test-runs
[add-exercise]: https://exercism.org/docs/building/tracks/practice-exercises/add
[generator-doc]: generators/GenerateTestFile.md
