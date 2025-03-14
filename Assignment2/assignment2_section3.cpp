// Program to mulitply numbers inside array vector

#include <iostream>
#include <vector>
#include <chrono>

int main() {
    // timer
    auto start = std::chrono::high_resolution_clock::now();

    // Allocate memory to a vector array
    std::vector<int>* nums = new std::vector<int>;
    nums->push_back(2);
    nums->push_back(5);
    nums->push_back(10);

    // Multiply calculation
    int pdt = 1;
    for (int num : *nums) {
        pdt *= num;
    }

    // Result
    std::cout << "Product of numbers in C++: " << pdt << std::endl;

    // Free the memory
    delete nums;

    // Stops timer and calculates  duration
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);

    // Print the time taken
    std::cout << "Execution Time: " << duration.count() << " microseconds" << std::endl;

    return 0;
}
