//MSCS 632 - Advanced Programming Languages
// Assignment 
// Group 5: Mohit Gokul Murali
// Date: March 26, 2025

const readline = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
  });
  
// Define the number of days and shifts
  const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  const shifts = ['morning', 'afternoon', 'evening'];
  let employees = [];
  let scheduleGenerated = false;
  
  // Function to shuffle array (Fisher-Yates)
  // Fisher-Yates algorithm works in O(n) time complexity.
  // The idea is to start from the last element and swap it with a randomly selected element from the whole array (including the last)
  function shuffle(array) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
  }
  
  // Function to add employee
  function addEmployee() 
  {
    readline.question('Enter employee name: ', name => {
      if (!name) {
        console.log('Name is required');
        addEmployee();
        return;
      }

      // Check if the name is unique. Can't have same name for two employees.
      if (employees.some(emp => emp.name === name)) {
        console.log('Name must be unique');
        addEmployee();
        return;
      }

      // get input for preferred shift
      readline.question('Enter preferred shift (morning/afternoon/evening): ', preferredShift => {
        
        // Check if the preferred shift is valid
        if (!['morning', 'afternoon', 'evening'].includes(preferredShift)) {
          console.log('Invalid shift');
          addEmployee();
          return;
        }

        // If input is valid, add the employee to the list
        employees.push({ name, preferredShift });
        console.log(`Added: ${name} (Preferred: ${preferredShift})`);

        // If the number of employees is 9 or more, show the message "Ready to generate schedule"
        if (employees.length >= 9) {
          console.log('Ready to generate schedule');
        } 
        // else show the message "Need x more employees" where x is the number of employees needed to reach 9
        else {
          console.log(`Need ${9 - employees.length} more employees`);
        }
        mainMenu();
      });
    });
  }
  
  // Function to generate schedule
  // The function generates a weekly schedule for 9 employees over 7 days and 3 shifts per day.
  function generateSchedule() {
    const schedule = {};
    days.forEach(day => {
      schedule[day] = {};
      shifts.forEach(shift => {
        schedule[day][shift] = [];
      });
    });
    // Shuffle employees
    const assignedDays = {};
    employees.forEach(emp => {
      assignedDays[emp.name] = new Set();
    });
  
    // Assign employees to shifts
    days.forEach(day => {
      let available = employees.filter(emp => assignedDays[emp.name].size < 5);
      shuffle(available);
      available.sort((a, b) => assignedDays[a.name].size - assignedDays[b.name].size);
      let assignedToday = new Set();
  
      // Assign 2 employees to their preferred shift
      shifts.forEach(shift => {
        let candidates = available.filter(emp => emp.preferredShift === shift && !assignedToday.has(emp.name));
        for (let i = 0; i < 2 && candidates.length > 0; i++) {
          let emp = candidates.shift();
          schedule[day][shift].push(emp.name);
          assignedDays[emp.name].add(day);
          assignedToday.add(emp.name);
          available = available.filter(e => e.name !== emp.name);
        }
      });
      
      // Assign remaining employees to other shifts
      shifts.forEach(shift => {
        while (schedule[day][shift].length < 2 && available.length > 0) {
          let remaining = available.filter(emp => !assignedToday.has(emp.name));
          if (remaining.length === 0) break;
          remaining.sort((a, b) => assignedDays[a.name].size - assignedDays[b.name].size);
          let emp = remaining[0];
          schedule[day][shift].push(emp.name);
          assignedDays[emp.name].add(day);
          assignedToday.add(emp.name);
          available = available.filter(e => e.name !== emp.name);
        }
      });
    });
  
    // Assign remaining days to employees
    employees.forEach(emp => {
      while (assignedDays[emp.name].size < 5) {
        const availableDays = days.filter(day => !assignedDays[emp.name].has(day));
        if (availableDays.length === 0) break;
        const day = availableDays[0];
        const shift = emp.preferredShift;
        schedule[day][shift].push(emp.name);
        assignedDays[emp.name].add(day);
      }
    });
  
    // Print the schedule
    console.log('\nWeekly Schedule:');
    days.forEach(day => {
      console.log(`${day}:`);
      shifts.forEach(shift => {
        console.log(`  ${shift}: ${schedule[day][shift].join(', ') || 'No employees'}`);
      });
    });
  
    // Set scheduleGenerated to true
    scheduleGenerated = true;
    mainMenu();
  }
  
  // Function to clear schedule
  function clearSchedule() 
  {
  // If schedule is not generated
    if (!scheduleGenerated) 
    {
      employees = [];
      console.log('Schedule cleared');
    }
    // else part
    else 
    {
      console.log('Cannot clear after generating schedule');
    }
    mainMenu();
  }
  
  // Function to create another schedule
  function createAnotherSchedule() {
    if (scheduleGenerated) {
      employees = [];
      scheduleGenerated = false;
      console.log('Ready to create another schedule');
    } else {
      console.log('No schedule generated yet');
    }
    mainMenu();
  }
  
  // Main menu
  function mainMenu() 
  // options to show
  {
    console.log('\nOptions:');

    // show option 1 by default.
    console.log('1. Add Employee');

    // show option 2 if employees are more than 9
    if (employees.length >= 9) {
      console.log('2. Generate Schedule');
    }

    // show option 3 if schedule is not generated
    if (!scheduleGenerated) {
      console.log('3. Clear Schedule');
    }

    // show option 4 if schedule is generated
    if (scheduleGenerated) {
      console.log('4. Create another Schedule');
    }

    // show option 5 by default.
    console.log('5. Exit');
  
    readline.question('Choose an option: ', choice => {

      // switch case to handle the options
      switch (choice) {

        // case 1: Add Employee
        case '1':
          addEmployee();
          break;

        // case 2: Generate Schedule, else show message "Need at least 9 employees"
        case '2':
          if (employees.length >= 9) {
            generateSchedule();
          } else {
            console.log('Need at least 9 employees');
            mainMenu();
          }
          break;

        // case 3: Clear Schedule, else show message "Cannot clear after generating schedule"
        case '3':
          if (!scheduleGenerated) {
            clearSchedule();
          } else {
            console.log('Cannot clear after generating schedule');
            mainMenu();
          }
          break;
        
        // case 4: Create another Schedule, else show message "No schedule generated yet"
        case '4':
          if (scheduleGenerated) {
            createAnotherSchedule();
          } else {
            console.log('No schedule generated yet');
            mainMenu();
          }
          break;
        
        // case 5: Exit, close the readline interface
        case '5':
          readline.close();
          break;
        default:
          console.log('Invalid choice');
          mainMenu();
      }
    });
  }
  
  // Start the application
  mainMenu();