use std::io;

fn nikhilam_multiply(a: i32, b: i32) -> i32 {
    // Find the base (nearest higher power of 10)
    let base = 10_i32.pow(((a.max(b) as f64).log10().ceil()) as u32);

    let a_diff = a - base;
    let b_diff = b - base;

    let left = a + b_diff; // or b + a_diff (same)
    let right = a_diff * b_diff;

    left * base + right
}

fn main() {
    let mut input = String::new();

    println!("Enter first number:");
    io::stdin().read_line(&mut input).unwrap();
    let a: i32 = input.trim().parse().unwrap();

    input.clear();

    println!("Enter second number:");
    io::stdin().read_line(&mut input).unwrap();
    let b: i32 = input.trim().parse().unwrap();

    let result = nikhilam_multiply(a, b);

    println!("Result of {} × {} = {}", a, b, result);
}
