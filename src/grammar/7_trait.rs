trait A {
    fn a(&self) -> String {
        return "A.a".to_string();
    }
}

/// This means that B must achieve A in order to achieve B
trait B: A {
    fn b(&self) -> String {
        return "B.b".to_string();
    }
}

struct C {}

impl B for C {}

/// must impl A to impl B
/// or the trait bound `C: A` is not satisfied [E0277]
impl<T: B + ?Sized> A for T {}


// const fn is_b<T: ?Sized>() -> bool {
//     trait IsBTest {
//         const IS_B: bool;
//     }
//     impl<T: ?Sized> IsBTest for T {
//       default const IS_B: bool = false;
//     }
//     impl<T: B + ?Sized> IsBTest for T {
//         const IS_B: bool = true;
//     }
//
//     <T as IsBTest>::IS_B
// }

#[test]
fn trait_recombination() {
    let c = C {};
    assert_eq!(c.a(), "A.a");
    assert_eq!(c.b(), "B.b");

    let foo: &dyn A = &C {};
    assert_eq!(foo.a(), "A.a");
    // `B` defines an item `b`, perhaps you need to implement it
    // assert_eq!(foo.b(), "B.b");
    // assert!(is_b::<C>());

    let bar: &dyn B = &C {};
    assert_eq!(bar.b(), "B.b");
    assert_eq!(bar.a(), "A.a");
}