#[cfg(not(test))]
use std::process::Command;

#[cfg(not(test))]
use std::fs::{File, OpenOptions};

#[cfg(not(test))]
use std::io::{BufRead, BufReader, Write};

#[cfg(not(test))]

#[cfg(not(test))]
fn main() {
    let message = if walk_the_path() {
        if seek_the_path() {
            "Long road, only the bug(with you?)."
        } else {
            "Climb up the mountain and see the new sea!"
        }
    } else {
        "Meditate on your approach and return. Mountains are merely mountains."
    };

    println!("{}", message);
}


#[allow(unused_macros)]
macro_rules! grammar {
    ($name:expr) => (
        include!(concat!("grammar/", $name, ".rs"));
    );
}

#[cfg(not(test))]
fn seek_the_path() -> bool {
    let mut grammar = BufReader::new(File::open("src/grammar.txt").unwrap()).lines();
    let mut path = OpenOptions::new()
        .read(true)
        .append(true)
        .open("src/path_to_grammar.rs")
        .unwrap();
    let passed_count = BufReader::new(&path).lines().count();

    if let Some(Ok(next_grammar)) = grammar.nth(passed_count) {
        println!("=> Next group is: {}.", next_grammar);
        write!(&mut path, "grammar!(\"{}\");\n", next_grammar).unwrap();
        true
    } else {
        println!("There will be no more tasks.");
        false
    }
}

#[cfg(not(test))]
fn walk_the_path() -> bool {
    Command::new("cargo")
        .arg("test")
        .arg("-q")
        .status()
        .unwrap()
        .success()
}

#[cfg(test)]
mod path_to_grammar;