# Zero Waste Citizen

Zero Waste Citizen is a Flutter mobile app for responsible waste management: segregation guidance, AI-assisted scanning, pickup scheduling, nearby recycling centers, eco rewards, and community engagement.

## What Is Included

- Flutter + Dart source with Material 3 UI.
- Provider-based MVVM state management.
- Clean folder separation for models, services, repositories, providers, screens, widgets, routing, theme, and utilities.
- Firebase-ready Auth, Firestore, Storage, and Cloud Messaging service layers.
- Google Sign-In, email login/register, forgot password, onboarding, and persistent onboarding state.
- Dashboard with animated metric cards and charts.
- Waste segregation guide with search and bin colors.
- AI scanner using a mock TensorFlow Lite-style classifier.
- Pickup booking, tracking status, Google Maps UI, and history.
- Rewards, badges, streaks, challenges, leaderboard, marketplace, and green certificate concept.
- Community feed with post composer, image feed, likes, comments, challenges, and leaderboard.
- Nearby recycling center map/list.
- Theme switching, localization scaffold, offline preferences, accessibility-aware Material widgets.
- QR verification, barcode scanner, chatbot, and smart-bin IoT placeholders.

## Folder Structure

```text
lib/
  core/
    constants/        App constants and Firestore collection names
    routing/          Central route table
    theme/            Light/dark Material 3 theme
    utils/            Validators, errors, calculators
  data/
    dummy/            Demo data for offline-first previews
    models/           Serializable domain models
    repositories/     Repository pattern over Firebase/services
    services/         Firebase, cache, notifications, AI classifier
  presentation/
    providers/        MVVM view models using Provider
    screens/          Feature screens
    widgets/          Reusable UI components
```

## Setup

1. Install Flutter latest stable.

   ```bash
   flutter --version
   ```

2. Generate platform folders if you start from this source-only workspace:

   ```bash
   flutter create .
   ```

3. Install packages:

   ```bash
   flutter pub get
   ```

4. Configure Firebase:

   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

   Replace `lib/firebase_options.dart` with the generated file.

5. Enable Firebase products:

   - Authentication: Email/password and Google provider.
   - Cloud Firestore.
   - Firebase Storage.
   - Firebase Cloud Messaging.

6. Configure Google Maps:

   - Android: add the Maps API key in `android/app/src/main/AndroidManifest.xml`.
   - iOS: add the key in `ios/Runner/AppDelegate.swift`.

7. Run:

   ```bash
   flutter run
   ```

## Android Notes

The app is optimized Android-first. After running `flutter create .`, add these permissions to the Android manifest:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

Inside the `<application>` tag:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY" />
```

## Firestore Schema

See [firestore_schema.md](/Users/macm2/Documents/Codex/2026-05-08/zero-waste-citizen-flutter-app-development/firestore_schema.md) for admin-ready collections:

- `users`
- `pickups`
- `rewards`
- `reports`
- `communityPosts`
- `recyclingCenters`
- `challenges`
- `notifications`

## Production Next Steps

- Replace mock classifier with a TensorFlow Lite model and label map.
- Add real Firestore security rules and indexes for pickup/history queries.
- Add real notification routing for pickup reminders and challenge updates.
- Add widget tests and integration tests once Flutter SDK is available.
- Connect admin dashboard using the same Firestore collections and custom admin claims.
# zwc
