# RouteCoordinator Library

The RouteCoordinator library offers a seamless means of communication between modules and pages within an application. It aims to minimize dependencies between modules by utilizing Codable structures for parameter transmission and efficient handling of received data. This documentation guides you through installation, implementation, and usage of the library.

## Purpose

The primary aim behind developing this library is to streamline communication among pages/modules while circumventing direct passage of domain entities to the calling module/page. This approach significantly diminishes interdependencies among various pages/modules within the application. To facilitate the transmission of essential parameters, the library leverages Codable structures (RouteParameter). However, ensuring the alignment of transmitted data with the required data isn't guaranteed. To tackle this challenge, we've devised a methodology that effectively manages the transmitted data, making it readily Decodable (RouteValue) for seamless integration within the recipient module.

Moreover, effective inter-module communication mandates the transmission of both parameters and knowledge pertaining to the Class that necessitates invocation. Accessing this information becomes unattainable if the module to be called isn't incorporated within our module. Thus, the introduction of the RouteCoordinator serves as a strategic solution to this intricacy.

## Features

### Key features of the library include:

- **Invoking Other Modules/Pages**: Initiating calls to other modules or pages.
- **Sending Required Parameters**: Transmitting necessary parameters using RouteParameter or Dictionary.
- **Receiving Transmitted Parameters**: Capturing and handling the sent parameters.
- **Transforming Received Parameters**: Converting received parameters into Decodable formats using RouteValue.

## Installation

### Manual Installation

1. **Clone the Repository**:
   - Clone this repository locally or add it as a Git submodule in your project's repository.
   
2. **Add to Your Project**:
   - Include the `RouteCoordinator` folder in your Xcode project.

### Cocoapods Installation

Add the following source and pod statement to your Podfile:

```ruby
pod 'RouteCoordinator'
```

### Usage

1. **Import the Library**:
   - Import the library in your Swift files where you intend to use it.
   ```swift
   import RouteCoordinator
   ```

Follow these steps to seamlessly integrate the RouteCoordinator library into your project.

## Getting Started

### Registering a Route Coordinator

Before utilizing a route coordinator, you must register it with the `RouteManager`. Typically, this is done in your `AppDelegate` or a similar entry point in your application.

```swift
RouteManager.shared.register(YourModuleRouteCoordinator.self)
```

`YourModuleRouteCoordinator` is an example or placeholder referring to a specific route coordinator class that you need to define to enable the calling of your module. To enable your module to be invoked using `RouteManager`, you'll need to create a bridge allowing access to your module. This is achieved by creating `YourModuleRouteCoordinator` conforming to the `RouteCoordinator` protocol.

### Creating a Route Coordinator

Create a route coordinator by conforming to the `RouteCoordinator` protocol. Here's a basic example:

```swift
import UIKit
import RouteCoordinator

class YourModuleRouteCoordinator: RouteCoordinator {

    // MARK: ROUTE COORDINATOR
    
    static var path: String { return "/your_path" }
    
    func route() { 
       // Define how your coordinator should handle routing.
     }
}
```

The `YourModuleRouteCoordinator` demonstrates a basic implementation of a RouteCoordinator. It grants access to properties within the protocol, facilitating navigation, parameter handling, and completion callbacks.

Using the RouteCoordinator protocol, you can access properties defined within it, such as:

1. **navigationController**: This property refers to the navigation controller being supervised by the coordinator. It allows the coordinator to manage the navigation flow within the app, facilitating transitions between different views or view controllers.

2. **parameter**: This property holds received data that can be processed by the coordinator. It typically includes information essential for navigation or any additional details required during the coordination process. For example, it might contain parameters necessary for configuring a specific screen or module.

3. **completion**: This property is a closure that handles the outcome of a coordinator's operation. It's structured to receive a Result object, which encapsulates either data or an error. This closure enables the coordinator to respond to the success or failure of its operations, allowing for appropriate handling or further actions based on the result.

### Transforming Parameters

The parameter property still encapsulates data in the form of a [String: Any]. To process this data into a struct that you can utilize, you'll need to decode it. One way to achieve this is by using the provided method:

```swift
func transform<T: Decodable>(to type: T.Type) -> Result<T, Error>
```

