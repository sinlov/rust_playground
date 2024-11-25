
[![ci](https://github.com/sinlov/rust_playground/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/sinlov/rust_playground/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/sinlov/rust_playground/branch/main/graph/badge.svg)](https://app.codecov.io/gh/sinlov/rust_playground/tree/main)

[![deps.rs dependency](https://deps.rs/repo/github/sinlov/rust_playground/status.svg)](https://deps.rs/repo/github/sinlov/rust_playground)

[![GitHub license](https://img.shields.io/github/license/sinlov/rust_playground)](https://github.com/sinlov/rust_playground)
[![GitHub latest SemVer tag)](https://img.shields.io/github/v/tag/sinlov/rust_playground)](https://github.com/sinlov/rust_playground/tags)
[![GitHub release)](https://img.shields.io/github/v/release/sinlov/rust_playground)](https://github.com/sinlov/rust_playground/releases)

## Contributing

[![Contributor Covenant](https://img.shields.io/badge/contributor%20covenant-v1.4-ff69b4.svg)](.github/CONTRIBUTING_DOC/CODE_OF_CONDUCT.md)
[![GitHub contributors](https://img.shields.io/github/contributors/sinlov/rust_playground)](https://github.com/sinlov/rust_playground/graphs/contributors)

We welcome community contributions to this project.

Please read [Contributor Guide](.github/CONTRIBUTING_DOC/CONTRIBUTING.md) for more information on how to get started.

请阅读有关 [贡献者指南](.github/CONTRIBUTING_DOC/zh-CN/CONTRIBUTING.md) 以获取更多如何入门的信息


# this is rust code playground

If you do not have Rust setup, please visit [rust-lang.org](https://www.rust-lang.org/) for operating specific instructions.
In order to run the test case you need Rust installed. To check your installations simply type:

edition = "2021"

```
$ rustc --version
$ cargo --version
```
Currently, a Rust version of 1.56.0 or higher

can run this project version is


- rustc 1.56+
- cargo 1.56+

# how to use

```sh
# see help
make help
# run test grammar
make run.grammar

# run test tools
make run.tools

# clean build
make clean.all
```

- `make run.grammar` and default env `TEST_FILTER=grammar` will generate the `path_to_grammar.rs` file and populate it with the first test in the list.
- After supplying an answer for the first test case.
- entering `cargo run` again will continue you on your `src/grammar`path, with config file `src/grammar.txt`

### when build error ?

```sh
# use CLI to clean build
make clean.all
```

### how windows build this project?

install rust with rustup-init.exe in https://www.rust-lang.org/tools/install open with Windows!

```bash
cargo run
# if error use
rd /s /Q .\target
del .\src\path_to_grammar.rs
```

### how to add new case group grammar?

add new case file at `src/grammar.txt` with name of `src/grammar` file

### how to add new case group tools?

add new case file at `src/tools.txt` with name of `src/tools` file

