// Scoping & Closures
#include <iostream>
#include <functional>
std::function<int()> funcCounter() {
    int count = 0; 

    auto addIncrement = [count]() mutable {  // Capture count
        count += 1;  // Allows to use outer variable
        return count;
    };

    return addIncrement;
}

int main() {
    // Call the functions & Create two independent counters
    auto counter1 = funcCounter();
    auto counter2 = funcCounter();

    std::cout << "Counter 1: " << counter1() << std::endl;  // Output: 1
    std::cout << "Counter 1: " << counter1() << std::endl;  // Output: 2
    std::cout << "Counter 2: " << counter2() << std::endl;  // Output: 1
    std::cout << "Counter 2: " << counter2() << std::endl;  // Output: 2

    return 0;
}
