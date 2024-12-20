use core::dict::Felt252DictEntryTrait;
pub mod array_module;
pub mod copy_trait;
pub mod struct_module;

use struct_module::RectangleImpl;
use struct_module::RectangleTrait;
use core::dict::Felt252Dict;
use core::panic_with_felt252;


fn main() {
    /////////////////////////////////////////////////////
    ///                 Array Module                   //       
    /// /////////////////////////////////////////////////

    let mut my_arr: Array<u8> = array_module::test_array();
    println!("Array: {:?}", my_arr);
    println!("Length: {}", my_arr.len());
    my_arr.append(20);
    println!("Array:{:?}", my_arr);

    //////////////////////////////////////////////////////////////
    ///                     Dictionary Module                 ///
    /////////////////////////////////////////////////////////////

    let mut balances: Felt252Dict<u64> = Default::default();
    balances.insert('Alex', 100);
    balances.insert('Maria', 200);
    // balances of alex
    println!("Alex's balance: {}", balances.get('Alex'));
    assert!(balances.get('Alex') == 100);
    // balances of Maria
    println!("Alex's balance: {}", balances.get('Maria'));
    assert!(balances.get('Maria') == 200);
    // update balances of maria and get previous value
    let (entry, prev_value) = balances.entry('Maria');
    balances = entry.finalize(300); // get back ownership of dictionary
    println!("Previous value: {}", prev_value);
    assert!(prev_value == 200);
    println!("Maria's new balance: {}", balances.get('Maria'));
    assert!(balances.get('Maria') == 300);

    //////////////////////////////////////////////////////////////
    ///                     Copy Trait                        ///
    /////////////////////////////////////////////////////////////
    copy_trait::test_copy_trait();

    //////////////////////////////////////////////////////////////
    ///                     Structs Module                    ///
    /////////////////////////////////////////////////////////////
    struct_module::test_struct();
    let rect = struct_module::create_rectangle(10, 20);
    println!("Length, Breadth = {:?}", rect.dimension());
    println!("Area of rectangle: {:?}", rect.area());

    //////////////////////////////////////////////////////////////
    ///                     Panic with felt252                 ///
    /////////////////////////////////////////////////////////////
    panic_with_felt252(2);

    //////////////////////////////////////////////////////////////
    ///                    Recoverable Errors                 ///
    /////////////////////////////////////////////////////////////
    parse_u8(257);

    test_felt252();
    test_unsigned_integers();
}


fn foo(x: u8, y: u8) {}

fn test_felt252() {
    // max value of felt252
    let x: felt252 = 3618502788666131213697322783095070105623107215331596699973092056135872020480;
    let y: felt252 = 1;
    // wraps-around 
    println!("x + y = {}", x + y);
    assert(x + y == 0, 'P == 0 (mod P)');
}

fn test_unsigned_integers() {
    let x: u8 = 127; // will overflow and panic if greater than supported value
    let y: u8 = 130;
    println!("x + y = {}", x + y);
}

fn parse_u8(s: felt252) -> Result<u8, felt252> {
    match s.try_into() {
        Option::Some(value) => Result::Ok(value),
        Option::None => Result::Err('Invalid integer'),
    }
}
