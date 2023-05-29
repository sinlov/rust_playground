#[skip_serializing_none]
#[derive(Debug, Default, PartialEq, Serialize, Deserialize)]
pub struct NestStr {
    /// foo
    ///
    #[serde(default)]
    pub foo: Option<String>,
    /// bar
    ///
    #[serde(default)]
    pub bar: Option<i64>,
    /// content_str
    ///
    #[serde(default)]
    pub content_str: Option<String>,
}


/// Proto
///
/// use attribute #[serde(skip)] to skip member
#[derive(Debug, Default, PartialEq, Serialize, Deserialize)]
pub struct Proto {
    /// http
    ///
    #[serde(default)]
    pub http: String,
    /// tcp
    ///
    #[serde(default)]
    pub tcp: String,
}

#[derive(Debug, Default, PartialEq, Serialize, Deserialize)]
pub struct RequestInfo {
    /// remote_port
    ///
    #[serde(
    rename(serialize = "RemotePort", deserialize = "RemotePort"),
    default
    )]
    pub remote_port: String,
    /// subdomain
    ///
    #[serde(
    rename(serialize = "Subdomain", deserialize = "Subdomain"),
    default
    )]
    pub subdomain: String,
    /// hostname
    ///
    #[serde(
    rename(serialize = "Hostname", deserialize = "Hostname"),
    default
    )]
    pub hostname: String,
    /// http_auth
    ///
    #[serde(
    rename(serialize = "HttpAuth", deserialize = "HttpAuth"),
    default
    )]
    pub http_auth: String,
    /// proto
    ///
    #[serde(
    rename(serialize = "Proto", deserialize = "Proto"),
    default
    )]
    pub proto: Proto,
}


#[test]
fn serde_from_json_file_nest_str() {
    let mut src_paths: PathBuf = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    src_paths.push("src");
    let json_file_path = Path::new(&src_paths)
        .join("tools")
        .join("mockData")
        .join("nest_str.json");
    println!("nest_str file: {:?}", json_file_path);

    let mut json_file = match File::open(&json_file_path) {
        Err(why) => panic!("couldn't open {}: {}", json_file_path.display(), why),
        Ok(json_strict_pkg) => json_strict_pkg,
    };
    let mut json_file_content = String::new();
    match json_file.read_to_string(&mut json_file_content) {
        Err(why) => {
            panic!("couldn't read {}: {}", json_file_path.display(), why)
        }
        Ok(_) => {
            // print!("{} contains:\n{}", json_file_path.display(), json_strict_pkg_content)
        }
    }

    let nest_str: NestStr = match serde_json::from_str(&json_file_content) {
        Err(why) => panic!("couldn't cover {} err: {}", json_file_path.display(), why),
        Ok(nest_str) => nest_str,
    };

    let content_str = nest_str.content_str.unwrap();
    let request_info: RequestInfo = match serde_json::from_str(&content_str) {
        Err(why) => panic!("couldn't cover {} err: {}", content_str, why),
        Ok(request_info) => request_info,
    };
    assert_eq!(request_info.subdomain, "sunny");


    let request_info_str = serde_json::to_string(&request_info).unwrap();
    println!("request_info_str: {}", request_info_str);
    assert_ne!(request_info_str, "");
}