# 03 - Detailed Implementation Phases (UI-Only Phase)

**Project:** AmanGhar  
**Current Focus:** Build a fully working, advanced, minimal, and modern UI with hard-coded data and basic authentication only.  
**Strict Rules for Every Screen:**
- Use the **AmanGhar Design System** (defined in Phase 0) consistently across the entire project.
- Follow the **exact same widget tree** as provided in the MAD assignment PDF (pages 2–13). Do not change the nesting structure, order of widgets, or component types.
- Adapt only the text/content to AmanGhar (e.g., “Daily Cook” → cooking/maid services, names like “Anita S.” remain as dummy data).
- Make the UI **advanced yet minimal and modern**: generous whitespace, subtle shadows (elevation 1–4), smooth transitions, premium cards, clean typography, and trustworthy feel using the color scheme below.
- All buttons must navigate correctly (hard-coded navigation).

### AmanGhar Color Scheme & Theme (Apply to ALL Screens)
- Primary: `#4CAF50` (Soft Green – trust)
- Secondary: `#FF9800` (Warm Orange – warmth)
- Accent: `#2196F3` (Blue – reliability)
- Background: `#FAF9F6` (Warm off-white)
- Surface/Card: `#FFFFFF`
- Text Primary: `#1F1F1F`
- Text Secondary: `#666666`
- Verified Badge: Green background with white check
- Use Material 3 + custom ThemeData. All screens must look consistent.

---

## Phase 0: Project Setup & Foundation (Do this FIRST – 1 day)

**Step-by-step:**
1. Create a new Flutter project named `amanghar_app`.
2. Set up the exact folder structure defined in `02_repo_structure_and_folder_architecture.md`.
3. Update `pubspec.yaml` with all necessary dependencies (Material 3, go_router, riverpod, easy_localization, etc.).
4. Create `lib/core/config/app_theme.dart` and define the full AmanGhar ThemeData using the color scheme above.
5. Set up `go_router` in `lib/core/config/routes.dart` with all screen routes pre-defined (even if screens are empty at first).
6. Create basic Riverpod setup for current user role (Hirer / Provider) – simple Notifier.
7. Create shared widgets folder with reusable components (VerifiedBadge, CustomFilledButton, ServiceCard, etc.).
8. Add dummy models in `lib/shared/models/`.
9. Run the app and ensure splash + theme is applied.

**Deliverable:** App runs with AmanGhar theme and router ready.

---

## Phase 1: Onboarding & Authentication (1–2 days)

**Step-by-step:**
1. Create Splash Screen (simple centered logo + tagline with fade animation).
2. Create Role Selection Screen: Two large modern cards side-by-side or stacked – “I need help at home” (Hirer) and “I offer services” (Provider). Tapping sets role via Riverpod and navigates to Login.
3. Create Login/Sign Up Screen: Tab bar (Login | Sign Up), clean form fields (Phone/Email, Password), dummy validation. On successful login, navigate to Home Screen based on selected role.
4. After login, store role in Riverpod (hard-coded for now).

**No widget tree in PDF for these** – make them modern and minimal while matching overall theme.

**Deliverable:** User can select role → login → land on Home Screen.

---

## Phase 2: Main Screens Implementation (Core Phase – 8–12 days)

**Important Instruction:**  
Implement screens **one by one** in the exact order below.  
For **each screen**:
- Create a new file in the appropriate features/ folder.
- Copy the **exact widget tree** from the PDF (provided below).
- Build the UI following that tree **without changing nesting or structure**.
- Use AmanGhar colors and theme.
- Add hard-coded dummy data (e.g., “Anita S.”, ratings 4.8★, Lahore location, dummy times/dates).
- Make every button navigate to the next screen in the flow.
- Add subtle modern touches (smooth animations, proper spacing, shadows) while keeping the structure identical.

### 2.1 Home Screen (Discovery) – PDF Page 2
**Exact Widget Tree (from PDF):**

Scaffold

AppBar
Row
Icon(location)
Text("Location (Home)")
Text("Search")
IconButton(search)


body: ListView / Column
Text("Services")
SingleChildScrollView / Row (horizontal)
Container (Card)
Column
Image (Daily Cook)
Text("DAILY COOK")
Text("Rating 4.9★")
Text("Starting Price")


(more similar cards for Full-Time Maid, etc.)

Text("Recent bookings")
Container (Booking Box)
OutlinedButton("BOOK AGAIN")


bottomNavigationBar: NavigationBar
Home
Bookings
Profile


text**Implementation Steps:**
1. Create `features/home/home_screen.dart`.
2. Build exactly the above tree.
3. Adapt texts: Services like “Daily Cook”, “Full-Time Maid”.
4. Tapping a service card → navigate to Service Profile Detail.
5. “BOOK AGAIN” → navigate to Booking Status (dummy).
6. Bottom nav items functional (Home stays, Bookings → dummy list, Profile → User Profile).

