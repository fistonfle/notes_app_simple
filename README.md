# Notes App - Individual Assignment 2

A Flutter notes application with Firebase authentication and Firestore database integration, implementing clean architecture and BLoC state management.

## Features

- **Firebase Authentication**: Email/password sign-up and sign-in
- **Firestore Database**: Real-time note storage and synchronization
- **Clean Architecture**: Separation of concerns with Domain, Data, and Presentation layers
- **BLoC State Management**: Predictable state management without using setState
- **CRUD Operations**: Create, Read, Update, Delete notes
- **User-specific Notes**: Each user can only access their own notes
- **Professional UI**: Material Design with proper feedback and loading states

## Architecture

```
lib/
├── core/                    # Dependency injection
├── data/                    # Data layer
│   ├── datasources/         # Firebase implementations
│   └── repositories/        # Repository implementations
├── domain/                  # Business logic layer
│   ├── entities/            # Domain models (Note, User)
│   ├── repositories/        # Repository contracts
│   └── usecases/           # Business use cases
└── presentation/           # UI layer
    ├── bloc/               # BLoC state management
    ├── pages/              # Screen widgets
    └── widgets/            # Reusable UI components
```

## BLoC State Management

This app uses the BLoC (Business Logic Component) pattern for state management:

### Why BLoC?
- **Separation of Concerns**: Business logic is separated from UI components
- **Testability**: Easy to unit test business logic independently
- **Reusability**: BLoCs can be reused across different parts of the app
- **Predictable State**: Unidirectional data flow makes state changes predictable

### How it Works:
1. **Events**: User interactions trigger events (e.g., `AddNoteRequested`)
2. **BLoC**: Processes events and emits new states
3. **States**: UI reacts to state changes (e.g., `NotesLoaded`, `NotesError`)

## CRUD Operations

The app implements all four CRUD operations:

1. **Create**: `await addNote(text, userId)` - Add new notes via dialog
2. **Read**: `await fetchNotes(userId)` - Fetch and display user notes
3. **Update**: `await updateNote(id, text)` - Edit existing notes
4. **Delete**: `await deleteNote(id)` - Remove notes with confirmation

## Firebase Setup

1. **Create Firebase Project**: At console.firebase.google.com
2. **Enable Authentication**: Email/Password provider
3. **Setup Firestore**: With user-specific security rules
4. **Download Config**: Replace `android/app/google-services.json`

### Firestore Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /notes/{noteId} {
      allow read, write: if request.auth != null && 
        request.auth.uid == resource.data.userId;
    }
  }
}
```

## Getting Started

1. **Install Flutter**: Follow instructions at flutter.dev
2. **Clone Repository**: `git clone [repository-url]`
3. **Install Dependencies**: `flutter pub get`
4. **Configure Firebase**: Replace google-services.json with your config
5. **Run App**: `flutter run`

## Dependencies

- **firebase_core**: Firebase initialization
- **firebase_auth**: Authentication
- **cloud_firestore**: Database
- **flutter_bloc**: State management
- **equatable**: Value equality

## Project Structure

- **Clean Architecture**: Domain-driven design with clear boundaries
- **BLoC Pattern**: Predictable state management
- **Firebase Integration**: Real-time data synchronization
- **Error Handling**: Comprehensive error handling with user feedback
- **Material Design**: Professional UI/UX

This project demonstrates professional Flutter development practices with scalable architecture and modern state management.
