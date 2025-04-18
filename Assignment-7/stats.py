from collections import Counter

class StatisticsCalculator:
    def __init__(self, numbers):
        """Initialize with a list of numbers
        Args:
            numbers (list): List of integers for statistical calculations
        Raises:
            ValueError: If numbers list is empty
        """
        if not numbers:
            raise ValueError("Input list cannot be empty")
        self.numbers = numbers

    def compute_mean(self):
        """Calculates the mean (average) of the numbers
        Algorithm: Sums all elements using sum() and divides by length
        Returns:
            float: Mean of the numbers
        """
        return sum(self.numbers) / len(self.numbers)

    def compute_median(self):
        """Calculates the median (middle value) of the sorted numbers
        Algorithm: Sorts list, for odd length takes middle element, for even averages two middle
        Returns:
            float: Median of the numbers
        """
        sorted_numbers = sorted(self.numbers)
        count = len(sorted_numbers)
        if count % 2 == 1:
            return sorted_numbers[count // 2]
        else:
            return (sorted_numbers[count // 2 - 1] + sorted_numbers[count // 2]) / 2

    def compute_mode(self):
        """Calculates the mode (most frequent number(s))
        Algorithm: Uses Counter to count frequencies, collects numbers with max frequency
        Returns:
            list: List of numbers with the highest frequency
        """
        frequency_counter = Counter(self.numbers)
        max_frequency = max(frequency_counter.values())
        return [num for num, freq in frequency_counter.items() if freq == max_frequency]

def get_valid_input():
    """Handles input collection with validation, prompting for each element individually
    Returns:
        tuple: (count, numbers) where count is the number of elements and numbers is the list
    Raises:
        ValueError: If inputs are invalid (non-integer, negative count, or incorrect number of elements)
    """
    try:
        count = int(input("Enter the number of elements: "))
        if count <= 0:
            raise ValueError("Number of elements must be positive")
        
        numbers = []
        for i in range(count):
            while True:
                try:
                    num = int(input(f"Enter element {i + 1}: "))
                    numbers.append(num)
                    break
                except ValueError:
                    print("Error: Please enter a valid integer")
        
        return count, numbers
    except ValueError as e:
        if "invalid literal" in str(e):
            raise ValueError("Number of elements must be a valid integer")
        raise

if __name__ == "__main__":
    try:
        count, numbers = get_valid_input()
        calculator = StatisticsCalculator(numbers)
        print(f"Mean: {calculator.compute_mean():.2f}")
        print(f"Median: {calculator.compute_median():.2f}")
        mode_values = calculator.compute_mode()
        print("Mode: " + " ".join(map(str, mode_values)))
    except ValueError as e:
        print(f"Error: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")