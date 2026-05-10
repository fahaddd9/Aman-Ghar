# 05 - Complete UI & Provider Side Implementation Phase

**Phase Owner:** Senior Flutter Architect & UI/UX Lead  
**Duration:** 8–12 days  
**Objective:** Build a **fully complete, consistent, beautiful, and fully navigable GUI** for both Hirer (Customer) and Provider (Service Provider) roles, using the improved Design System established in Phase 04.

This phase transforms the app from a partial Hirer-only UI into a **true two-sided marketplace** with excellent user experience for both sides.

---

## 1. Prerequisites (Must Complete Before Starting This Phase)

- All screens from Phase 04 must be fixed and use the new Design System.
- `flutter_screenutil` is properly initialized and used everywhere.
- Reusable widgets (`AmanGharButton`, `CustomAppBar`, `AmanGharCard`, etc.) are created and being used.
- New premium logo and branding are applied.

---

## 2. Detailed Step-by-Step Implementation Plan

### Step 1: Finalize & Strengthen Design System (Day 1)
**Detailed Tasks:**
- Review all components created in Phase 04 and enhance them if needed (add more variants).
- Create additional reusable widgets needed for this phase:
  - `RequestCard` (for Provider incoming requests)
  - `EarningsSummaryCard`
  - `AvailabilityToggle`
  - `ModernBottomNavBar` (role-aware)
- Define dark mode readiness (even if not implementing now).
- Create a `UI_Components_Showcase` screen (temporary) to verify consistency.

**Success Criteria:** No new widget should be created outside the shared widgets folder.

---

### Step 2: Implement All Missing Hirer Screens (Day 1–3)

**2.1 Forgot Password Screen**
- Clean, minimal screen with email/phone input and "Send Reset Link" button.
- Success message with animation.

**2.2 Edit Profile Screen**
- Profile picture with camera/gallery picker option.
- Editable fields: Name, Phone, Address, Bio (for Hirer).
- Save button with loading state.

**2.3 Payment History Screen**
- List of past transactions with date, amount, provider name, and status.
- Use consistent card design.

**2.4 Support Screen**
- FAQ accordion style.
- Contact form or "Chat with Support" button.
- Call / Email options.

**2.5 About AmanGhar Screen**
- App logo, version, mission statement, privacy policy links.
- Clean, elegant about page.

**2.6 Rate Now Screen**
- Star rating + text review + optional photo upload.
- Submit button.

---

### Step 3: Create Provider Side Dashboard & Flows (Day 3–7)

**3.1 Provider Home / Dashboard Screen**
- Top greeting with name and availability toggle (Online/Offline).
- Summary cards: Today’s Earnings, Active Bookings, Rating.
- Section: "Incoming Requests" (list of new booking requests with Accept/Reject buttons).
- Section: "My Services" (quick stats).

**3.2 Incoming Booking Request Detail Screen**
- Full booking details from customer.
- Accept / Reject buttons with optional message field.
- Navigation to Chat after acceptance.

**3.3 Provider Profile Management**
- Similar to Hirer Edit Profile but with:
  - Services offered (Daily Cook, Full-Time Maid, etc.)
  - Experience, Skills, Languages
  - CNIC upload section (dummy for now)
  - Availability calendar preview

**3.4 Provider Earnings Screen**
- Monthly/Weekly earnings summary.
- List of completed bookings with payout status.

**3.5 Reuse & Adapt Existing Screens for Provider Role**
- Chat Screen (same UI, different header/context)
- Booking Status Screen (provider perspective)
- My Bookings / Requests Screen

---

### Step 4: Unified Bottom Navigation & Role Switching (Day 7)
**Final Bottom Navigation (4 items):**
- **Home** (Role-aware: Hirer sees discovery, Provider sees requests)
- **Bookings** (Hirer: My Bookings | Provider: My Requests)
- **Inbox** (Chat list / Messages)
- **Profile**

**Implementation:**
- Make bottom nav role-aware using Riverpod.
- Smooth transition when role changes (for testing).

---

### Step 5: Full Navigation & Flow Testing (Day 8–9)
**Test These Critical Flows:**
1. Hirer Complete Booking Flow (Home → Category → Profile → Booking → Payment → Success → Status → Chat)
2. Provider Flow (Home → View Request → Accept → Chat)
3. Profile → Edit Profile → Save
4. Rate Now from completed booking
5. Forgot Password flow

**Ensure:**
- No dead ends or broken navigation.
- Consistent back button behavior.
- Proper deep linking readiness with go_router.

---

### Step 6: Final Polish & Optimization (Day 10–12)
**Tasks:**
- Add subtle animations throughout (Hero, scale, fade).
- Implement skeleton loaders for lists.
- Optimize list performance (ListView.builder + keys).
- Ensure perfect responsiveness with `flutter_screenutil`.
- Final visual consistency audit across all 20+ screens.
- Prepare screenshots and screen recording for documentation and presentation.

---

## 3. Exit Criteria for Phase 05

- All screens (Hirer + Provider) are implemented and fully navigable.
- The app feels like a **professional, premium two-sided marketplace**.
- Design system is strictly followed everywhere.
- No UI/UX inconsistencies remain.
- App works smoothly on different screen sizes.
- All buttons and links work as expected.

**Next Phase After Completion:** `06_firebase_auth_integration.md`

---

**Approval & Sign-off Section**
- [ ] Design System Applied Everywhere
- [ ] All Missing Screens Added
- [ ] Provider Side Fully Implemented
- [ ] Full Navigation Tested
- [ ] Responsiveness Verified

---

This document is now **extremely detailed**, well-structured, and leaves zero ambiguity — just like the previous Phase 04 file.

---

**All Refined Documents Are Ready:**

- `04_ui_improvement_and_fix_phase.md` (Already provided)
- `05_complete_ui_and_provider_side.md` (Just refined above)

Would you like me to refine any other phase file, or shall we begin actual implementation with:

**“Start Phase 04”**

Just reply and I will start coding immediately (Design System + fixes for existing screens). 

I’m fully prepared to take AmanGhar to the next level.