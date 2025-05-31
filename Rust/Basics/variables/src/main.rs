// What is variable and how to declare a variable in rust?
// A variable is a name that refers to a value.
// In Rust, variables are immutable by default.
// To declare a variable, use the let keyword followed by the variable name and value.




// Mutable variables in Rust
// Variables are immutable by default
// To make a variable mutable, use the mut keyword
// Example of mutable variable

fn main() {
    let mut x = 5;
    println!("x: {}", x);
    x = 6;
    println!("x: {}", x);
}
// Example of immutable variable

fn main() {
    let x = 5;
    println!("x: {}", x);
    // x = 6; // This will cause a compile-time error
}

// Example of shadowing

fn main() {
    let x = 5;
    println!("x: {}", x);
    let x = x + 1; // Shadowing the previous x
    println!("x: {}", x);
    let x = "Hello, world!";
    println!("x: {}", x); // Shadowing again with a different type
}


// Example of shadowing :- When i use let keyword in 2nd time when i declare weight 
// Its no more mutable and its became shadow OF previous variable

fn main() {
    let message = "Name: Mango, weight: ";
    let weight = 86;

    let weight = weight / 2;
    println!("{} {}", message, weight);
}

// if you want to use mutable variable then you can use mut keyword. 
// orelse shadowing nor mut keyword is used in the above example



