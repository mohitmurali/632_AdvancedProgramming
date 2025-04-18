#include <stdio.h>
#include <stdlib.h>

// Comparison function for qsort to sort numbers in ascending order
int compare_numbers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

// Calculates the mean (average) of the numbers
// Iterates through the array to sum all elements and divides by count
double compute_mean(int *numbers, int count) {
    double total_sum = 0.0;
    for (int i = 0; i < count; i++) {
        total_sum += numbers[i];
    }
    return total_sum / count;
}

// Calculates the median (middle value) of the sorted numbers
// Uses sorted array: for odd count, takes middle element; for even, averages two middle elements
double compute_median(int *numbers, int count) {
    // Assumes numbers is already sorted (via qsort in main)
    if (count % 2 == 1) {
        return numbers[count / 2];
    } else {
        return (numbers[count / 2 - 1] + numbers[count / 2]) / 2.0;
    }
}

// Calculates the mode (most frequent number(s))
// Algorithm: Iterates through sorted array, counts frequency of each number,
// keeps track of max frequency and collects all numbers with that frequency
void compute_mode(int *numbers, int count) {
    int max_frequency = 0, mode_frequency_count = 0;
    int *mode_values = (int*)malloc(count * sizeof(int));
    int i = 0;
    while (i < count) {
        int current_number = numbers[i];
        int frequency = 0;
        // Count frequency of current_number in sorted array
        while (i < count && numbers[i] == current_number) {
            frequency++;
            i++;
        }
        if (frequency > max_frequency) {
            // New max frequency found, reset mode list
            max_frequency = frequency;
            mode_frequency_count = 1;
            mode_values[0] = current_number;
        } else if (frequency == max_frequency) {
            // Add to list of modes if frequency matches max
            mode_values[mode_frequency_count] = current_number;
            mode_frequency_count++;
        }
    }
    printf("Mode: ");
    for (int j = 0; j < mode_frequency_count; j++) {
        printf("%d ", mode_values[j]);
    }
    printf("\n");
    free(mode_values);
}

int main() {
    int count;
    printf("Enter the number of elements: ");
    scanf("%d", &count);
    int *numbers = (int*)malloc(count * sizeof(int));
    printf("Enter the elements: ");
    for (int i = 0; i < count; i++) {
        scanf("%d", &numbers[i]);
    }
    // Sort array using qsort (stdlib's quicksort implementation)
    // Why: Sorting is required for median (middle element) and simplifies mode calculation
    qsort(numbers, count, sizeof(int), compare_numbers);
    printf("Mean: %.2f\n", compute_mean(numbers, count));
    printf("Median: %.2f\n", compute_median(numbers, count));
    compute_mode(numbers, count);
    free(numbers);
    return 0;
}