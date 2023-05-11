[![rust-ci](https://github.com/sinlov/rust_playground/actions/workflows/rust-ci.yml/badge.svg?branch=main)](https://github.com/sinlov/rust_playground/actions/workflows/rust-ci.yml)
[![codecov](https://codecov.io/gh/sinlov/rust_playground/branch/main/graph/badge.svg)](https://app.codecov.io/gh/sinlov/rust_playground/tree/main)

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
make runGrammar

# run test tools
make runTools

# clean build
make cleanAll
```

- `make runGrammar` and default env `TEST_FILTER=grammar` will generate the `path_to_grammar.rs` file and populate it with the first test in the list.
- After supplying an answer for the first test case.
- entering `cargo run` again will continue you on your `src/grammar`path, with config file `src/grammar.txt`

### when build error ?

```sh
# use CLI to clean build
make cleanAll
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

