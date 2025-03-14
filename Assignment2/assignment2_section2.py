# Scoping & Closures
def funcCounter():
    count = 0 

    def addIncrement():
        nonlocal count  #Allows to use outer variable
        count += 1
        return count

    return addIncrement

# Call the functions & Create two independent counters
counter1 = funcCounter()
counter2 = funcCounter()

print("Counter 1:", counter1())  # Output: 1
print("Counter 1:", counter1())  # Output: 2
print("Counter 2:", counter2())  # Output: 1
print("Counter 2:", counter2())  # Output: 2
