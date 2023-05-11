#[test]
fn string_type() {
    let speech = "\"Ouch!\" said the well.\n";

    println!("{}", speech);

    println!("In the room the women come and go,
    Singing of Mount Abora");

    // use \ to remove start white word
    println!("In was a bright, cold day in April, and \
    there ware four of us-\
    more or less.");

    // use raw string
    let default_win_install_path = r"C:\Program Files\WindowsApps";
    println!("{}", default_win_install_path);

    // but r mark can not let " use, so add #, # is more than one.
    let raw_str = r###"
    This raw string started with 'r###"'.
    Therefore it does not end until we reach a quote mark ('"')
    followed immediately by three pound signs ('###'):
    "###;
    println!("{}", raw_str.to_string());

    let pkg_json = r###"
    {"version": "0.1.2"}
    "###.to_string();

    println!("{}", pkg_json.to_string());
}

#[test]
fn byte_string() {
    // byte string is u8 not unicode
    let method = b"GET";
    // method type is &[u8; 3]
    assert_eq!(method, &[b'G', b'E', b'T']);
}

#[test]
fn string_mem() {
    let noodles = "noodles".to_string();
    println!("{}", noodles);
    let oodles = &noodles[1..];
    println!("{}", oodles);
    let poodles = "ಠ_ಠ";
    assert_eq!(poodles.len(), 7);
    // to chars will Returns an iterator over the chars of a string slice.
    assert_eq!(poodles.chars().count(), 3);
    // do not to change value about &str read as "stri"

    // &mut str only has method
    let change_noodles = "noodles";
    let mut bind_noodles = change_noodles.to_string();
    // make_ascii_uppercase
    bind_noodles.make_ascii_uppercase();
    assert_eq!(bind_noodles, "NOODLES");
    // make_ascii_lowercase
    bind_noodles.make_ascii_lowercase();
    assert_eq!(bind_noodles, "noodles");
}