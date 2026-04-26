# 01 - Project Overview & Detailed Scope

**Project Name:** AmanGhar  
**Full Title:** AmanGhar – Trusted Domestic Help Marketplace  
**Tagline:** Reliable Help for Your Home – Trusted by Families in Lahore  
**Academic Project:** CSC410 Mobile Application Development  
**University:** University of Engineering and Technology Lahore (New Campus)  
**Session:** 2023  
**Team Members:**  
- Ghulam Fareed (2023-CS-621)  
- Fahad Amir (2023-CS-603)  
**Submitted to:** Ma’am Alina Munir  

**Document Version:** 1.1 (Detailed)  
**Date:** April 2026  

---

## 1. Executive Summary

AmanGhar is a **two-sided marketplace Flutter mobile application** designed to connect households (Hirers) with reliable cooks and maids (Service Providers) in Pakistan, starting with **Lahore**. 

The app solves a real, everyday problem for Pakistani families: finding trustworthy domestic help for cooking and cleaning while providing a dignified platform for service providers to grow their income. 

Because the service involves strangers entering private homes, **trust, safety, and simplicity** are the foundational principles. The UI is being built **first** (Frontend-First approach) to ensure a polished, premium, and pixel-perfect user experience before backend integration.

This is a **semester project**, so we keep the scope minimal, focused, and realistic while maintaining production-quality code and design that can be scaled later.

---

## 2. Vision & Objectives

**Vision:**  
To become the most trusted household services platform in Pakistan by making it extremely easy and safe for families to hire reliable cooks and maids, while empowering honest service providers with steady work opportunities.

**Key Objectives:**
- Deliver a clean, modern, premium UI/UX that feels trustworthy.
- Strictly separate user roles (Hirer vs Provider).
- Follow provided wireframes and widget trees from the assignment PDF (adapted to AmanGhar context).
- Use best modern Flutter practices (Clean Architecture + Riverpod 3.x).
- Prepare a solid foundation for future Supabase backend integration.
- Complete a working, beautiful UI suitable for semester demonstration and report.

---

## 3. User Roles (Strictly Separate)

### 3.1 Customers / Hirers
- People who need domestic help in their homes.
- Primary actions: Browse, search, view profiles, book services, chat, track bookings.

### 3.2 Service Providers (Cooks & Maids)
- Individuals offering cooking or maid services.
- Primary actions: Create profile, set availability, receive/accept booking requests, chat, manage earnings.

**Rule:** No user can switch roles or be both. Role is chosen during onboarding and fixed.

---

## 4. Core Features (Minimal MVP Scope)

### 4.1 For Hirers (Customers)
- **Discovery Home Screen** – Horizontal service cards (Daily Cook, Full-Time Maid, etc.) + Recent Bookings + "Book Again" button.
- **Search & Filters** – Location (Lahore), ratings, experience, full-time/part-time, availability.
- **Service Profile Detail** – Photos, Verified badge, rating, experience, jobs completed, services offered, reviews with photos.
- **Booking Flow** – Booking & Schedule screen (date selector, time chips, service type: Full/Part-time, special notes, preferred rate for bargaining) → Confirm Booking.
- **Booking Status Tracking** – Stepper (Request Sent → Accepted → In Progress → Complete) with provider info and chat/call options.
- **In-app Chat** – Real-time style chat interface.
- **My Bookings & History** – List of current and past bookings.
- **Payment Flow (Dummy)** – Payment method screen → Payment Success → Track Booking.
- **Profile Management** – My Bookings, Edit Profile, Payment History, Support, Logout.

### 4.2 For Service Providers
- Professional profile creation (with optional CNIC upload).
- Availability management and service type selection.
- View incoming booking requests → Accept/Reject with message.
- Same chat interface.
- Simple earnings and payment history view.
- Profile & documents management.

**Note:** Provider side will be implemented after customer flows for balanced demonstration.

---

## 5. Important Scope Clarifications & Decisions

