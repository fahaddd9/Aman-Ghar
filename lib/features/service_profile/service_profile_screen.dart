import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../core/models/provider_model.dart';
import '../../shared/widgets/verified_badge.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/custom_filled_button.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ServiceProfileScreen — Full provider detail view
// Hero header | Stats row | About | Services with BOOK NOW
// ─────────────────────────────────────────────────────────────────────────────
class ServiceProfileScreen extends StatelessWidget {
  final String providerId;
  const ServiceProfileScreen({super.key, required this.providerId});

  static const Map<String, String> _avatarUrls = {
    '1': 'https://i.pravatar.cc/300?img=47',
    '2': 'https://i.pravatar.cc/300?img=45',
    '3': 'https://i.pravatar.cc/300?img=44',
    '4': 'https://i.pravatar.cc/300?img=43',
    '5': 'https://i.pravatar.cc/300?img=41',
  };

  static const Map<String, IconData> _serviceIcons = {
    'Daily Cook': Icons.restaurant_rounded,
    'Full-Time Maid': Icons.cleaning_services_rounded,
    'Part-Time Maid': Icons.cleaning_services_rounded,
    'Baby Nurse': Icons.child_care_rounded,
    'Driver': Icons.directions_car_rounded,
    'Gardener': Icons.yard_rounded,
    'Meal Prep (Part-Day)': Icons.lunch_dining_rounded,
    'Deep Cleaning': Icons.cleaning_services_rounded,
    'Laundry & Ironing': Icons.local_laundry_service_rounded,
    'Child Care (Toddler)': Icons.child_friendly_rounded,
    'Night Duty Nurse': Icons.bedtime_rounded,
    'Baking & Desserts': Icons.cake_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final provider = DummyData.providerById(providerId);
    final imageUrl = _avatarUrls[providerId] ?? 'https://i.pravatar.cc/300';

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,

      // ── AppBar — transparent overlay ──────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: AppShadows.card,
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: AppColors.textPrimary),
          ),
        ),
        actions: const [
          _AppBarAction(icon: Icons.share_rounded),
          _AppBarAction(icon: Icons.bookmark_border_rounded),
          SizedBox(width: AppSpacing.xs),
        ],
      ),

      // ── Body ──────────────────────────────────────────────────────────
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeroHeader(context, provider, imageUrl),

            const SizedBox(height: AppSpacing.sm),

            _buildStatsCard(provider),

            const Padding(
              padding: EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm),
              child: SectionHeader('About'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(provider.bio, style: AppTextStyles.bodyMedium),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.sm),
              child: SectionHeader('Services Provided'),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: provider.services.length,
              itemBuilder: (_, i) => _ServiceListTile(
                service: provider.services[i],
                serviceIcons: _serviceIcons,
                onBookNow: () => context.push('/booking/${provider.id}'),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader(
      BuildContext context, ServiceProvider provider, String imageUrl) {
    return Container(
      color: AppColors.primary.withValues(alpha: 0.08),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 60,
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        bottom: AppSpacing.lg,
      ),
      child: Column(
        children: [
          Hero(
            tag: 'provider-image-${provider.id}',
            child: CircleAvatar(
              radius: 52,
              backgroundColor: AppColors.primaryLight.withValues(alpha: 0.5),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 104,
                  height: 104,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.person_rounded,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            provider.name,
            style: AppTextStyles.headingMedium,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          if (provider.isVerified) const VerifiedBadge(),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_rounded,
                  size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 2),
              Flexible(
                child: Text(
                  provider.location,
                  style: AppTextStyles.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(ServiceProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: _StatItem(value: '${provider.rating}★', label: 'Rating')),
            _VerticalDivider(),
            Expanded(child: _StatItem(value: provider.experienceLabel, label: 'Experience')),
            _VerticalDivider(),
            Expanded(child: _StatItem(value: provider.jobsLabel, label: 'Jobs Done')),
          ],
        ),
      ),
    );
  }
}

class _AppBarAction extends StatelessWidget {
  final IconData icon;
  const _AppBarAction({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        shape: BoxShape.circle,
        boxShadow: AppShadows.card,
      ),
      child: IconButton(
        iconSize: 18,
        onPressed: () {},
        icon: Icon(icon, color: AppColors.textPrimary),
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: AppTextStyles.headingSmall.copyWith(color: AppColors.primary),
            overflow: TextOverflow.ellipsis),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppTextStyles.bodySmall, overflow: TextOverflow.ellipsis),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 40, width: 1, color: AppColors.divider);
  }
}

class _ServiceListTile extends StatelessWidget {
  final ProviderService service;
  final Map<String, IconData> serviceIcons;
  final VoidCallback onBookNow;

  const _ServiceListTile({
    required this.service,
    required this.serviceIcons,
    required this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    final icon =
        serviceIcons[service.name] ?? Icons.miscellaneous_services_rounded;
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        service.name,
        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(service.formattedPrice, style: AppTextStyles.bodySmall),
      trailing: SizedBox(
        width: 100,
        child: CustomFilledButton(
          label: 'BOOK NOW',
          height: 36,
          onTap: onBookNow,
        ),
      ),
    );
  }
}
