import '../models/provider_model.dart';
import '../models/booking_model.dart';
import '../models/message_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DummyData — All hardcoded data for AmanGhar UI-only phase
// Use exactly as specified across all screens for consistency
// ─────────────────────────────────────────────────────────────────────────────
class DummyData {
  DummyData._();

  // ── Service Providers ──────────────────────────────────────────────────────
  static const List<ServiceProvider> providers = [
    ServiceProvider(
      id: '1',
      name: 'Anita S.',
      serviceType: 'Daily Cook',
      rating: 4.8,
      reviewCount: 142,
      experienceYears: 6,
      jobsCompleted: 142,
      pricePerDay: 1200,
      location: 'DHA Phase 5',
      isVerified: true,
      imageAsset: 'assets/images/provider_1.jpg',
      bio:
          'I am a professional cook with 6 years of experience serving families across DHA, Lahore. Specializing in traditional Pakistani cuisine, continental dishes, and healthy meal prep.',
      services: [
        ProviderService(
          name: 'Daily Cook',
          pricePerDay: 1200,
          description: 'Full-day cooking — breakfast, lunch, and dinner.',
        ),
        ProviderService(
          name: 'Meal Prep (Part-Day)',
          pricePerDay: 700,
          description: 'Half-day meal preparation for busy families.',
        ),
      ],
    ),
    ServiceProvider(
      id: '2',
      name: 'Fatima R.',
      serviceType: 'Full-Time Maid',
      rating: 4.9,
      reviewCount: 198,
      experienceYears: 8,
      jobsCompleted: 198,
      pricePerDay: 900,
      location: 'Gulberg III',
      isVerified: true,
      imageAsset: 'assets/images/provider_2.jpg',
      bio:
          'Experienced full-time maid with 8 years serving respected households in Gulberg and nearby areas. Expert in deep cleaning, laundry, and general household management.',
      services: [
        ProviderService(
          name: 'Full-Time Maid',
          pricePerDay: 900,
          description: 'Daily household cleaning and management — 8 hours.',
        ),
        ProviderService(
          name: 'Deep Cleaning',
          pricePerDay: 1400,
          description: 'Thorough one-time deep clean for entire home.',
        ),
      ],
    ),
    ServiceProvider(
      id: '3',
      name: 'Zainab K.',
      serviceType: 'Part-Time Maid',
      rating: 4.7,
      reviewCount: 89,
      experienceYears: 4,
      jobsCompleted: 89,
      pricePerDay: 600,
      location: 'Model Town',
      isVerified: true,
      imageAsset: 'assets/images/provider_3.jpg',
      bio:
          'Reliable part-time maid available in Model Town and Garden Town. Trusted by families for 4+ years for efficient and discreet household service.',
      services: [
        ProviderService(
          name: 'Part-Time Maid',
          pricePerDay: 600,
          description: 'Morning or evening shift — 4 hours of cleaning.',
        ),
        ProviderService(
          name: 'Laundry & Ironing',
          pricePerDay: 400,
          description: 'Clothes washing, drying, and ironing service.',
        ),
      ],
    ),
    ServiceProvider(
      id: '4',
      name: 'Meena B.',
      serviceType: 'Baby Nurse',
      rating: 4.9,
      reviewCount: 223,
      experienceYears: 10,
      jobsCompleted: 223,
      pricePerDay: 1800,
      location: 'Johar Town',
      isVerified: true,
      imageAsset: 'assets/images/provider_4.jpg',
      bio:
          'Highly experienced baby nurse and child caregiver with 10 years of professional service. Trained in infant care, feeding schedules, and early child development support.',
      services: [
        ProviderService(
          name: 'Baby Nurse',
          pricePerDay: 1800,
          description: 'Full-day newborn and infant care — 24-hour option available.',
        ),
        ProviderService(
          name: 'Child Care (Toddler)',
          pricePerDay: 1400,
          description: 'Day-shift care for toddlers (1–4 years).',
        ),
        ProviderService(
          name: 'Night Duty Nurse',
          pricePerDay: 2000,
          description: 'Overnight newborn care so parents can rest.',
        ),
      ],
    ),
    ServiceProvider(
      id: '5',
      name: 'Sara A.',
      serviceType: 'Daily Cook',
      rating: 4.6,
      reviewCount: 67,
      experienceYears: 3,
      jobsCompleted: 67,
      pricePerDay: 1100,
      location: 'Garden Town',
      isVerified: false,
      imageAsset: 'assets/images/provider_5.jpg',
      bio:
          'Passionate home cook with 3 years of experience in Garden Town. Specializing in desi food, baking, and quick healthy meals for small families.',
      services: [
        ProviderService(
          name: 'Daily Cook',
          pricePerDay: 1100,
          description: 'Full-day cooking service for families of 4–6.',
        ),
        ProviderService(
          name: 'Baking & Desserts',
          pricePerDay: 800,
          description: 'Cakes, biscuits, and traditional mithai for occasions.',
        ),
      ],
    ),
  ];

  // ── Recent Bookings ────────────────────────────────────────────────────────
  static const List<Booking> bookings = [
    Booking(
      id: 'b001',
      providerName: 'Anita S.',
      providerId: '1',
      providerImageAsset: 'assets/images/provider_1.jpg',
      serviceType: 'Daily Cook',
      date: 'Tomorrow',
      time: '8:00 AM',
      serviceFee: 1200,
      platformFee: 120,
      status: BookingStatus.onTheWay,
    ),
    Booking(
      id: 'b002',
      providerName: 'Fatima R.',
      providerId: '2',
      providerImageAsset: 'assets/images/provider_2.jpg',
      serviceType: 'Full-Time Maid',
      date: 'Mon, 21 Apr',
      time: '9:00 AM',
      serviceFee: 900,
      platformFee: 90,
      status: BookingStatus.completed,
    ),
    Booking(
      id: 'b003',
      providerName: 'Zainab K.',
      providerId: '3',
      providerImageAsset: 'assets/images/provider_3.jpg',
      serviceType: 'Part-Time Maid',
      date: 'Sat, 19 Apr',
      time: '10:00 AM',
      serviceFee: 600,
      platformFee: 60,
      status: BookingStatus.completed,
    ),
  ];

  // ── Current active booking (for Booking Status screen) ────────────────────
  static Booking get activeBooking => bookings[0];

  // ── Chat Messages (for Chat screen with Anita S.) ─────────────────────────
  static const List<ChatMessage> chatMessages = [
    ChatMessage(
      id: 'm1',
      text: 'Assalamu Alaikum! I will be there by 8 AM.',
      time: '10:02 AM',
      isFromMe: false,
    ),
    ChatMessage(
      id: 'm2',
      text: 'Walaikum Assalam! That works perfectly.',
      time: '10:03 AM',
      isFromMe: true,
    ),
    ChatMessage(
      id: 'm3',
      text: 'Should I bring my own utensils or will you provide them?',
      time: '10:05 AM',
      isFromMe: false,
    ),
    ChatMessage(
      id: 'm4',
      text: "I'll provide everything, don't worry.",
      time: '10:06 AM',
      isFromMe: true,
    ),
    ChatMessage(
      id: 'm5',
      text: 'JazakAllah khair! See you tomorrow.',
      time: '10:08 AM',
      isFromMe: false,
    ),
  ];

  // ── Helper: find provider by ID ────────────────────────────────────────────
  static ServiceProvider providerById(String id) {
    return providers.firstWhere(
      (p) => p.id == id,
      orElse: () => providers.first,
    );
  }
}
