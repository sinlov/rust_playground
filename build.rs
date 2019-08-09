use std::fs::{OpenOptions};
use std::io::{Write,ErrorKind};

fn main() {
    let path = OpenOptions::new().create_new(true)
        .write(true)
        .open("src/path_to_grammar.rs");

    match path {
        Err(error) => {
            match error.kind() {
                ErrorKind::AlreadyExists => {},
                _ => panic!("{}", error),
            }
        },
        Ok(f) => {
            write!(&f, "grammar!(\"0_base_test\");\n").unwrap();
        },
    }
}