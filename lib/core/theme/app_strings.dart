// Purpose: All user-facing string constants for AmanGhar — no hardcoded strings in screens.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1: Establish Strong Design System

/// AppStrings — Every user-facing string in one place.
/// Provider names: South Asian (Anita, Fatima, Zainab, Meena, Sara).
/// Prices: PKR prefix. Locations: real Lahore neighbourhoods.
class AppStrings {
  AppStrings._();

  // ── App Identity ───────────────────────────────────────────────────────────
  static const String appName = 'AmanGhar';
  static const String appNameUrdu = 'اَمن گھر';
  static const String tagline =
      'Reliable Help for Your Home – Trusted by Families in Lahore';
  static const String taglineShort = 'Trusted Help for Lahore Families';

  // ── Onboarding — Role Selection ────────────────────────────────────────────
  static const String roleTitle = 'Who are you?';
  static const String roleSubtitle = 'Choose your role to get started';
  static const String hirerRoleName = 'I Need Help at Home';
  static const String hirerRoleDescription =
      'Browse and hire trusted cooks and maids for your family in Lahore.';
  static const String providerRoleName = 'I Offer My Services';
  static const String providerRoleDescription =
      'List your skills and get steady work opportunities near you.';

  // ── Auth — Login ───────────────────────────────────────────────────────────
  static const String loginTitle = 'Welcome Back';
  static const String hirerLoginSubtitle =
      'Find trusted help for your home today.';
  static const String providerLoginSubtitle =
      'Manage your bookings and grow your income.';
  static const String loginButton = 'LOGIN';
  static const String forgotPassword = 'Forgot Password?';
  static const String emailHint = 'Email address';
  static const String passwordHint = 'Password';
  static const String noAccount = "Don't have an account? ";
  static const String signUpLink = 'Sign Up';

  // ── Auth — Sign Up ─────────────────────────────────────────────────────────
  static const String signUpTitle = 'Create Account';
  static const String signUpSubtitle =
      'Join AmanGhar and find trusted help for your home.';
  static const String fullNameHint = 'Full name';
  static const String phoneHint = 'Phone number';
  static const String createPasswordHint = 'Create password';
  static const String createAccountButton = 'CREATE ACCOUNT';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String loginLink = 'Login';

  // ── Auth — Forgot Password ─────────────────────────────────────────────────
  static const String forgotPasswordTitle = 'Reset Password';
  static const String forgotPasswordSubtitle =
      'Enter your email and we\'ll send you a reset link.';
  static const String sendResetLink = 'SEND RESET LINK';
  static const String backToLogin = 'Back to Login';
  static const String resetSentTitle = 'Check Your Email';
  static const String resetSentSubtitle =
      'We\'ve sent a password reset link to your email address.';

  // ── Home ───────────────────────────────────────────────────────────────────
  static const String greetingMorning = 'Good morning';
  static const String greetingAfternoon = 'Good afternoon';
  static const String greetingEvening = 'Good evening';
  static const String searchHint = 'Search for cooks, maids...';
  static const String servicesSection = 'Services';
  static const String recentBookingsSection = 'Recent Bookings';
  static const String seeAll = 'See All';

  // ── Search ─────────────────────────────────────────────────────────────────
  static const String searchResultsTitle = 'Search Results';
  static const String filterAll = 'All';
  static const String noProvidersFound = 'No providers found for this category';

  // ── Service Profile ────────────────────────────────────────────────────────
  static const String aboutSection = 'About';
  static const String servicesProvidedSection = 'Services Provided';
  static const String bookNow = 'BOOK NOW';

  // ── Booking ────────────────────────────────────────────────────────────────
  static const String bookingTitle = 'Schedule Booking';
  static const String selectDate = 'Select Date';
  static const String selectTime = 'Select Time';
  static const String serviceDetails = 'Service Details';
  static const String priceBreakdown = 'Price Breakdown';
  static const String serviceAddress = 'Service Address';
  static const String defaultAddress =
      'House 12, Block C, DHA Phase 6, Lahore';
  static const String confirmBooking = 'CONFIRM BOOKING';
  static const String recurringBooking = 'Recurring Booking';
  static const String edit = 'Edit';

  // ── Payment ────────────────────────────────────────────────────────────────
  static const String paymentTitle = 'Payment Method';
  static const String savedCards = 'Saved Cards';
  static const String addNewCard = 'Add New Card';
  static const String otherOptions = 'Other Options';
  static const String proceedToPay = 'PROCEED TO PAY';
  static const String cardNumberHint = 'Card number';
  static const String expiryHint = 'MM/YY';
  static const String cvvHint = 'CVV';

  // ── Payment Success ────────────────────────────────────────────────────────
  static const String successTitle = 'Booking Confirmed!';
  static const String successSubtitle =
      'Your booking is confirmed.\nAnita will arrive tomorrow at 8:00 AM.';
  static const String trackBookingStatus = 'TRACK BOOKING STATUS';

