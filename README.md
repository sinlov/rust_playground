# this is my rust code playgound

If you do not have Rust setup, please visit [rust-lang.org](https://www.rust-lang.org/) for operating specific instructions.
In order to run the test case you need Rust installed. To check your installations simply type:

```
$ rustc --version
$ cargo --version
```
Currently, a Rust version of 1.3.0 or higher

can run this project version is

- rustc 1.36.0
- cargo 1.36.0

# how to use

```sh
# see help
make help
# run test
make run

# clean build
make cleanAll
# only support make run
```

- `make run` will generate the `path_to_grammar.rs` file and populate it with the first test in the list.
- After supplying an answer for the first test case.
- entering `cargo run` again will continue you on your `src/grammar`path, with config file `src/grammar.txt`

## when build error

```sh
# use CLI to clean build
make cleanAll
```

## how to add new case group

add new case file at `src/grammar.txt` with name of `src/grammar` file




