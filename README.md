# Backend Practice – Flutter & Firebase

This is a practice project I created while learning how backend development works and how to connect a Flutter application with Firebase.

The main focus is understanding how an application communicates with backend services, handles user authentication, stores data, and makes HTTP requests. I'm using Flutter for the application side and Firebase services to explore backend functionality.

It's mainly a learning project where I'm experimenting with different tools and getting more comfortable with backend integration.

## What I'm learning
- Connecting Flutter applications with Firebase
- Firebase Authentication for user authentication
- Firebase Realtime Database for storing and retrieving data
- Making HTTP requests and understanding API communication
- Integrating backend services into Flutter
- Working with asynchronous operations
- Using external packages and dependencies
- Managing application assets and UI components

## Why I made this
As a Flutter developer, I wanted to go beyond designing interfaces and understand what happens behind the scenes.

I started exploring backend technologies to learn how applications handle authentication, communicate with servers, and manage data. This project is part of my journey toward becoming a Flutter developer with full-stack development skills.

## Built with
- Flutter / Dart
- Firebase Core (`firebase_core`)
- Firebase Authentication (`firebase_auth`)
- Firebase Realtime Database (`firebase_database`)
- `http` for HTTP requests
- `google_fonts` for custom typography
- `animated_text_kit` for text animations
- `fluttertoast` for toast notifications
- Cupertino Icons
- Git & GitHub for version control

## Project structure
```text
BackEnd-Pratice/
├── android/                 # Android configuration
├── assets/
│   └── images/              # Application images
├── lib/                     # Main Flutter source code
├── test/                    # Application tests
├── windows/                 # Windows configuration
├── firebase.json            # Firebase configuration
├── pubspec.yaml              # Dependencies and assets
└── README.md
```

## Running it yourself

You'll need Flutter, Dart, and a Firebase project configured for the application.

```bash
git clone https://github.com/daniyalakhtar67/BackEnd-Pratice.git

cd BackEnd-Pratice

flutter pub get

flutter run
```

Make sure Firebase is configured correctly before running the application.
