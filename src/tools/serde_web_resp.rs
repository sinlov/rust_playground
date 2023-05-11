use serde_json;

#[derive(Serialize)]
struct Resp<T> {
    code: u16,
    msg: String,
    #[serde(default)]
    data: Option<T>,
}


impl<T> Resp<T> {
    fn success(data: Option<T>) -> Self {
        Resp {
            code: 1,
            msg: "success".to_string(),
            data,
        }
    }
}

impl<T> Resp<T> {
    fn fail(code: u16, msg: String) -> Self {
        Resp {
            code,
            msg,
            data: None,
        }
    }
}


#[test]
fn serde_web_resp() {
    let rsp: Resp<()> = Resp::fail(100, "some thing wrong".to_string());
    assert_eq!(100, rsp.code);
    let res = Resp::success(Some("hello".to_string()));
    assert_eq!(1, res.code);
    match serde_json::to_string(&res){
        Ok(s) => println!("s: {}", s),
        Err(e) => println!("e: {}", e),
    }
}


