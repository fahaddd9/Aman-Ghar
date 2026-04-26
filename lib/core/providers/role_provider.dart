import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─────────────────────────────────────────────────────────────────────────────
// UserRole — Two strict roles in AmanGhar. No switching, no overlap.
// ─────────────────────────────────────────────────────────────────────────────
enum UserRole {
  hirer,    // Family hiring domestic help
  provider, // Cook/maid offering services
}

extension UserRoleLabel on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.hirer:
        return 'Hirer';
      case UserRole.provider:
        return 'Provider';
    }
  }

  String get roleKey {
    switch (this) {
      case UserRole.hirer:
        return 'hirer';
      case UserRole.provider:
        return 'provider';
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// roleProvider — Riverpod StateProvider holding current user role.
// Nullable: null means no role selected yet (before onboarding).
// ─────────────────────────────────────────────────────────────────────────────
final roleProvider = StateProvider<UserRole?>((ref) => null);
