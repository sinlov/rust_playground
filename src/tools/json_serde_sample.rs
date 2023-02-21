use std::fs::File;
use std::io::Read;
use std::path::{Path, PathBuf};
use serde_derive::{Deserialize, Serialize};

/// Point
///
#[derive(Debug, Default, PartialEq, Serialize, Deserialize)]
pub struct Point {
    /// x
    ///
    #[serde(rename(serialize = "x", deserialize = "x"), default)]
    pub x: i64,

    /// y
    ///
    #[serde(default)]
    pub y: i64,
}

#[test]
fn serde_sample_serialized() {
    let point = Point { x: 1, y: 2 };
    // Convert the Point to a JSON string.
    let serialized = serde_json::to_string(&point).unwrap();
    // println!("serialized = {}", serialized);
    assert_eq!(r#"{"x":1,"y":2}"#, serialized);

    // Convert the JSON string back to a Point.
    let deserialized: Point = serde_json::from_str(&serialized).unwrap();
    println!("deserialized = {:#?}", deserialized);
    assert_eq!(1, deserialized.x);
    assert_eq!(2, deserialized.y);

    assert_eq!(point, deserialized);

    let json_str = r#"{"x":1}"#;
    let deserialized: Point = serde_json::from_str(&json_str).unwrap();
    assert_eq!(1, deserialized.x);
    assert_eq!(0, deserialized.y);
}

#[test]
fn serde_format_by_json_txt() {
    let mut src_paths: PathBuf = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    src_paths.push("src");
    let json_strict_pkg_path = Path::new(&src_paths)
        .join("tools")
        .join("mockData")
        .join("json_strict_pkg.json");
    println!("json_strict_pkg_path file: {:?}", json_strict_pkg_path);

    let mut json_strict_pkg = match File::open(&json_strict_pkg_path) {
        Err(why) => panic!("couldn't open {}: {}", json_strict_pkg_path.display(), why),
        Ok(json_strict_pkg) => json_strict_pkg,
    };
    let mut json_strict_pkg_content = String::new();
    match json_strict_pkg.read_to_string(&mut json_strict_pkg_content) {
        Err(why) => {
            panic!("couldn't read {}: {}", json_strict_pkg_path.display(), why)
        }
        Ok(_) => {
            // print!("{} contains:\n{}", json_strict_pkg_path.display(), json_strict_pkg_content)
        }
    }
    let strict_npm_config: NpmConfigDefine = serde_json::from_str(&json_strict_pkg_content).unwrap();
    // println!("strict_npm_config = {:#?}", strict_npm_config);
    assert_eq!("rust-cli-basic", strict_npm_config.name);
    assert_eq!("Apache License 2.0", strict_npm_config.license);

    let json_tag_pkg_path = Path::new(&src_paths)
        .join("tools")
        .join("mockData")
        .join("json_tag_pkg.json");
    println!("json_tag_pag_path file: {:?}", json_tag_pkg_path);

    let mut json_tag_pkg = match File::open(&json_tag_pkg_path) {
        Err(why) => panic!("couldn't open {}: {}", json_tag_pkg_path.display(), why),
        Ok(json_tag_pkg) => json_tag_pkg,
    };
    let mut json_tag_pkg_content = String::new();
    match json_tag_pkg.read_to_string(&mut json_tag_pkg_content) {
        Err(why) => {
            panic!("couldn't read {}: {}", json_tag_pkg_path.display(), why)
        }
        Ok(_) => {
            // print!("{} contains:\n{}", json_tag_pkg_path.display(), json_tag_pkg_content)
        }
    }
    let tag_npm_config: NpmConfigDefine = match serde_json::from_str(&json_tag_pkg_content)
    {
        Err(why) => panic!("couldn't parse {}: {}", json_tag_pkg_path.display(), why),
        Ok(tag_npm_config) => tag_npm_config,
    };
    // println!("tag_npm_config = {:#?}", tag_npm_config);
    assert_eq!("rust-cli-basic", tag_npm_config.name);
    assert_eq!("Apache License 2.0", tag_npm_config.license);
}