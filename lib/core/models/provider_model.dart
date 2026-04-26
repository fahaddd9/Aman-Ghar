// ─────────────────────────────────────────────────────────────────────────────
// ServiceProvider — AmanGhar provider data model
// Represents a cook/maid/nurse/driver available for hire in Lahore
// ─────────────────────────────────────────────────────────────────────────────

class ServiceProvider {
  final String id;
  final String name;
  final String serviceType;
  final double rating;
  final int reviewCount;
  final int experienceYears;
  final int jobsCompleted;
  final int pricePerDay; // in PKR
  final String location;
  final bool isVerified;
  final String imageAsset;
  final String bio;
  final List<ProviderService> services;

  const ServiceProvider({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.rating,
    required this.reviewCount,
    required this.experienceYears,
    required this.jobsCompleted,
    required this.pricePerDay,
    required this.location,
    required this.isVerified,
    required this.imageAsset,
    required this.bio,
    required this.services,
  });

  String get formattedPrice {
    final s = pricePerDay.toString();
    if (s.length <= 3) return 'PKR $s/day';
    final rem = s.length % 3;
    final buf = StringBuffer('PKR ');
    if (rem != 0) {
      buf.write(s.substring(0, rem));
      if (s.length > rem) buf.write(',');
    }
    for (int i = rem; i < s.length; i += 3) {
      buf.write(s.substring(i, i + 3));
      if (i + 3 < s.length) buf.write(',');
    }
    buf.write('/day');
    return buf.toString();
  }

  String get experienceLabel => '$experienceYears yrs';
  String get jobsLabel => '$jobsCompleted';
  String get ratingLabel => rating.toStringAsFixed(1);
}

// ─────────────────────────────────────────────────────────────────────────────
// ProviderService — An individual service offered by a provider
// ─────────────────────────────────────────────────────────────────────────────
class ProviderService {
  final String name;
  final int pricePerDay; // in PKR
  final String description;

  const ProviderService({
    required this.name,
    required this.pricePerDay,
    required this.description,
  });

  String get formattedPrice {
    final s = pricePerDay.toString();
    if (s.length <= 3) return 'PKR $s/day';
    final rem = s.length % 3;
    final buf = StringBuffer('PKR ');
    if (rem != 0) {
      buf.write(s.substring(0, rem));
      if (s.length > rem) buf.write(',');
    }
    for (int i = rem; i < s.length; i += 3) {
      buf.write(s.substring(i, i + 3));
      if (i + 3 < s.length) buf.write(',');
    }
    buf.write('/day');
    return buf.toString();
  }
}