- **Service Types:** Full-time (monthly live-in or daily 8-10 hours) and Part-time (hourly or daily visits). No trial period.
- **Pricing Model:** Pure bargaining between hirer and provider. No fixed prices or platform commission in MVP.
- **Location:** Restricted to **Lahore** only (hardcoded or simple selector).
- **Trust & Safety Features:**
  - Providers can upload CNIC (front/back) optionally during profile creation.
  - Customers see only a **"Verified" badge** on profiles — no CNIC details are shown (privacy-first).
  - Reviews support photo uploads for added trust.
- **Payments:** Direct bank transfer concept. In UI phase we use dummy payment screens (no real integration).
- **Languages:** English + Urdu from day one using `easy_localization`.
- **Other Exclusions (MVP):** No family accounts, no emergency SOS, no offline caching, no advanced radius search.

---

## 6. UI/UX Design Principles & Wireframe Adaptation

We will **strictly follow** the widget trees and wireframes from the provided PDF document (`MAD assignment 621-603.docx.pdf`), while adapting content to AmanGhar:

### Key Adaptations:
- Replace "Calorie Tracker" and food-related terms with **Cooks & Maids** context.
- Service cards on Home: "Daily Cook", "Full-Time Maid", "Deep Clean" etc. → adapted to cooking/maid services.
- All "BOOK NOW", "SELECT", "CONFIRM BOOKING" buttons remain.
- Bottom Navigation: **Home | Bookings | Profile** (role-aware content).
- Profile images, ratings (e.g., 4.8★), experience stats, Verified badge will be prominent.
- Booking screens (date selector, time chips, price breakdown, address, recurring toggle) will be followed closely.
- Chat, Booking Status (stepper + map placeholder), Search Results (list cards with SELECT), Payment Success, etc., will match the widget trees exactly in structure.

**Design Goals:**
- Material 3 design with custom theme (soft green + warm beige + deep navy for trust and calmness).
- Smooth animations, hero transitions, micro-interactions.
- Premium, clean, trustworthy feel suitable for Pakistani families.
- Excellent accessibility and readability (especially for Urdu text).

---

## 7. Technical Stack & Architecture

### 7.1 Frontend (Current Focus - `amanghar_app`)
- **Flutter** (latest stable version as of 2026)
- **State Management:** Riverpod 3.x (`riverpod_annotation`, `riverpod_generator`, `hooks_riverpod`) — chosen for low boilerplate, compile safety, and excellent async/realtime support.
- **Architecture:** Clean Architecture + Feature-first modular structure + MVVM pattern.
- **Navigation:** `go_router` (type-safe, declarative routing).
- **Theming:** Material 3 with custom color scheme, typography, and components.
- **Internationalization:** `easy_localization` (JSON files for en + ur).
- **Other Key Packages:** `cached_network_image`, `image_picker`, `flutter_secure_storage`, Lottie, etc.

### 7.2 Backend (Future Phase)
- **Supabase** (PostgreSQL + Authentication + Realtime Database + Storage).
- Will handle auth, profiles, bookings, chat (realtime), and file uploads (CNIC, review photos).
- Row Level Security (RLS) policies for data safety.

### 7.3 Development Workflow
1. Complete polished UI with dummy data and Riverpod providers.
2. Implement all screens following widget trees.
3. Add smooth animations and edge-case handling.
4. Prepare API service layer (dummy → Supabase ready).
5. (Later) Integrate Supabase.

---

## 8. Repository Structure
amanghar/
├── amanghar_app/                  # Main Flutter project
│   ├── docs/                      # All markdown documentation
│   ├── lib/
│   │   ├── core/                  # Theme, router, constants, utils
│   │   ├── features/              # Feature-first modules (auth, home, booking, etc.)
│   │   ├── shared/                # Shared widgets, models, extensions
│   │   └── main.dart
│   ├── assets/                    # Images, icons, lottie files, localization
│   └── pubspec.yaml
└── amanghar_api/                  # Backend (Supabase or custom - placeholder for now)


