// ─────────────────────────────────────────────────────────────────────────────
// Booking — AmanGhar booking data model
// Represents a service booking made by a Hirer
// ─────────────────────────────────────────────────────────────────────────────

enum BookingStatus {
  booked,
  confirmed,
  onTheWay,
  arrived,
  completed,
  cancelled,
}

extension BookingStatusLabel on BookingStatus {
  String get label {
    switch (this) {
      case BookingStatus.booked:
        return 'Booked';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.onTheWay:
        return 'On the Way';
      case BookingStatus.arrived:
        return 'Arrived';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isDone => index > 0;
}

class Booking {
  final String id;
  final String providerName;
  final String providerId;
  final String providerImageAsset;
  final String serviceType;
  final String date;
  final String time;
  final int serviceFee; // PKR
  final int platformFee; // PKR
  final BookingStatus status;

  const Booking({
    required this.id,
    required this.providerName,
    required this.providerId,
    required this.providerImageAsset,
    required this.serviceType,
    required this.date,
    required this.time,
    required this.serviceFee,
    required this.platformFee,
    required this.status,
  });

  int get totalFee => serviceFee + platformFee;

  String get formattedServiceFee => _fmt(serviceFee);
  String get formattedPlatformFee => _fmt(platformFee);
  String get formattedTotal => _fmt(totalFee);

  static String _fmt(int amount) {
    final s = amount.toString();
    if (s.length <= 3) return 'PKR $s';
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
    return buf.toString();
  }
}