  // ── Booking Status ─────────────────────────────────────────────────────────
  static const String statusTitle = 'Booking Status';
  static const String eta = 'ETA: 15 min';
  static const String onTheWay = 'Anita is on her way';

  // ── Chat ───────────────────────────────────────────────────────────────────
  static const String chatInputHint = 'Type a message...';
  static const String online = 'Online';

  // ── Profile ────────────────────────────────────────────────────────────────
  static const String profileTitle = 'My Profile';
  static const String myBookings = 'My Bookings';
  static const String editProfile = 'Edit Profile';
  static const String paymentHistory = 'Payment History';
  static const String support = 'Support';
  static const String aboutApp = 'About AmanGhar';
  static const String logout = 'LOG OUT';
  static const String logoutConfirmTitle = 'Log Out?';
  static const String logoutConfirmMessage =
      'Are you sure you want to log out of AmanGhar?';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';

  // ── Edit Profile ───────────────────────────────────────────────────────────
  static const String editProfileTitle = 'Edit Profile';
  static const String saveChanges = 'SAVE CHANGES';
  static const String changePhoto = 'Change Photo';
  static const String nameLabel = 'Full Name';
  static const String phoneLabel = 'Phone Number';
  static const String addressLabel = 'Address';

  // ── Payment History ────────────────────────────────────────────────────────
  static const String paymentHistoryTitle = 'Payment History';
  static const String noPayments = 'No payment history yet';

  // ── Support ────────────────────────────────────────────────────────────────
  static const String supportTitle = 'Support';
  static const String faqTitle = 'Frequently Asked Questions';
  static const String contactUs = 'Contact Us';
  static const String emailSupport = 'Email Support';
  static const String callSupport = 'Call Support';

  // ── About ──────────────────────────────────────────────────────────────────
  static const String aboutTitle = 'About AmanGhar';
  static const String appVersion = 'Version 1.0.0';
  static const String aboutDescription =
      'AmanGhar is a trusted marketplace connecting Lahore households with '
      'verified cooks, maids, and domestic help. We believe every family '
      'deserves safe, reliable, and affordable home services.';
  static const String privacyPolicy = 'Privacy Policy';
  static const String termsOfService = 'Terms of Service';

  // ── Rate Now ───────────────────────────────────────────────────────────────
  static const String rateNowTitle = 'Rate Your Experience';
  static const String ratePrompt = 'How was your experience with';
  static const String writeReview = 'Write a review (optional)';
  static const String submitReview = 'SUBMIT REVIEW';
  static const String thankYou = 'Thank You!';
  static const String reviewSubmitted = 'Your review helps others find great help.';

  // ── Dummy User ─────────────────────────────────────────────────────────────
  static const String dummyUserName = 'Ayesha Malik';
  static const String dummyUserEmail = 'ayesha.malik@gmail.com';
  static const String dummyUserLocation = 'DHA Phase 6, Lahore';
  static const String dummyUserPhone = '+92 300 1234567';

  // ── Service Types ──────────────────────────────────────────────────────────
  static const String dailyCook = 'Daily Cook';
  static const String fullTimeMaid = 'Full-Time Maid';
  static const String partTimeMaid = 'Part-Time Maid';
  static const String babyNurse = 'Baby Nurse';
  static const String driver = 'Driver';
  static const String gardener = 'Gardener';

  // ── Time Slots ─────────────────────────────────────────────────────────────
  static const List<String> timeSlots = [
    '7:00 AM',
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  // ── Booking Steps ──────────────────────────────────────────────────────────
  static const List<String> bookingSteps = [
    'Booked',
    'Confirmed',
    'On the Way',
    'Arrived',
  ];

  // ── Verified Label ─────────────────────────────────────────────────────────
  static const String verifiedLabel = 'VERIFIED';

  // ── Empty States ───────────────────────────────────────────────────────────
  static const String noBookings = 'No bookings yet';
  static const String noBookingsHint =
      'Browse services and book your first trusted helper!';
  static const String noMessages = 'No messages yet';
  static const String noMessagesHint =
      'Start a conversation with your service provider.';

  // ── PKR Format ─────────────────────────────────────────────────────────────
  static String formatPrice(int amount) => 'PKR ${_formatNumber(amount)}/day';
  static String formatPriceRaw(int amount) => 'PKR ${_formatNumber(amount)}';

  static String _formatNumber(int n) {
    final String s = n.toString();
    if (s.length <= 3) return s;
    final int remainder = s.length % 3;
    final StringBuffer buffer = StringBuffer();
    if (remainder != 0) {
      buffer.write(s.substring(0, remainder));
      if (s.length > remainder) buffer.write(',');
    }
    for (int i = remainder; i < s.length; i += 3) {
      buffer.write(s.substring(i, i + 3));
      if (i + 3 < s.length) buffer.write(',');
    }
    return buffer.toString();
  }
}
