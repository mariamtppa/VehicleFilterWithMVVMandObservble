# Dott iOS Take Home Assignment

The app was built using Swift and MVVM architecture. 
It is designed to get vehicle data from a server that simulates the gRPC API. 
The app displays the data to the user and allows the user to filter vehicles displayed according to their choice of color or colors.
It also allows user to view the QRcode and Identification code of a vehicle.
The UI was built using storyboards as provided

## Completed Features

- Fetching of vehicle data from the provided function ( public static func requestVehiclesData() -> RxSwift.Observable<Data> )

- Displaying the list of vehicles to users

- Filtering vehicle list by the color 

- User can know when the list is filtered

- The filter is persisted between launches

- A vehicle detail view that provides futher information on a vehicle (QRcode and identification code) was implemented

- An error messgae is displayed in a way that does not interupt user interaction within the app, to tell the user when an a server error occurs

- Some unit tests were written 

- The filter and detail screens were presented in a more efficient way as expected in the provided bonus design.


## What Could Have Been Improved 

- The presentation for filter and ddetails screens should have been more adaptive to lesser iOS versions, instead of just iOS 15 and above.

- More tests could be written 

- The display of the error that informs user of the server error could be beautified and presented in a more user-friendly way

- The UI could have been tested using Snapshot testing.

