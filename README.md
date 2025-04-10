Features Implemented
User Authentication:

Sign up with email/password.

Sign in and sign out functionality.

Email validation for @gmail.com, @email.com, @yahoo.com domains.

Notes Functionality:

Create, read, update, and delete notes.

Notes are stored in Firebase Firestore.

User-specific notes based on Firebase Authentication (each user only sees their own notes).

Responsive UI:

Notes are displayed in a grid format on larger screens and list format on smaller screens.

Clean UI Design:

Modern design with decent gaps between notes.

Proper use of spacing, colors, and fonts.

App bar with icons for note actions (edit, delete).

Error Handling:

Proper error handling for empty fields, invalid email format, and Firebase exceptions.

Steps to Run the Project
1. Clone the repository:
   bash
   Copy
   Edit
   git clone https://github.com/yourusername/notes_app_flutter.git
2. Navigate to the project folder:
   bash
   Copy
   Edit
   cd notes_app_flutter
3. Install dependencies:
   bash
   Copy
   Edit
   flutter pub get 
4. Set up Firebase for Android and iOS:
      Firebase Android Setup:
      Go to the Firebase console: Firebase Console.

Create a new Firebase project or use an existing one.

Add an Android app in Firebase with the package name com.yourcompany.notesapp.

Download the google-services.json file and place it in the android/app directory of your Flutter project.

Enable Firebase Authentication (Email/Password sign-in).

Enable Cloud Firestore and set up a Firestore database.
5. Set up Firebase in your Flutter app:
   In the Firebase Console, under Project Settings, get the Firebase SDK config for Android and iOS.

Add your firebase_options.dart file in the /lib/ directory, which you can generate using the flutterfire CLI tool:

flutterfire configure
6. Run the app:
   After completing the Firebase setup, run your app using the following command:

flutter run
**Firebase Setup Instructions**
To set up Firebase, follow these steps:

1. Set up Firebase Project:
   Go to Firebase Console.

Create a new project or use an existing one.

2. Add Firebase to your Flutter app:
   For Android:
   In Firebase Console, add a new Android app.

Provide the package name for your Flutter app (com.yourcompany.notesapp).

Download the google-services.json file.

Place it in the android/app/ directory.


3. Enable Firebase Authentication:
   Go to the Firebase Console and enable Email/Password authentication under the Authentication section.

4. Enable Firestore:
   Go to the Firestore Database section in Firebase and create a Firestore database.


5. Add Firebase dependencies to your pubspec.yaml:=
   dependencies:
   flutter:
   sdk: flutter
   firebase_core: ^1.10.6
   firebase_auth: ^3.3.4
   cloud_firestore: ^3.1.5
   provider: ^6.0.3
6. Run
flutter pub get