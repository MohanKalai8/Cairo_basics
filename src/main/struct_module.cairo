#[derive(Drop)]
struct User{
    active:bool,
    username:ByteArray,
    email:ByteArray,
    sign_in_count:u64,
}

pub fn test_struct(){
    let user1 = User {
        active : true, username: "mohan", email:"mohan@gmail.com",sign_in_count:1
    };
    let user2 = User {
        sign_in_count:1, username:"harry", active:true, email:"harry@gmail.com"
    };

    println!("User1:: username: {:?}", user1.username);
    println!("User2:: username: {:?}", user2.username);
}


#[derive(Copy,Drop)]
struct Rectangle{
    length:u128,
    breadth:u128
}

pub trait RectangleTrait {
    fn area(self:@Rectangle) -> u128;
    fn dimension(self:@Rectangle) -> (u128,u128);
}

pub impl RectangleImpl of RectangleTrait{
    fn area(self:@Rectangle) -> u128{
        (*self.length) * (*self.breadth)
    }
    fn dimension(self:@Rectangle) -> (u128,u128){
        (*self.length,*self.breadth)
    }
}

pub fn create_rectangle(l:u128,b:u128) -> Rectangle{
    let rect:@Rectangle = @Rectangle{
        length:l,
        breadth:b
    };
    return *rect;
}