# Employee Scheduling Application

## MSCS 632 - Advanced Programming Languages  
### Assignment 4: Implementing Control Structures  
### Group 5: Mohit Gokul Murali  
**Date:** March 26, 2025  

## 📌 Project Overview  
The **Employee Scheduling Application** is a command-line tool designed to assist managers in creating weekly employee schedules. It ensures:  
- Each shift has at least two employees.  
- No employee works more than five days a week.  
- Employee shift preferences are considered where possible.  

The application is implemented in both JavaScript (Node.js) and Python, offering flexibility for users based on their preferred programming environment.

## ⚙️ Features  
✔ **Add Employee** – Add employees with their preferred shifts (morning, afternoon, evening).  
✔ **Generate Schedule** – Automatically create a weekly schedule meeting staffing requirements and preferences.  
✔ **Clear Schedule** – Reset the employee list before generating a schedule.  
✔ **Create Another Schedule** – Generate a new schedule with a fresh set of employees after completing one.  
✔ **User-Friendly CLI** – Intuitive menu-driven interface for all operations.  

## 🚀 Installation & Setup  

### JavaScript (Node.js)   
   ```bash
   git clone https://github.com/mohitmurali/632_AdvancedProgramming.git
   cd 632_AdvancedProgramming/Assignment4/JavaScript
   npm install
   node employee_scheduler.js
   ```
### Python 
```bash
   sudo apt install python3
   git clone https://github.com/mohitmurali/632_AdvancedProgramming.git
   cd 632_AdvancedProgramming/Assignment4/Python
   python3 employee_scheduler.js
```
## 📚 Additional Information
JavaScript Version: Built with Node.js, using the readline module for command-line interaction.
Python Version: Uses native input and print functions for a simple CLI experience.
Scheduling Logic: Assigns shifts based on preferences and availability, ensuring fairness and coverage.
