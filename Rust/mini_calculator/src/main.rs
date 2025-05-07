use std::io;

fn main() {
    println!("Enter a Number: ");

    let mut number = String::new();
    io::stdin()
        .read_line(&mut number)
        .expect("chud gaye guru!");

    println!("you entered {}", number);
}