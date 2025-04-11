"Define the base Ride class"
Object subclass: Ride [
    "Instance variables for ride details"
    | rideCode pickupSpot dropoffSpot distance fare |
    
    "Class method to create and initialize a ride"
    Ride class >> newRide: code pickup: pickup dropoff: dropoff distance: dist [
        | instance |
        instance := self new.                "Create new instance"
        instance initialize.                 "Initialize fare"
        instance setDetails: code pickup: pickup dropoff: dropoff distance: dist. "Set ride details"
        ^instance                           "Return instance"
    ]
    
    "Initialize fare to 0"
    initialize [
        fare := 0.0.
    ]
    
    "Set ride attributes"
    setDetails: code pickup: pickup dropoff: dropoff distance: dist [
        rideCode := code.                   "Set ride ID"
        pickupSpot := pickup.               "Set pickup location"
        dropoffSpot := dropoff.             "Set dropoff location"
        distance := dist.                   "Set distance"
    ]
    
    "Abstract method for fare calculation"
    calculateFare [
        self subclassResponsibility.        "Require subclasses to implement"
    ]
    
    "Display ride details"
    showRideDetails [
        stdout nextPutAll: 'Ride Code: '; nextPutAll: rideCode;
               nextPutAll: ', Pickup: '; nextPutAll: pickupSpot;
               nextPutAll: ', Dropoff: '; nextPutAll: dropoffSpot;
               nextPutAll: ', Distance: '; print: distance;
               nextPutAll: ', Fare: $'; print: fare; nl. "Print ride info"
    ]
    
    "Get fare value"
    fare [
        ^fare                               "Return fare"
    ]
    
    "Get distance value"
    distance [
        ^distance                          "Return distance"
    ]
    
    "Set fare value"
    setFare: value [
        fare := value.                     "Update fare"
    ]
]

"Define StandardRide subclass"
Ride subclass: StandardRide [
    "Calculate fare at $1.5 per mile"
    calculateFare [
        self setFare: self distance * 1.5. "Set fare based on distance"
    ]
]

"Define PremiumRide subclass"
Ride subclass: PremiumRide [
    "Calculate fare at $3.0 per mile"
    calculateFare [
        self setFare: self distance * 3.0. "Set fare based on distance"
    ]
]

"Define Driver class"
Object subclass: Driver [
    "Instance variables for driver details"
    | driverTag driverName rating assignedTrips |
    
    "Initialize trip list"
    initialize [
        assignedTrips := OrderedCollection new. "Create empty trip collection"
    ]
    
    "Set driver attributes"
    setDriverTag: tag name: name rating: score [
        driverTag := tag.                  "Set driver ID"
        driverName := name.                "Set name"
        rating := score.                   "Set rating"
    ]
    
    "Add a ride to driver’s list"
    addRide: aRide [
        assignedTrips add: aRide.          "Append ride to collection"
    ]
    
    "Display driver info and trips"
    getDriverInfo [
        stdout nextPutAll: 'Driver Tag: '; nextPutAll: driverTag;
               nextPutAll: ', Name: '; nextPutAll: driverName;
               nextPutAll: ', Rating: '; print: rating; nl. "Print driver details"
        stdout nextPutAll: 'Assigned Trips:'; nl.   "Print trips header"
        assignedTrips do: [ :trip | trip showRideDetails ]. "Iterate and display trips"
        "Algorithm: Iteration - displays each trip; O(n) for n trips"
    ]
    
    "Calculate total earnings"
    totalEarnings [
        ^assignedTrips inject: 0 into: [ :sum :trip | sum + trip fare ]. "Sum trip fares"
        "Algorithm: Sum Reduction - accumulates fares; O(n) for n trips"
    ]
]

"Define Rider class"
Object subclass: Rider [
    "Instance variables for rider details"
    | riderTag riderName bookedTrips |
    
    "Initialize trip list"
    initialize [
        bookedTrips := OrderedCollection new. "Create empty trip collection"
    ]
    
    "Set rider attributes"
    setRiderTag: tag name: name [
        riderTag := tag.                   "Set rider ID"
        riderName := name.                 "Set name"
    ]
    
    "Book a new ride"
    requestRide: aRide [
        bookedTrips add: aRide.            "Append ride to collection"
    ]
    
    "Display booked rides"
    viewRides [
        stdout nextPutAll: 'Rider Tag: '; nextPutAll: riderTag;
               nextPutAll: ', Name: '; nextPutAll: riderName; nl. "Print rider details"
        stdout nextPutAll: 'Booked Trips:'; nl.    "Print trips header"
        bookedTrips do: [ :trip | trip showRideDetails ]. "Iterate and display trips"
        "Algorithm: Iteration - displays each trip; O(n) for n trips"
    ]
    
    "Calculate fares for all rides"
    calculateAllFares [
        bookedTrips do: [ :trip | trip calculateFare ]. "Compute fare for each trip"
        "Algorithm: Iteration - applies fare calculation; O(n) for n trips"
    ]
]

"Test script"
| rideList driver rider |

"Initialize ride collection"
rideList := OrderedCollection new.

"Add StandardRide"
rideList add: (StandardRide newRide: 'R001' pickup: 'Library' dropoff: 'Mall' distance: 10.0).

"Add PremiumRide"
rideList add: (PremiumRide newRide: 'R002' pickup: 'Station' dropoff: 'Park' distance: 4.0).

"Display and calculate fares polymorphically"
stdout nextPutAll: 'All Rides:'; nl.
rideList do: [ :ride | 
    ride calculateFare.                    "Compute fare"
    ride showRideDetails.                  "Show details"
].
"Algorithm: Iteration - processes rides polymorphically; O(n) for n rides"

"Create driver"
driver := Driver new.

"Set driver details"
driver setDriverTag: 'D001' name: 'Sam Carter' rating: 4.9.

"Assign rides to driver"
driver addRide: (rideList at: 1).
driver addRide: (rideList at: 2).

"Show driver info"
stdout nextPutAll: 'Driver Info:'; nl.
driver getDriverInfo.

"Show driver earnings"
stdout nextPutAll: 'Total Earnings: $'; print: driver totalEarnings; nl.

"Create rider"
rider := Rider new.

"Set rider details"
rider setRiderTag: 'P001' name: 'Emma Brown'.

"Book rides for rider"
rider requestRide: (StandardRide newRide: 'R003' pickup: 'Home' dropoff: 'Office' distance: 5.0).
rider requestRide: (PremiumRide newRide: 'R004' pickup: 'Cafe' dropoff: 'Gym' distance: 2.0).

"Calculate rider fares"
rider calculateAllFares.

"Show rider info"
stdout nextPutAll: 'Rider Info:'; nl.
rider viewRides.