This method allows you to transform the data within the parameter property into a specified Decodable type. It returns a Result containing the decoded value if successful or an error if the transformation fails. This way, you can efficiently decode the RouteParameter into the desired struct type and handle it accordingly within your coordinator or module.

### Auto Transforming Parameters

By adopting the `Transformable` protocol, manual transformation becomes unnecessary. Add the `Transformable` protocol to your coordinator and create a struct conforming to `RouteValue` to simplify parameter decoding.

```swift
class YourModuleRouteCoordinator: RouteCoordinator, Transformable
```

However, you must add the protocol stub for `Transformable`.

```swift
typealias RouteData = RouteDataValue
```

Create a `struct` conforming to `RouteValue` to facilitate parameter decoding:

```swift
struct RouteDataValue: RouteValue {
    let title: String?
}
```

This `RouteDataValue` struct serves as an example demonstrating how parameters can be decoded into a structured format. It contains properties that align with the data structure required, conforming to the `RouteValue` protocol."

### Routing

#### Basic Routing
Routing to a registered coordinator involves passing parameters to customize the coordinator's behavior or provide data to the presented view controller.

For basic routing to a registered coordinator:

```swift
RouteManager.shared.route(path: "/your_path", navigationController: navigationController)
```

This snippet enables navigation to a coordinator registered with the specified path, utilizing the provided `navigationController`. This mechanism allows for streamlined navigation to the designated coordinator within your application flow.

#### Routing with Completion

Routing with implementation for completion enables you to obtain completion data when performing routing. This is valuable when the module you call has a callback or to determine if there are any errors during routing.

```swift
RouteManager.shared.route(path: "/your_path", navigationController: navigationController) { result in
    print(result)
}
```

This code snippet extends the routing functionality by including a completion closure. The `result` parameter within the closure captures the completion data, allowing you to handle it accordingly. This mechanism is useful for processing callbacks or diagnosing any potential errors that might occur during the routing process.

#### Retrieving Completion Results

To process data returned from the module being called:

```swift
struct Response: RouteResponse {
    let status: Bool?
}

RouteManager.shared.route(path: "/your_path", navigationController: navigationController) { (result: Result<Response, Error>) in
    switch result {
        case let .success(data):
            print(data)
        case let .failure(error):
            print(error)
    }
}
```

In this updated completion block, the `Result` type is specified with the `MyResultData` struct and the `Error` type. This allows you to handle the success and failure cases accordingly. When the routing operation completes successfully, the retrieved data is of type `MyResultData`, which you can process within the `.success` case. If an error occurs during routing, it's captured within the `.failure` case for appropriate error handling.

### Sending Parameters

To send parameters using `RouteManager`, create a struct conforming to `RouteParameter` or pass Dictionary:

```swift
struct MyParameter: RouteParameter {
    let title: String?
}
```

Use this parameter when routing:

```swift
let parameter = MyParameter(title: "Just title")
// or let paramter = ["title": "Just title"]
RouteManager.shared.route(path: "/your_path", with: parameter, navigationController: navigationController) { (result: Result<MyResultData, Error>) in
    switch result {
        case let .success(data):
            print(data)
        case let .failure(error):
            print(error)
    }
}
```

In this scenario, `MyParameter` is a struct conforming to `RouteParameter` and contains a property `title`. When using `RouteManager` to navigate to the specified path, the `parameter` instance of `MyParameter` is passed along. This parameter can be utilized within the targeted coordinator/module for customization or data transmission

### Additional Functionality
#### Calling Route Coordinator without a Path for Pages within the Same Module

In certain cases, you may need to access other pages that don't possess a specified path, especially when these pages aren't exposed publicly but still reside within the same module. You can directly invoke these pages without employing `RouteManager`, using the coordinator itself.

```swift
let coordinator = YourModuleRouteCoordinator(parameter: nil, completion: nil)
coordinator.navigationController = navigationController
coordinator.route()
```

In this scenario, the `YourModuleRouteCoordinator` instance is created without specifying any parameters or completion block. By assigning the `navigationController`, the coordinator gains access to manage the navigation flow. Invoking the `route()` method triggers the coordinator's navigation logic, allowing seamless access to the specified page or module within the application.
