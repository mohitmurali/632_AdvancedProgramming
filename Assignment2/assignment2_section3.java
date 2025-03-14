// Program to multiply numbers

import java.util.ArrayList;

public class mulitplyCalc {
    public static void main(String[] args) 
    {
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
    }
}
