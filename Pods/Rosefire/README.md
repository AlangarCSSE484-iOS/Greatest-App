# Rosefire iOS SDK

![iOS](https://img.shields.io/badge/swift-v2.1.0-blue.svg)

## Setup

If you use cocoa pods then use the following instructions.

```ruby
platform :ios, '11.0'
use_frameworks!

# ... Other pods ...

pod 'Rosefire', :git => 'https://ada.csse.rose-hulman.edu/rosefire/ios-sdk.git'
```

Then run `pod install`

## Usage with Firebase

### Swift Projects

**Step 1:** Import Firebase and Rosefire in the file you're using it
```swift
import Rosefire
import Firebase
```

**Step 2:** Authenticate a Rose-Hulman User with Firebase:

```swift
Rosefire.sharedDelegate().uiDelegate = self // This should be your view controller
Rosefire.sharedDelegate().signIn(REGISTRY_TOKEN) { (err, result) in
  FIRAuth.auth()?.signInWithCustomToken(result.token) { (user, error) in
    if error == nil {
      // User's logged in!
    } else {
      // An error occured!
    }
  }
}
```

### Objective-C Projects

**Step 1:** Import Firebase and Rosefire in the file you're using it
```objc
#import <Firebase/Firebase.h>
#import <Rosefire/Rosefire.h>
```

**Step 2:** Authenticate a Rose-Hulman User with Firebase:

```objc
[Rosefire sharedDelegate].uiDelegate = self // This should be your view controller
[[Rosefire sharedDelegate] signIn:REGISTRY_TOKEN
                      withClosure:^(NSError* err, RosefireResult* result) {
  [[FIRAuth auth] signInWithCustomToken:result.token
    completion:^(FIRUser *_Nullable user,
        NSError *_Nullable error) {
      if (!error) {
        // Show logged in UI
      } else {
        // Show login error
      }
    }];
}];
```
## Standalone Usage

### Swift Projects

**Step 1:** Import Rosefire
```swift
import Rosefire
```

**Step 2:** Authenticate a Rose-Hulman User and get the JWT:

```swift
Rosefire.sharedDelegate().uiDelegate = self // This should be your view controller
Rosefire.sharedDelegate().signIn(REGISTRY_TOKEN) { (err, result) in
  if err == nil {
    // Use this token to authenticate your user with a server
    // see the server SDKs for more information
  } else {
    // Login did not work!
  }
}
```

### Objective-C Projects

**Step 2:** Import Rosefire in the file you're using it
```objc
#import <Rosefire/Rosefire.h>
```

**Step 3:** Authenticate a Rose-Hulman User and get the JWT:

```objc
[Rosefire sharedDelegate].uiDelegate = self // This should be your view controller
[[Rosefire sharedDelegate] signIn:REGISTRY_TOKEN
                           withClosure:^(NSError* err, RosefireResult* result) {
  if (!error) {
    // Use this token to authenticate your user with a server
    // see the server SDKs for more information
  } else {
    // Show login error
  }
}];
```

