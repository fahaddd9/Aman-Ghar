// ─────────────────────────────────────────────────────────────────────────────
// AppConstants — AmanGhar App-Wide Constants
// ─────────────────────────────────────────────────────────────────────────────
class AppConstants {
  AppConstants._();

  // ── App Identity ──────────────────────────────────────────────────────────
  static const String appName = 'AmanGhar';
  static const String appNameUrdu = 'اَمن گھر';
  static const String tagline = 'Reliable Help for Your Home – Trusted by Families in Lahore';
  static const String taglineShort = 'Trusted Help for Lahore Families';

  // ── Splash ────────────────────────────────────────────────────────────────
  static const Duration splashDuration = Duration(milliseconds: 2500);
  static const Duration splashLogoFadeDuration = Duration(milliseconds: 800);
  static const Duration splashTitleDelay = Duration(milliseconds: 400);
  static const Duration splashTaglineDelay = Duration(milliseconds: 700);

  // ── Animation Durations ───────────────────────────────────────────────────
  static const Duration buttonPressDuration = Duration(milliseconds: 120);
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Duration modalTransitionDuration = Duration(milliseconds: 280);
  static const Duration chipAnimationDuration = Duration(milliseconds: 150);
  static const Duration listStaggerDelay = Duration(milliseconds: 60);
  static const Duration successIconDuration = Duration(milliseconds: 500);

  // ── Button Press Scale ────────────────────────────────────────────────────
  static const double buttonPressScale = 0.96;
  static const double chipSelectScale = 1.04;

  // ── Onboarding ────────────────────────────────────────────────────────────
  static const String hirerRoleName = 'I Need Help at Home';
  static const String hirerRoleDescription =
      'Browse and hire trusted cooks and maids for your family in Lahore.';
  static const String providerRoleName = 'I Offer My Services';
  static const String providerRoleDescription =
      'List your skills and get steady work opportunities near you.';

  // ── Login ────────────────────────────────────────────────────────────────
  static const String loginTitle = 'Welcome Back';
  static const String hirerLoginSubtitle =
      'Find trusted help for your home today.';
  static const String providerLoginSubtitle =
      'Manage your bookings and grow your income.';

  // ── Home ─────────────────────────────────────────────────────────────────
  static const String homeGreetingMorning = 'Good morning';
  static const String homeGreetingAfternoon = 'Good afternoon';
  static const String homeGreetingEvening = 'Good evening';
  static const String homeSearchHint = 'Search for cooks, maids...';
  static const String homeServicesSection = 'Services';
  static const String homeRecentBookingsSection = 'Recent Bookings';
  static const String homeSeeAll = 'See All';

  // ── Search ────────────────────────────────────────────────────────────────
  static const String searchResultsTitle = 'Search Results';
  static const String searchFilterAll = 'All';

  // ── Service Profile ───────────────────────────────────────────────────────
  static const String profileAboutSection = 'About';
  static const String profileServicesSection = 'Services Provided';

  // ── Booking ───────────────────────────────────────────────────────────────
  static const String bookingTitle = 'Schedule Booking';
  static const String bookingDateSection = 'Select Date';
  static const String bookingTimeSection = 'Select Time';
  static const String bookingDetailsSection = 'Service Details';
  static const String bookingPriceSection = 'Price Breakdown';
  static const String bookingAddressSection = 'Service Address';
  static const String bookingAddress =
      'House 12, Block C, DHA Phase 6, Lahore';
  static const String bookingConfirmButton = 'CONFIRM BOOKING';

  // ── Payment ───────────────────────────────────────────────────────────────
  static const String paymentTitle = 'Payment Method';
  static const String paymentSavedCards = 'Saved Cards';
  static const String paymentAddCard = 'Add New Card';
  static const String paymentOtherOptions = 'Other Options';
  static const String paymentProceedButton = 'PROCEED TO PAY';

  // ── Payment Success ───────────────────────────────────────────────────────
  static const String successTitle = 'Booking Confirmed!';
  static const String successSubtitle =
      'Your booking is confirmed.\nAyesha, Anita will arrive tomorrow at 8:00 AM.';
  static const String successTrackButton = 'TRACK BOOKING STATUS';

  // ── Booking Status ────────────────────────────────────────────────────────
  static const String statusTitle = 'Booking Status';
  static const String statusEta = 'ETA: 15 min';
  static const String statusOnTheWay = 'Anita is on her way';

  // ── Chat ──────────────────────────────────────────────────────────────────
  static const String chatInputHint = 'Type a message...';
  static const String chatOnline = 'Online';

  // ── Profile ───────────────────────────────────────────────────────────────
  static const String profileTitle = 'My Profile';
  static const String profileMyBookings = 'My Bookings';
  static const String profileEditProfile = 'Edit Profile';
  static const String profilePaymentHistory = 'Payment History';
  static const String profileSupport = 'Support';
  static const String profileAbout = 'About AmanGhar';
  static const String profileLogout = 'LOG OUT';

  // ── Dummy User ────────────────────────────────────────────────────────────
  static const String dummyUserName = 'Ayesha Malik';
  static const String dummyUserEmail = 'ayesha.malik@gmail.com';
  static const String dummyUserLocation = 'DHA Phase 6, Lahore';
  static const String dummyUserPhone = '+92 300 1234567';

  // ── Service Types ─────────────────────────────────────────────────────────
  static const String serviceDailyCook = 'Daily Cook';
  static const String serviceFullTimeMaid = 'Full-Time Maid';
  static const String servicePartTimeMaid = 'Part-Time Maid';
  static const String serviceBabyNurse = 'Baby Nurse';
  static const String serviceDriver = 'Driver';
  static const String serviceGardener = 'Gardener';

  // ── Time Slots ────────────────────────────────────────────────────────────
  static const List<String> timeSlots = [
    '7:00 AM', '8:00 AM', '9:00 AM', '10:00 AM',
    '2:00 PM', '3:00 PM', '4:00 PM',  '5:00 PM',
  ];

  // ── Booking Steps ─────────────────────────────────────────────────────────
  static const List<String> bookingSteps = [
    'Booked', 'Confirmed', 'On the Way', 'Arrived',
  ];

  // ── Verified Label ────────────────────────────────────────────────────────
  static const String verifiedLabel = 'VERIFIED';

  // ── PKR Price Format ──────────────────────────────────────────────────────
  static String formatPrice(int amount) => 'PKR ${_formatNumber(amount)}/day';
  static String formatPriceRaw(int amount) => 'PKR ${_formatNumber(amount)}';

  static String _formatNumber(int n) {
    final s = n.toString();
    if (s.length <= 3) return s;
    final remainder = s.length % 3;
    final buffer = StringBuffer();
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
