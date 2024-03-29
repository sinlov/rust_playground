use std::fs::OpenOptions;
use std::io::{ErrorKind, Write};

fn main() {
    init_test_case_by_name("grammar");
    init_test_case_by_name("tools");
}

fn init_test_case_by_name(name: &str) {
    let path = OpenOptions::new()
        .create_new(true)
        .write(true)
        .open(format!("src/path_to_{}.rs", name));

    match path {
        Err(error) => match error.kind() {
            ErrorKind::AlreadyExists => {}
            _ => panic!("{}", error),
        },
        Ok(f) => {
            let content = format!("{}!(\"0_base_test\");", name);
            writeln!(&f, "{}", content).unwrap();
        }
    }
}