Detailed folder architecture will be in the next document (`02_repo_structure_and_folder_architecture.md`).

---

## 9. Implementation Phases

**Phase 0:** Project Setup, Architecture, Theme, Router, Riverpod Configuration  
**Phase 1:** Onboarding & Authentication (Splash, Role Selection, Sign Up/Login, Provider CNIC optional flow)  
**Phase 2:** Customer (Hirer) Core Flows (Home, Search, Profile Detail, Booking, Status, Chat, Profile)  
**Phase 3:** Provider Core Flows  
**Phase 4:** Polish (Animations, Empty/Error states, Multi-language, Dark mode readiness)  
**Phase 5:** Dummy Data Finalization + Backend Preparation Layer

---

## 10. Success Criteria & Deliverables

- Pixel-perfect UI matching all provided widget trees.
- Smooth, delightful, trustworthy user experience.
- Clean, well-documented, maintainable code.
- Full English + Urdu support.
- Working navigation and state management across all screens.
- Professional documentation (this and subsequent .md files).
- Ready for future Supabase integration with minimal changes.

---

## 11. Risks & Mitigation

- Scope creep → Strict adherence to minimal MVP and provided wireframes.
- Design inconsistency → Single custom Theme + shared widgets.
- Performance → Proper use of Riverpod, const constructors, and list optimizations.
- Urdu text issues → Proper localization and text direction handling.

This document serves as the single source of truth for the entire project.

---




---

# AmanGhar UI-Only Phase: Design System & Scope (2026)

**Project Name:** AmanGhar  
**Tagline:** Reliable Help for Your Home – Trusted by Families in Lahore  
**Academic Project:** CSC410 Mobile Application Development (Semester Project)  
**Team:** Ghulam Fareed (2023-CS-621), Fahad Amir (2023-CS-603)  

## 1. Vision & Goal
AmanGhar is a two-sided marketplace Flutter app connecting households in Lahore with trusted cooks and maids.  
**Core Focus (Current Phase):** Build a **beautiful, advanced, minimal, and modern UI** with hard-coded data and basic authentication only. All screens must be fully linked and strictly follow the widget trees and wireframes provided in the MAD assignment PDF.

## 2. Design Philosophy
- **Advanced yet Minimal & Modern UI**: Clean layouts, generous whitespace, subtle shadows, smooth micro-animations, premium feel.
- **Trustworthy & Premium Look**: Use soft, calming colors suitable for Pakistani families.
- **Strict Theme Consistency**: Every screen must follow the **same AmanGhar Design System** defined below.

### AmanGhar Color Scheme (Apply Everywhere)
- **Primary**: `#4CAF50` (Soft Green – trust & growth)
- **Secondary**: `#FF9800` (Warm Orange – energy & home warmth)
- **Accent**: `#2196F3` (Blue – reliability)
- **Background**: `#FAF9F6` (Warm Off-white / Beige)
- **Surface/Card**: `#FFFFFF`
- **Text Primary**: `#1F1F1F`
- **Text Secondary**: `#666666`
- **Error**: `#F44336`
- **Success**: `#4CAF50`
- **Verified Badge**: Green with white check icon

**Typography**: Use `Google Fonts` – `Poppins` for headings, `Inter` for body (or default Material 3 with slight adjustments).

**Rules for All Screens**:
- Follow **Material 3** design language.
- Use consistent padding (16–24 dp), border radius (12–16), and elevation.
- All buttons, cards, and components must use the above color scheme.
- Maintain the **exact same widget tree structure** as provided in the PDF for every screen.
- Adapt only the text/content to AmanGhar (Cooks & Maids context).

## 3. Current Development Scope (UI-Only Phase)
- Hard-coded data everywhere.
- Basic Authentication + Role Selection (Hirer / Provider).
- All screens fully navigable and linked.
- No real backend or complex state yet.
- Strictly follow PDF widget trees.