### 2.2 Search Results Screen (Listings) – PDF Page 9
**Exact Widget Tree (from PDF):**
Scaffold

AppBar
Row
IconButton(arrow_back)
Text("Search Results")
TextButton("Filter")


body: ListView
Padding
Container (Search Result Card)
Column
Row
Container (Profile Placeholder)
Column
Text("Anita S.")
Text("Rating: 4.8⭐")
Text("Starts at Price")

Align (centerRight)
OutlinedButton("SELECT")





(repeat for 2–3 cards)

bottomNavigationBar: NavigationBar (Home, Bookings, Profile)

text**Implementation Steps:** Tapping “SELECT” → Service Profile Detail. “Filter” can open a simple BottomSheet (modern design).

### 2.3 Service Profile Detail Screen – PDF Page 6
**Exact Widget Tree (from PDF):**
Scaffold

AppBar
Row
IconButton(arrow_back)
Text("Service Profile")


body: ListView / Column
Container (Gray Header)
Row
Container (Profile Image Placeholder)
Column
Text("Anita S.")
Text("VERIFIED")


Container (Stats Bar)
Row (spaceEvenly)
Column (Rating: 4.8★)
VerticalDivider()
Column (Exp: 7 YRS)
VerticalDivider()
Column (Jobs: 120+)




Padding
Row
Text("Services provided")
Icon(arrow_forward)

ListTile (Daily Cook) with trailing OutlinedButton("BOOK NOW")
(more ListTiles with Dividers)



text**Implementation Steps:** “BOOK NOW” → Booking & Schedule Screen. Show Verified badge using shared widget.

### 2.4 Booking & Schedule Screen – PDF Page 12-13
**Exact Widget Tree (from PDF):**
Scaffold

AppBar
Row
IconButton(arrow_back)
Text("Booking & Schedule")


body: ListView / Column
Text("Date")
Row (Date Selector with Cards: MON 14, TUE 15, etc.)
Text("Time slots")
Wrap / GridView (ChoiceChip time slots)
Divider()
Text("Services provided")
Row (Service Details)
Column (Price Breakdown)
Row (Address Header + EDIT)
Container (Address Box)
Row (Recurring Toggle + Switch)
Padding
FilledButton("CONFIRM BOOKING")



text**Implementation Steps:** “CONFIRM BOOKING” → Payment Method Screen.

### 2.5 Payment Method Screen – PDF Page 5
**Exact Widget Tree (from PDF):**  
(Full tree with Saved Cards, RadioButton, Add New Card fields, Other Options, PROCEED TO PAY button)

**Implementation Steps:** “PROCEED TO PAY” → Payment Success Screen.

### 2.6 Payment Success Screen – PDF Page 3
**Exact Widget Tree (from PDF):**  
(Full tree with success check, details card, TRACK BOOKING STATUS button)

**Implementation Steps:** Button → Booking Status Screen.

### 2.7 Booking Status Screen – PDF Page 7-8
**Exact Widget Tree (from PDF):**  
(Stepper with REQUEST SENT, ACCEPTED, etc., Provider Info Card, Map placeholder, MESSAGE and CALL buttons)

### 2.8 Chat Interface – PDF Page 10-11
**Exact Widget Tree (from PDF):**  
(Header with provider info, ListView of message bubbles (incoming/outgoing), Input Row with TextField + SEND button)

### 2.9 User Profile Screen – PDF Page 4
**Exact Widget Tree (from PDF):**  
(CircleAvatar, ListTiles for My Bookings, Edit Profile, Payment History, Support, black LOG OUT button + bottom nav)

**Implementation Steps for Phase 2:** After each screen, test navigation from previous screen. Ensure bottom nav works on all applicable screens.

---

## Phase 3: Provider Side (Light – 3–4 days)
- Create Provider Home (list of incoming requests – reuse similar card style).
- Reuse Chat, Booking Status, and Profile with small role-based text changes (e.g., “My Requests” instead of “My Bookings”).
- Add a simple Provider Profile edit screen with optional CNIC upload placeholder.

---

## Phase 4: Polish & Final Touches (3–5 days)
1. Add smooth page transitions and micro-animations.
2. Ensure every screen uses AmanGhar theme consistently.
3. Add modern empty/loading states.
4. Test full end-to-end flow: Home → Service Profile → Booking → Payment → Success → Status → Chat.
5. Verify bottom navigation works everywhere.
6. Prepare screenshots and update documentation.

---

**Final Note:**  
Do **not** add complex logic, real API calls, or full Riverpod providers yet. Keep everything hard-coded and navigation-focused.  
Only after all screens are built and linked perfectly will we discuss schema and backend.

**Next Action after completing these phases:** Review the full UI together, then move to backend planning.

---
