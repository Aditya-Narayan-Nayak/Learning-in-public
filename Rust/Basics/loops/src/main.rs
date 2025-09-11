// # Rust Loop Example
// This Rust program demonstrates a simple loop that prints numbers from 1 to 4.


// fn main() {
//     let mut x = 1;
//     loop {
//         println!("Number is : {}", x);
//         x += 1;
//         if x == 5{
//             break;
//         };
//     }
// }
// This loop will print numbers from 1 to 4 and then exit.

// # While Loop Example
// This Rust program demonstrates a while loop that prints numbers from 1 to 5.

// fn main {
//     let mut i = 0;
//     while i <= 5{
//         println!("I : {}", i);
//         i += 1;
//     }
// }


// fn main(){
//     for i in 1..10 {
//         println!("i : {}", i);
//     }
// }

// fn main(){
//     for i in (1..=10).rev() {
//         println!("i : {}", i);
//     }
// }



// fn main() {
//     let numbers = vec![1, 2, 3, 4, 5].rev();
//     for n in numbers {
//         println!("{}", n);
//     }
// }

// fn main() {
//     for i in 1..=100 {
//         if i % 2 == 0 {
//             // Skip even numbers
//             continue;
//         }
//         println!("i = {}", i);
//         if i == 7 {
//             // Exit loop when i is 7
//             break;
//         }
//     }
// }