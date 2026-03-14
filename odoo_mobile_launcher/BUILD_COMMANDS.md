# Build Commands for Odoo Mobile Launcher

## Complete Build Process

### 1. Initial Setup
```bash
# Create the project (already done)
flutter create odoo_mobile_launcher

# Navigate to project directory
cd odoo_mobile_launcher

# Update dependencies in pubspec.yaml and install them
flutter pub get
```

### 2. Platform Preparation

#### Android Setup
```bash
# Add internet permission to AndroidManifest.xml
# (Already configured in this project)
```

#### iOS Setup
```bash
# Configure ATS in Info.plist for custom server connections
# (Already configured in this project)
```

### 3. Build Commands

#### For Android
```bash
# Build APK for testing
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk

# Build release APK
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app.aab

# Run on connected Android device
flutter run -d android
```

#### For iOS
```bash
# Build for iOS (requires macOS and Xcode)
flutter build ios --release
# Output: Build in ios/ folder

# Run on iOS simulator
flutter run -d ios
```

#### For Windows (Desktop)
```bash
# Build for Windows desktop
flutter build windows --release
# Output: build/windows/runner/Release/

# Note: Requires Developer Mode enabled on Windows
# Run: flutter run -d windows
```

#### For Web
```bash
# Build for web
flutter build web
# Output: build/web/

# Run locally
flutter run -d chrome
```

### 4. Verification Commands
```bash
# Check Flutter doctor for any issues
flutter doctor

# Verify installed dependencies
flutter pub get

# Run analyzer to check for issues
flutter analyze

# Run tests (if any exist)
flutter test
```

### 5. Project Structure Verification
```
odoo_mobile_launcher/
├── lib/
│   ├── main.dart
│   ├── providers/
│   │   └── app_state.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── server_url_input_screen.dart
│   │   ├── database_selection_screen.dart
│   │   ├── login_screen.dart
│   │   └── dashboard_screen.dart
│   └── services/
│       ├── api_service.dart
│       └── storage_service.dart
├── android/
├── ios/
├── web/
├── pubspec.yaml
├── README.md
└── BUILD_COMMANDS.md
```

### 6. Environment Requirements
- Flutter SDK 3.10.8 or higher
- Dart SDK bundled with Flutter
- Android SDK for Android builds
- Xcode for iOS builds (on macOS)
- Windows Developer Mode for Windows desktop builds

### 7. Dependencies Used
- http: ^1.1.0
- webview_flutter: ^4.4.2
- flutter_secure_storage: ^9.2.4
- provider: ^6.1.1
- url_launcher: ^6.3.2
- path: ^1.8.0