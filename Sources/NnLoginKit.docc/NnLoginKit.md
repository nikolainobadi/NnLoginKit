# ``NnLoginKit``

Easily craft intuitive login pages and streamline user authentication in your iOS applications

## Overview

`NnLoginKit` is a Swift package designed to simplify the process of implementing login and account linking features for iOS applications. Specifically designed to work with FirebaseAuth, it provides support for various authentication providers, including email/password, Google, and Apple sign-in, all wrapped in a clean, user-friendly interface. Beyond just facilitating user login, it also offers functionalities for manual authentication and managing account links. 

Manual authentication methods facilitate the user reauthentication process when performing sensitive operations such as account deletion. Account linking capabilities allow users to connect various provider accounts together, enabling seamless sign-in with any linked account and improving user retention. By leveraging these features, developers can create more robust and user-friendly authentication systems in their apps.


## Topics

### Essentials

- <doc:NnLoginKit>

### Login

- ``NnLoginAuth``

- ``AppleTokenInfo``
- ``GoogleTokenInfo``
- ``makeLoginView(titleImage:textConfig:colorsConfig:auth:)``

### Configurations

- ``NnLoginColorsConfig``
- ``NnLoginTextConfig``
- ``NnLoginColor``

### Manual Authentication

- ``NnAuthenticationHandler``

### Account Linking

- ``NnAccountLinkAuth``
- ``NnAccountLinkType``
- ``makeAccountLinkView(sectionTitle:linkButtonTint:auth:isLoading:setAuthenticationStatus:)``

### Error Handling
- ``NnDisplayableLoginError``
