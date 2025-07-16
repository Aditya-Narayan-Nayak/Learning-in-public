/*use std::io;

fn main(){
    let test = false;
    if test {
        println!("call the function");
    }else{
        println!("sending logs to security team");
    }

    println!("enter ur height in ft (dont use decimal number): ");
    let mut input = String::new();
    io::stdin().read_line()

    if height > 6{
        println!("ur tall!");
    }
    else if height <= 6{
        println!("ur short!")
    }
    else {
        println!("please input ur height in ft not in decimal")
    }
}
*/

fn main() {
    let mut height = 190;
    height = height -20;
    let result = if height >180 {
        "Tall"
    }else if height > 170 {
        "Avarage"
    }else {
        "Short"
    };

    println!("Result: {}", result);

    let health = if height > 180 {"good"} else {"bad"};
    println!("your health is: {}", health);

//    let health = if height > 180 {true} else {false};
}