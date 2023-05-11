fn print_slice_demo(n: &[f64]) {
    for elt in n {
        println!("{}", elt);
    }
}

#[test]
fn slice_type() {
    let v: Vec<f64> = vec![0.0, 0.707, 1.0, 0.707];
    let a:[f64; 4] = [0.0, 0.707, 1.0, 0.707];

    let sv: &[f64] = &v;
    let sa: &[f64] = &a;
    // slice refence is fat pointer
    print_slice_demo(&v);
    print_slice_demo(&a);

    print_slice_demo(&v[0..2]);
    print_slice_demo(&a[2..]);
    print_slice_demo(&sv[1..3]);
    print_slice_demo(&sa[0..2]);
}
