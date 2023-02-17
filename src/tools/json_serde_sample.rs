use serde_derive::{Deserialize, Serialize};

/// Point
///
#[derive(Debug, Default, PartialEq, Serialize, Deserialize)]
pub struct Point {
    /// x
    ///
    #[serde(rename(serialize = "x", deserialize = "x"),default)]
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