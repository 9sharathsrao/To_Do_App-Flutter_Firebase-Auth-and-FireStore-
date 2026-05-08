# ✅ To-Do Task Management App

A cross-platform task management application built with **Flutter and Firebase**, featuring cloud sync, local storage, and secure authentication.

---

## 🚀 Features

- 🔐 Secure user authentication via Firebase Authentication
- ☁️ Cloud data sync with Firestore
- 💾 Offline support using Sqflite (local SQLite storage)
- 📝 Full CRUD — create, read, update, and delete tasks
- 📊 Task progress tracking
- 📱 Responsive and user-friendly mobile UI for Android & iOS

---

## 🛠️ Tech Stack

| Layer          | Technology                   |
|----------------|------------------------------|
| Frontend       | Flutter (Dart)               |
| Auth           | Firebase Authentication      |
| Cloud DB       | Firestore                    |
| Local DB       | Sqflite (SQLite)             |

---

## ⚙️ Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.0 or above)
- A [Firebase](https://firebase.google.com/) project with the following enabled:
  - Firebase Authentication (Email/Password)
  - Firestore Database

---

## 🏃 How to Run

### Step 1 — Clone the Repository

```bash
git clone https://github.com/your-username/todo-app.git
cd todo-app
```

### Step 2 — Connect Firebase

- Go to [Firebase Console](https://console.firebase.google.com/) and create a project
- Download `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS)
- Place them in their respective directories:
  - `android/app/google-services.json`
  - `ios/Runner/GoogleService-Info.plist`

### Step 3 — Install Dependencies

```bash
flutter pub get
```

### Step 4 — Run the App

```bash
# Android
flutter run

# iOS (macOS only)
flutter run -d ios
```

---

## 🗄️ Firestore Schema

```
users (collection)
└── {userId} (document)
    └── tasks (subcollection)
        └── {taskId}
            ├── title: String
            ├── description: String
            ├── isCompleted: Boolean
            └── createdAt: Timestamp
```

---

## 🐛 Troubleshooting

| Issue | Fix |
|---|---|
| Firebase not initialized | Ensure `google-services.json` is placed correctly and `firebase_core` is initialized in `main.dart` |
| Auth error | Enable Email/Password sign-in in Firebase Console → Authentication |
| Firestore read/write failing | Check Firestore security rules allow authenticated users |
| Local tasks not syncing | Verify Sqflite ↔ Firestore sync logic in `services/` | 
