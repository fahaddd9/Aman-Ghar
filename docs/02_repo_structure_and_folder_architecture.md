# 02 - Repository Structure & Folder Architecture (UI Phase)

**Project Folder:** `amanghar_app/`
amanghar_app/
├── docs/                          # All phase documents
├── assets/
│   ├── images/                    # Profile pics, service icons, lottie
│   ├── icons/
│   └── localization/
├── lib/
│   ├── core/
│   │   ├── config/
│   │   │   ├── app_theme.dart          # AmanGhar Color Scheme + ThemeData
│   │   │   ├── routes.dart             # All go_router routes
│   │   │   └── constants.dart
│   │   ├── utils/
│   │   └── widgets/                    # Shared widgets (CustomButton, VerifiedBadge, etc.)
│   ├── features/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── search/
│   │   ├── profile/
│   │   ├── booking/
│   │   ├── chat/
│   │   └── common/                     # Reusable screens if needed
│   ├── shared/
│   │   ├── models/                     # Dummy models (Provider, Booking, etc.)
│   │   └── extensions/
│   └── main.dart
├── pubspec.yaml
└── localization/                  # en.json, ur.json


**Important Rules:**
- Every screen must use the **same AmanGhar theme** defined in `core/config/app_theme.dart`.
- All UI components must follow the **exact widget tree** from the PDF wireframes.
- Keep the UI advanced, minimal, and modern (generous spacing, subtle animations, premium cards).

**Next File:** `03_phases_implementation_plan.md`