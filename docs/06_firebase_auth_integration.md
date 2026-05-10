# 06 - Firebase Authentication Integration Phase

**Phase Owner:** Senior Flutter Architect & Backend Developer  
**Duration:** 4–6 days  
**Objective:** Replace all dummy authentication with real, secure Firebase Authentication while maintaining the premium UI/UX built in previous phases.

This phase marks the transition from pure UI to a functional app with real user management.

---

## 1. Prerequisites (Must Be Completed)

- Phase 04 (UI Improvement) fully done.
- Phase 05 (Complete UI + Provider Side) fully done.
- All login, signup, forgot password, and profile screens are using the new Design System.
- `flutter_screenutil` is implemented.
- App is running smoothly with hard-coded auth.

---

## 2. Detailed Step-by-Step Implementation Plan

### Step 1: Firebase Project Setup (Day 1)
**Detailed Tasks:**
- Go to Firebase Console and create a new project named `amanghar-app`.
- Enable **Authentication** (Email/Password + Phone Auth recommended).
- Add Android app:
  - Register the app with package name.
  - Download `google-services.json` and place it in `android/app/`.
- Add iOS app (if needed):
  - Download `GoogleService-Info.plist` and place it in `ios/Runner/`.
- Enable Firestore Database (for future user profiles and roles).

### Step 2: Add Firebase Dependencies (Day 1)
Update `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.0
  cloud_firestore: ^5.4.0      # For saving user role and profile
  flutter_screenutil: ^5.9.3