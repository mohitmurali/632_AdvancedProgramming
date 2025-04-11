#include <iostream>
#include <vector>
#include <string>

// Base class for all rides
class Ride {
protected:
    std::string rideCode;       // Ride identifier
    std::string pickupSpot;     // Pickup location
    std::string dropoffSpot;    // Dropoff location
    double distance;            // Distance in miles
    double fare;                // Calculated fare
public:
    // Constructor to initialize ride details
    Ride(std::string code, std::string pickup, std::string dropoff, double dist)
        : rideCode(code), pickupSpot(pickup), dropoffSpot(dropoff), distance(dist), fare(0.0) {}
    
    // Pure virtual method for fare calculation
    virtual void calculateFare() = 0;
    
    // Display ride details
    virtual void showRideDetails() const {
        std::cout << "Ride Code: " << rideCode << ", Pickup: " << pickupSpot
                  << ", Dropoff: " << dropoffSpot << ", Distance: " << distance
                  << ", Fare: $" << fare << std::endl;
    }
    
    // Get fare value
    double getFare() const {
        return fare;            // Return fare
    }
    
    // Get distance value
    double getDistance() const {
        return distance;        // Return distance
    }
    
    // Set fare value
    void setFare(double value) {
        fare = value;           // Update fare
    }
    
    // Virtual destructor for safe cleanup
    virtual ~Ride() {}
};

// Subclass for standard rides
class StandardRide : public Ride {
public:
    // Constructor
    StandardRide(std::string code, std::string pickup, std::string dropoff, double dist)
        : Ride(code, pickup, dropoff, dist) {}
    
    // Calculate fare at $1.5 per mile
    void calculateFare() override {
        setFare(getDistance() * 1.5); // Set fare based on distance
    }
};

// Subclass for premium rides
class PremiumRide : public Ride {
public:
    // Constructor
    PremiumRide(std::string code, std::string pickup, std::string dropoff, double dist)
        : Ride(code, pickup, dropoff, dist) {}
    
    // Calculate fare at $3.0 per mile
    void calculateFare() override {
        setFare(getDistance() * 3.0); // Set fare based on distance
    }
};

// Class to manage drivers
class Driver {
private:
    std::string driverTag;      // Driver identifier
    std::string driverName;     // Driver name
    double rating;              // Driver rating
    std::vector<Ride*> assignedTrips; // List of assigned rides
public:
    // Constructor
    Driver(std::string tag, std::string name, double score)
        : driverTag(tag), driverName(name), rating(score) {}
    
    // Add a ride to driver’s list
    void addRide(Ride* ride) {
        assignedTrips.push_back(ride); // Append ride
    }
    
    // Display driver info and trips
    void getDriverInfo() const {
        std::cout << "Driver Tag: " << driverTag << ", Name: " << driverName
                  << ", Rating: " << rating << std::endl; // Print driver details
        std::cout << "Assigned Trips:" << std::endl; // Print trips header
        for (const auto* trip : assignedTrips) { // Iterate and display trips
            trip->showRideDetails();
        }
        // Algorithm: Iteration - displays each trip; O(n) for n trips
    }
    
    // Calculate fares for all assigned rides
    void calculateAllFares() {
        for (auto* trip : assignedTrips) { // Compute fare for each trip
            trip->calculateFare();
        }
        // Algorithm: Iteration - applies fare calculation; O(n) for n trips
    }
    
    // Calculate total earnings
    double totalEarnings() const {
        double sum = 0.0;
        for (const auto* trip : assignedTrips) { // Sum trip fares
            sum += trip->getFare();
        }
        return sum;
        // Algorithm: Sum Reduction - accumulates fares; O(n) for n trips
    }
    
    // Destructor to free memory
    ~Driver() {
        for (auto* ride : assignedTrips) delete ride; // Delete rides
    }
};

// Class to manage riders
class Rider {
private:
    std::string riderTag;       // Rider identifier
    std::string riderName;      // Rider name
    std::vector<Ride*> bookedTrips; // List of booked rides
public:
    // Constructor
    Rider(std::string tag, std::string name)
        : riderTag(tag), riderName(name) {}
    
    // Book a new ride
    void requestRide(Ride* ride) {
        bookedTrips.push_back(ride); // Append ride
    }
    
    // Display booked rides
    void viewRides() const {
        std::cout << "Rider Tag: " << riderTag << ", Name: " << riderName << std::endl; // Print rider details
        std::cout << "Booked Trips:" << std::endl; // Print trips header
        for (const auto* trip : bookedTrips) { // Iterate and display trips
            trip->showRideDetails();
        }
        // Algorithm: Iteration - displays each trip; O(n) for n trips
    }
    
    // Calculate fares for all rides
    void calculateAllFares() {
        for (auto* trip : bookedTrips) { // Compute fare for each trip
            trip->calculateFare();
        }
        // Algorithm: Iteration - applies fare calculation; O(n) for n trips
    }
    
    // Destructor to free memory
    ~Rider() {
        for (auto* ride : bookedTrips) delete ride; // Delete rides
    }
};

// Main function to test the system
int main() {
    // Initialize ride collection
    std::vector<Ride*> rideList;
    
    // Add StandardRide
    rideList.push_back(new StandardRide("R001", "Library", "Mall", 10.0));
    
    // Add PremiumRide
    rideList.push_back(new PremiumRide("R002", "Station", "Park", 4.0));
    
    // Display and calculate fares polymorphically
    std::cout << "All Rides:" << std::endl;
    for (auto* ride : rideList) { // Iterate over rides
        ride->calculateFare();    // Compute fare
        ride->showRideDetails();  // Show details
    }
    // Algorithm: Iteration - processes rides polymorphically; O(n) for n rides
    
    // Create driver
    Driver driver("D001", "Sam Carter", 4.9);
    
    // Assign rides to driver
    driver.addRide(new StandardRide("R001", "Library", "Mall", 10.0));
    driver.addRide(new PremiumRide("R002", "Station", "Park", 4.0));
    driver.calculateAllFares();    // Calculate fares for assigned rides
    
    // Show driver info
    std::cout << "Driver Info:" << std::endl;
    driver.getDriverInfo();
    
    // Show driver earnings
    std::cout << "Total Earnings: $" << driver.totalEarnings() << std::endl;
    
    // Create rider
    Rider rider("P001", "Emma Brown");
    
    // Book rides for rider
    rider.requestRide(new StandardRide("R003", "Home", "Office", 5.0));
    rider.requestRide(new PremiumRide("R004", "Cafe", "Gym", 2.0));
    
    // Calculate rider fares
    rider.calculateAllFares();
    
    // Show rider info
    std::cout << "Rider Info:" << std::endl;
    rider.viewRides();
    
    // Clean up rideList
    for (auto* ride : rideList) {
        delete ride;              // Free memory
    }
    
    return 0;
}