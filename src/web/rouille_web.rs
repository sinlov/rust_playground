extern crate rouille;
use rouille::Response;
use std::env::var;

fn run_web() {
    rouille::start_server(format!("0.0.0.0:{}", var("PORT").unwrap_or("30080".to_string())), move |_request| {
        Response::text("Hello, world!")
    });
}