# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application demonstrating authentication flow with Lottie animations and theme switching. The app uses a simple hardcoded login system (email: '123', password: '456') and supports light/dark mode theming with a teal color scheme.

## Development Commands

### Running the App
```bash
flutter run
```

### Building
```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

### Dependencies
```bash
# Install dependencies
flutter pub get

# Update dependencies
flutter pub upgrade
```

### Code Analysis
```bash
# Run static analysis
flutter analyze
```

### Testing
```bash
# Run all tests
flutter test
```

## Architecture

### State Management Pattern
The app uses **ValueNotifier** for lightweight state management instead of more complex solutions like Provider or Riverpod:
- `ValueNotifier<T>`: Holds reactive data
- `ValueListenableBuilder`: Listens to changes without requiring `setState()`
- See `lib/data/notifiers.dart` for global state notifiers

### Global State (lib/data/notifiers.dart)
- `selectedPageNotifier`: Tracks current bottom navigation page (0 = Home, 1 = Profile)
- `isDarkModeNotifier`: Controls app-wide theme mode (default: true/dark)

### Navigation Flow
1. **WelcomePage** (`lib/views/pages/welcome_page.dart`): Entry point with Lottie animation
   - "Get Started" button → LoginPage with title "Register"
   - "LOGIN" button → LoginPage with title "Login"

2. **LoginPage** (`lib/views/pages/login_page.dart`): Authentication screen
   - Hardcoded credentials: email='123', password='456'
   - On success: `Navigator.pushReplacement()` to WidgetTree

3. **WidgetTree** (`lib/views/widget_tree.dart`): Main app container
   - Hosts AppBar with theme toggle and settings button
   - Contains bottom navigation switching between HomePage and ProfilePage
   - Settings button pushes SettingsPage without replacing navigation stack

### Page Structure
- `pages` list in `widget_tree.dart` defines available bottom navigation pages
- Bottom navigation managed by `NavbarWidget` using `selectedPageNotifier`
- Current page displayed via `ValueListenableBuilder` in WidgetTree body

### Theming
- Seed color: `Colors.teal`
- Theme switches globally via `isDarkModeNotifier` toggle in AppBar
- MaterialApp rebuilds on theme change using `ValueListenableBuilder`

### Assets
- **Lottie animations**: `assets/lotties/` (welcome.json, home.json)
- **Images**: `assets/images/` (bg.png)
- All assets must be declared in `pubspec.yaml` under `flutter.assets`

### Key Dependencies
- `lottie: ^3.3.2`: For Lottie animations
- `cupertino_icons: ^1.0.8`: iOS-style icons
- `flutter_lints: ^6.0.0`: Code quality linting

## Important Notes

### State Management
When adding new global state, follow the ValueNotifier pattern in `lib/data/notifiers.dart`. Avoid introducing heavy state management packages unless the app complexity significantly increases.

### Navigation
- Use `Navigator.push()` for temporary screens (Settings)
- Use `Navigator.pushReplacement()` for flow completion (after login)
- The app uses imperative navigation; avoid adding declarative routing without discussing architecture changes

### Styling
- Reusable text styles defined in `lib/data/constants.dart` (KTextStyle class)
- Maintain consistency with existing teal/blue color scheme
- Button styling uses Material 3 widgets (FilledButton, ElevatedButton, TextButton)

### Authentication
Current login is a placeholder with hardcoded credentials. When implementing real authentication:
- Remove hardcoded credentials from `lib/views/pages/login_page.dart:16-19`
- Consider adding proper form validation
- Implement secure credential storage
- Add error handling and user feedback
