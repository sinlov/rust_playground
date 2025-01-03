#[cfg(not(test))]
use std::process::Command;

#[cfg(not(test))]
use std::fs::{File, OpenOptions};

#[cfg(not(test))]
use std::io::{BufRead, BufReader, Write};

#[cfg(not(test))]
use std::env::var;

#[cfg(not(tarpaulin_include))]
#[cfg(not(test))]
fn main() {
    let test_case = var("TEST_FILTER").unwrap_or("grammar".to_string());
    match test_case {
        ref s if s == "grammar" => {
            println!("=> Run {} group.", s);
            run_item_group_by_name(s);
        }
        ref s if s == "tools" => {
            println!("=> Run {} group.", s);
            run_item_group_by_name(s);
        }
        ref s if s == "thread_exp" => {
            println!("=> Run {} group.", s);
            run_item_group_by_name(s);
        }
        _ => println!(
            "ERROR: env TEST_FILTER {} not support please check input!",
            test_case
        ),
    }
}

#[cfg(not(test))]
fn seek_the_target_path(name: &str) -> bool {
    let mut target =
        BufReader::new(File::open(format!("src/1_group_settings/{}.txt", name)).unwrap()).lines();
    let mut path = OpenOptions::new()
        .read(true)
        .append(true)
        .open(format!("src/path_to_{}.rs", name))
        .unwrap();
    let passed_count = BufReader::new(&path).lines().count();

    if let Some(Ok(next_target)) = target.nth(passed_count) {
        println!("=> Next group is: {}.", next_target);
        writeln!(&mut path, "{}!(\"{}\");", name, next_target).unwrap();
        true
    } else {
        println!("There will be no more tasks.");
        false
    }
}

#[cfg(not(test))]
fn run_item_group_by_name(group_name: &str) {
    let message = if walk_the_target_path() {
        if seek_the_target_path(group_name) {
            "Long road, only the bug(with you?)."
        } else {
            "Climb up the mountain and see the new sea!"
        }
    } else {
        "Meditate on your approach and return. Mountains are merely mountains."
    };
    println!("{}", message);
}

#[cfg(not(test))]
fn walk_the_target_path() -> bool {
    Command::new("cargo")
        .arg("test")
        .arg("-q")
        // .arg("--verbose")
        .arg("--color")
        .arg("always")
        .arg("--")
        .arg("--nocapture") // https://stackoverflow.com/questions/25106554/why-doesnt-println-work-in-rust-unit-tests
        .status()
        .unwrap()
        .success()
}

#[allow(unused_macros)]
macro_rules! grammar {
    ($name:expr) => {
        include!(concat!("grammar/", $name, ".rs"));
    };
}

#[cfg(test)]
mod path_to_grammar;

#[allow(unused_macros)]
macro_rules! tools {
    ($name:expr) => {
        include!(concat!("tools/", $name, ".rs"));
    };
}

#[cfg(test)]
mod path_to_tools;

#[allow(unused_macros)]
macro_rules! thread_exp {
    ($name:expr) => {
        include!(concat!("thread_exp/", $name, ".rs"));
    };
}

#[cfg(test)]
mod path_to_thread_exp;
