# NnLoginKit

`NnLoginKit` is a comprehensive Swift package designed to streamline the implementation of login and account linking features for iOS applications. It provides support for different authentication providers such as email/password, Google, and Apple.

## Main Features

- Email/password, Apple, and Google sign-in.
- Account linking and unlinking support.
- Customizable login interface with different color themes and text configurations.
- Error handling with clear user-facing messages.

## Getting Started

To use `NnLoginKit`, you'll need to implement the `NnLoginAuth` and `NnAccountLinkAuth` protocols which encapsulate the methods required for the authentication and account linking/unlinking processes. These protocols provide a well-defined interface for the underlying Firebase Authentication system.

### Example: Creating a Login View

Here is an example of how you can create a login view:

```swift
let textConfig = NnLoginTextConfig(appTitle: "My App", tagline: "Welcome", subTagline: "Please sign in")
let loginView = makeLoginView(titleImage: nil, textConfig: textConfig, auth: myAuthImplementation)
```

### Example: Creating an Account Link View

Similarly, you can create an account link view as follows:


```swift
let accountLinkView = makeAccountLinkView(auth: myAuthImplementation, isLoading: $isLoading)
```

## Configuration

`NnLoginKit` provides several configuration options that allow you to customize the look and feel of your login interface:

- `NnLoginColorsConfig`: Determines the colors used in the `NnLoginView`.
- `NnLoginTextConfig`: Determines the text that will be displayed on the `NnLoginView`.
- `NnLoginColor`: An enum allowing you to apply either a single color or a gradient to the background of the view.

## Error Handling

`NnLoginKit` includes a `NnDisplayableLoginError` protocol which your custom error types can conform to. This allows your application to display specific error messages to the user.
