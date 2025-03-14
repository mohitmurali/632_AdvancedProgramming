// Program to multiple numbers inside array

import java.util.ArrayList;

public class multiplyCalc {
    public static void main(String[] args) {
        // Start timing
        long start = System.nanoTime();

        // Allocate memory inside array
        ArrayList<Integer> num = new ArrayList<>();
        num.add(2);
        num.add(5);
        num.add(10);

        // Multiply calculator
        int pdt = 1;
        for (int i = 0; i < num.size(); i++) {
            pdt *= num.get(i);
        }

        // Result
        System.out.println("Product of numbers in Java: " + pdt);

        // Calculate and display execution time
        long duration = System.nanoTime() - start;
        System.out.println("Execution Time: " + (duration / 1000) + " microseconds");
    }
}
