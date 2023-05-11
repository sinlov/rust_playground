#[test]
fn vec_type() {
    // mem in heap
    let mut v = vec![2, 3, 5, 7];
    assert_eq!(v.iter().fold(1, |a, b| a * b), 210);

    // can append items by push()
    v.push(11);
    v.push(13);
    assert_eq!(v.iter().fold(1, |a, b| a * b), 30030);

    // vec! as same as Vec::new()
    let mut foo = Vec::new();
    foo.push("step");
    foo.push("on");
    foo.push("no");
    foo.push("pets");
    assert_eq!(foo, vec!["step", "on", "no", "pets"]);

    // or use iterator
    let bar: Vec<i32> = (0..5).collect();
    assert_eq!(bar, vec![0, 1, 2, 3, 4]);

    // palindrome
    let mut palindrome = vec!["a man", "a plan", "a canal", "panama"];
    palindrome.reverse();
    assert_eq!(palindrome, vec!["panama", "a canal", "a plan", "a man"]);
}

#[test]
fn vec_better() {
    // use capacity to new vec size clear
    let mut v = Vec::with_capacity(2);
    assert_eq!(v.len(), 0);
    assert_eq!(v.capacity(), 2);

    v.push(1);
    v.push(2);
    assert_eq!(v.len(), 2);
    assert_eq!(v.capacity(), 2);

    v.push(3);
    assert_eq!(v.len(), 3);
    assert_eq!(v.capacity(), 4);
}

#[test]
fn vec_method() {
    let mut v = vec![10, 20, 30, 40, 50];

    // insert at 3
    v.insert(3, 35);
    assert_eq!(v, vec![10, 20, 30, 35, 40, 50]);

    // remove at index 1
    v.remove(1);
    assert_eq!(v, vec![10, 30, 35, 40, 50]);

    // pop last to Some() or None

    let mut foo = vec!["carmen", "miranda", "michael"];
    assert_eq!(foo.pop(), Some("michael"));
    assert_eq!(foo.pop(), Some("miranda"));
    assert_eq!(foo.pop(), Some("carmen"));
    assert_eq!(foo.pop(), None);
}