// Program to multiple numbers

use std::time::Instant;
fn main() {

    let start = Instant::now();
    // Allocating memory inside array
    let num = vec![2,5,10]; 

    // Multiply calculator
    let multiply: i32 = num.iter().product();

    // Result
    println!("Product of numbers in Rust: {}", multiply);
    
    let duration = start.elapsed();
    println!("Execution Time: {:?}", duration);

}
