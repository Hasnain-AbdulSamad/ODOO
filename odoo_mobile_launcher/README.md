# Odoo Mobile Launcher

A Flutter-based mobile launcher for Odoo ERP, allowing users to connect to their Odoo server, authenticate, and access the web interface within a secure WebView.

## Features
- **Server URL Configuration:** Users can input their Odoo server URL.
- **Database Selection:** Fetches and displays available databases.
- **Secure Authentication:** Logs in via API and securely stores session cookies.
- **Persistent Session:** Auto-login on app restart.
- **WebView Integration:** Full access to Odoo web interface with JavaScript and Cookie support.

## Project Structure
```
lib/
├── main.dart                  # Entry point
├── providers/
│   └── auth_provider.dart     # State management (Auth, URL, DB)
├── screens/
│   ├── splash_screen.dart     # Initial load & auto-login check
│   ├── url_input_screen.dart  # Server URL entry
│   ├── db_selection_screen.dart # Database selection dropdown
│   ├── login_screen.dart      # Username/Password login
│   └── dashboard_screen.dart  # WebView wrapper
├── services/
│   ├── odoo_service.dart      # HTTP API calls to Odoo
│   └── storage_service.dart   # Secure storage wrapper
└── widgets/
    └── custom_widgets.dart    # Reusable UI components
```

## Build Instructions

### Prerequisites
- Flutter SDK (latest stable)
- Android Studio / Xcode

### Setup
1. **Get Dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run on Android:**
   ```bash
   flutter run -d android
   ```

3. **Run on iOS:**
   ```bash
   flutter run -d ios
   ```

### Build for Production

**Android (APK):**
```bash
flutter build apk --release
```

**iOS (IPA):**
```bash
flutter build ios --release
```

## App Store & Play Store Compliance Notes

### Android (Play Store)
- **Permissions:** Ensure `AndroidManifest.xml` includes `INTERNET` permission (added by default).
- **HTTPS:** Android 9+ requires HTTPS by default. If you need HTTP (not recommended), update `android:usesCleartextTraffic="true"` in Manifest.
- **Privacy Policy:** You must provide a privacy policy URL in the store listing since you are handling user credentials.

### iOS (App Store)
- **info.plist:** Add keys for any permissions if you expand features (e.g., Camera, Location).
- **App Transport Security (ATS):** Apple requires HTTPS. Exception domains must be explicitly declared in `Info.plist` if needed.
- **Third-party Login:** If Odoo uses OAuth/SSO (Google/Apple Sign-In), you might need to implement native Sign-In with Apple to pass review. This launcher uses standard password login, which is generally fine for enterprise companion apps.

## Troubleshooting
- **Connection Refused:** Ensure the Odoo server is accessible from the mobile device network.
- **CORS:** Mobile apps accessing Odoo API directly generally don't face CORS issues unless using Flutter Web.
