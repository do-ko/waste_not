## Documentation

**Project name:** WasteNot

**Topic:** Easy-to-use application meant to help users keep track of the contents of their fridge and pantry and avoid wasting food.

**Details:** Mobile client-server application, implementing the Model-View-Controller schema.

**Technologies in use:**

- <span style="text-decoration:underline;">Frontend:</span> Flutter, using Dart language
- <span style="text-decoration:underline;">Backend:</span> Firebase
  - Firebase Authentication - authentication service
  - Firebase Firestore - document database
  - Firebase Storage - file storage, used for images
- <span style="text-decoration:underline;">Development IDE:</span> Android Studio, IntelliJ and VS Code
- <span style="text-decoration:underline;">Version control:</span> GitHub
- <span style="text-decoration:underline;">Testing tools:</span> x,y,z packages used for testing

**Project structure:**

- android - configuration and build files for Android version of the app, auto-generated
- ios - configuration and build files for iOS version of the app, auto-generated
- web - configuration and build files for Web version of the app, auto-generated
- windows - configuration and build files for Windows version of the app, auto-generated
- linux - configuration and build files for Linux version of the app, auto-generated
- macos - configuration and build files for MacOS version of the app, auto-generated

- firebase.json - Firebase configuration data
- pubspec.yaml - Flutter package configuration

- **<span style="text-decoration:underline;">assets - assets to be folded into the application executable on build</span>**
  - [category name].svg - vector icons for product categories
  - placeholder.svg - vector version of placeholder image for missing images
  - placeholder_product_image.jpg - placeholder image for a missing image in Product views
  - jingle_short.mp3 - sound file used on sign-in and adding product
- **<span style="text-decoration:underline;">integration_test - source code and data for integration tests, specifically</span>**

  - auth_test.dart - source code for the registration and login tests

- **<span style="text-decoration:underline;">lib - source code for the application</span>**
  - controllers - definitions of controllers
    - model_controllers - controllers holding and manipulating model state
      - category.dart - controller for categories
      - product.dart - controller for a single product
      - products.dart - controller for all user’s products
      - user.dart - controller for the current user
    - page_controllers - controllers for behavior of each view
      - [view name].dart - controller holding and manipulating the state of a particular view
    - shared - controllers used in more than one view
      - add_or_edit_product.dart - common controller for AddProduct and EditProduct forms
      - auth.dart - controller for authentication state and account settings
      - sound.dart - controller for playing sound
      - validator.dart - common controller for account editing and authentication forms
  - models - definitions of model entities
    - category.dart - model of the Category entity
    - product.dart - model of the Product entity
    - user.dart - model of the User entity
  - view - widget definitions
    - [view name].dart - widgets for each view
    - shared - smaller widgets and widgets common across many views
      - [name].dart - definition of a single widget
  - firebase_options.dart - default configuration of the connection to Firebase, taken as-is from the Firebase console
  - **main.dart**- entrypoint of the application, WasteNotApp widget declaration
- **<span style="text-decoration:underline;">test - source code and data for tests</span>**
  - home_view_test.dart - testing of HomeView UI component
  - product_model_test.dart - testing of Product model class
  - user_model_test.dart - testing of User model class

**Installation:**

- <span style="text-decoration:underline;">Using Android Studio:</span>
  - Connect your device to the computer
  - Turn on USB debugging mode
  - Ensure that Android Studio sees your device
  - Pick the device you connected as compilation target
  - Build and run the release version
  - The application should show up in your device apps now, even after disconnecting the device
- <span style="text-decoration:underline;">Android installation using APK file:</span>
  - Execute **flutter build apk** command in the main project folder
  - Transfer the created apk to the target device
  - Click on the file and confirm installation when prompted
  - The application should show up in your device apps now
