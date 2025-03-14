// Scoping & Closures

function funcCounter() {
    let count = 0;  // Create a local variable
    
    function addIncrement() {
        count += 1;  // Allows to use outer variable
        return count;
    }

    return addIncrement;
}

// Call the function & Create independent counters
const counter1 = funcCounter();
const counter2 = funcCounter();

console.log("Counter 1:", counter1());  // Output: 1
console.log("Counter 1:", counter1());  // Output: 2
console.log("Counter 2:", counter2());  // Output: 1
console.log("Counter 2:", counter2());  // Output: 2
