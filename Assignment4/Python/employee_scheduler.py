# MSCS 632 - Advanced Programming Languages
# Assignment 
# Group 5: Mohit Gokul Murali
# Date: March 26, 2025

import random

# Define the number of days and shifts
days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
shifts = ['morning', 'afternoon', 'evening']
employees = []
scheduleGenerated = False

# Function to shuffle array (Fisher-Yates)
# Fisher-Yates algorithm works in O(n) time complexity.
# The idea is to start from the last element and swap it with a randomly selected element from the whole array (including the last)
def shuffle(array):
    random.shuffle(array)

# Function to add employee
def addEmployee():
    name = input('Enter employee name: ').strip()
    if not name:
        print('Name is required')
        addEmployee()
        return

    # Check if the name is unique. Can't have same name for two employees.
    if any(emp['name'] == name for emp in employees):
        print('Name must be unique')
        addEmployee()
        return

    # get input for preferred shift
    preferredShift = input('Enter preferred shift (morning/afternoon/evening): ').strip().lower()

    # Check if the preferred shift is valid
    if preferredShift not in shifts:
        print('Invalid shift')
        addEmployee()
        return

    # If input is valid, add the employee to the list
    employees.append({'name': name, 'preferredShift': preferredShift})
    print(f"Added: {name} (Preferred: {preferredShift})")

    # If the number of employees is 9 or more, show the message "Ready to generate schedule"
    if len(employees) >= 9:
        print('Ready to generate schedule')
    # else show the message "Need x more employees" where x is the number of employees needed to reach 9
    else:
        print(f"Need {9 - len(employees)} more employees")
    mainMenu()

# Function to generate schedule
# The function generates a weekly schedule for 9 employees over 7 days and 3 shifts per day.
def generateSchedule():
    global scheduleGenerated
    schedule = {day: {shift: [] for shift in shifts} for day in days}
    # Shuffle employees
    assignedDays = {emp['name']: set() for emp in employees}

    # Assign employees to shifts
    for day in days:
        available = [emp for emp in employees if len(assignedDays[emp['name']]) < 5]
        shuffle(available)
        available.sort(key=lambda emp: len(assignedDays[emp['name']]))
        assignedToday = set()

        # Assign 2 employees to their preferred shift
        for shift in shifts:
            candidates = [emp for emp in available if emp['preferredShift'] == shift and emp['name'] not in assignedToday]
            for _ in range(2):
                if candidates:
                    emp = candidates.pop(0)
                    schedule[day][shift].append(emp['name'])
                    assignedDays[emp['name']].add(day)
                    assignedToday.add(emp['name'])
                    available.remove(emp)

        # Assign remaining employees to other shifts
        for shift in shifts:
            while len(schedule[day][shift]) < 2 and available:
                remaining = [emp for emp in available if emp['name'] not in assignedToday]
                if not remaining:
                    break
                remaining.sort(key=lambda emp: len(assignedDays[emp['name']]))
                emp = remaining[0]
                schedule[day][shift].append(emp['name'])
                assignedDays[emp['name']].add(day)
                assignedToday.add(emp['name'])
                available.remove(emp)

    # Assign remaining days to employees
    for emp in employees:
        while len(assignedDays[emp['name']]) < 5:
            availableDays = [day for day in days if day not in assignedDays[emp['name']]]
            if not availableDays:
                break
            day = availableDays[0]
            shift = emp['preferredShift']
            schedule[day][shift].append(emp['name'])
            assignedDays[emp['name']].add(day)

    # Print the schedule
    print('\nWeekly Schedule:')
    for day in days:
        print(f"{day}:")
        for shift in shifts:
            print(f"  {shift}: {', '.join(schedule[day][shift]) or 'No employees'}")

    # Set scheduleGenerated to true
    scheduleGenerated = True
    mainMenu()

# Function to clear schedule
def clearSchedule():
    global employees
    # If schedule is not generated
    if not scheduleGenerated:
        employees = []
        print('Schedule cleared')
    # else part
    else:
        print('Cannot clear after generating schedule')
    mainMenu()

# Function to create another schedule
def createAnotherSchedule():
    global employees, scheduleGenerated
    if scheduleGenerated:
        employees = []
        scheduleGenerated = False
        print('Ready to create another schedule')
    else:
        print('No schedule generated yet')
    mainMenu()

# Main menu
def mainMenu():
    # options to show
    while True:
        print('\nOptions:')

        # show option 1 by default.
        print('1. Add Employee')

        # show option 2 if employees are more than 9
        if len(employees) >= 9:
            print('2. Generate Schedule')

        # show option 3 if schedule is not generated
        if not scheduleGenerated:
            print('3. Clear Schedule')

        # show option 4 if schedule is generated
        if scheduleGenerated:
            print('4. Create another Schedule')

        # show option 5 by default.
        print('5. Exit')

        choice = input('Choose an option: ').strip()

        # switch case to handle the options
        if choice == '1':
            addEmployee()
        # case 2: Generate Schedule, else show message "Need at least 9 employees"
        elif choice == '2':
            if len(employees) >= 9:
                generateSchedule()
            else:
                print('Need at least 9 employees')
                mainMenu()
        # case 3: Clear Schedule, else show message "Cannot clear after generating schedule"
        elif choice == '3':
            if not scheduleGenerated:
                clearSchedule()
            else:
                print('Cannot clear after generating schedule')
                mainMenu()
        # case 4: Create another Schedule, else show message "No schedule generated yet"
        elif choice == '4':
            if scheduleGenerated:
                createAnotherSchedule()
            else:
                print('No schedule generated yet')
                mainMenu()
        # case 5: Exit, close the readline interface
        elif choice == '5':
            break
        else:
            print('Invalid choice')

# Start the application
if __name__ == "__main__":
    mainMenu()