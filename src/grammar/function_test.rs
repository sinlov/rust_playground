// more info see https://rustlang-cn.org/office/rust/book/advanced-features/ch19-01-unsafe-rust.html
#[test]
fn funtion_access_to_external_variables() {
  let mut num = 5;
  let r1 = &num as *const i32;
  let r2 = &mut num as *mut i32;
  // let mut one = 1;
  for_external_variables(&mut *r2);
  // println!("ret {}", one);
  assert_eq!(*r1, 5);
  assert_eq!(*r2, 10);
}

fn for_external_variables(n: &mut i32) {
  unsafe {
    n = &mut 10;
  }
}

#[test]
fn funtion_access_to_external_variables_2(){
  let mut one = 1;
  out_func(&mut one);
  assert_eq!(one, 1);
}

fn out_func(n: &mut u32) {
  n = 2;
}
