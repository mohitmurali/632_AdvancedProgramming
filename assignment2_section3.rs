// Program to multiple numbers
fn main() {
    // Allocating memory inside array
    let num = vec![2,5,10]; 

    // Multiply calculator
    let multiply: i32 = num.iter().product();

    // Result
    println!("Product of numbers in Rust: {}", multiply);

}
