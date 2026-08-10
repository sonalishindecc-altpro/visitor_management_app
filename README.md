# Visitor Security Management System — Flutter Application

A comprehensive, production-ready Flutter application for residential society gate security and visitor management.

## 📁 Project Structure

```text
visitor_management_app/
│
├── android/
├── ios/
├── web/
├── windows/
│
├── lib/
│   ├── main.dart                       # App entry point
│   │
│   ├── core/                           # Core utilities
│   │   ├── app.dart                    # App widget & providers
│   │   ├── theme/app_theme.dart        # Deep Navy & Gold Material 3 theme
│   │   ├── routes/app_routes.dart      # Named route map
│   │   └── constants/app_constants.dart # Colors, sizes, strings
│   │
│   ├── models/                         # Data Models
│   │   ├── user_model.dart             # Admin, Security, Resident roles
│   │   ├── visitor_model.dart          # Visitor logs & statuses
│   │   ├── apartment_model.dart        # Flat directory
│   │   ├── notification_model.dart     # Gate alerts
│   │   └── activity_model.dart         # Audit logs
│   │
│   ├── data/                           # Data Layer
│   │   ├── app_state.dart              # ChangeNotifier state provider
│   │   ├── firebase/                   # Firebase options config
│   │   └── repositories/               # Data repositories (Users, Visitors, Apartments)
│   │
│   ├── screens/                        # Application UI Screens
│   │   ├── auth/                       # Login, Register, Forgot Password, Splash
│   │   ├── admin/                      # Admin Dashboard, User/Apartment Mgmt, Analytics
│   │   ├── security/                   # Security Guard Home, Add Visitor, QR Scanner, Pass
│   │   ├── resident/                   # Resident Home, Visitor Requests, Pre-Registration
│   │   └── common/                     # Profile, Settings, Notifications, Help, About
│   │
│   ├── widgets/                        # Reusable Components
│   │   ├── visitor_card.dart           # Visitor tile card with actions
│   │   ├── dashboard_card.dart         # Animated stat counter card
│   │   ├── status_badge.dart           # Colored status pill
│   │   ├── app_button.dart             # Custom gradient button
│   │   ├── app_text_field.dart         # Styled input field
│   │   └── empty_state.dart            # Empty list display
│   │
│   └── services/                       # Infrastructure Services
│       ├── auth_service.dart           # Firebase Auth
│       ├── firestore_service.dart      # Cloud Firestore CRUD
│       ├── storage_service.dart        # Firebase Storage
│       ├── notification_service.dart   # Local & FCM push notifications
│       ├── qr_service.dart             # QR Pass generator/parser
│       └── pdf_service.dart            # PDF Analytics exporter
│
├── pubspec.yaml                        # Package dependencies
└── README.md                           # Documentation
```

## 🚀 How to Run in Android Studio

1. Open **Android Studio**.
2. Select **Open** and select `C:\Users\lokha\AndroidStudioProjects\visitor_management_app`.
3. Launch an Android Emulator (e.g. Pixel 6 / API 34).
4. Click the **Run ▶** button in Android Studio or run `flutter run` in the terminal.

## 🔥 How to Configure Firebase

1. Create a project at [Firebase Console](https://console.firebase.google.com).
2. Add an Android app with package name `com.example.visitor_management_app`.
3. Download `google-services.json` and place it in `android/app/`.
4. In `lib/main.dart`, uncomment:
   ```dart
   await Firebase.initializeApp();
   ```
5. Enable **Authentication (Email/Password)** and **Firestore Database** in Firebase Console.
