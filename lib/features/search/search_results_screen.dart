import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/provider_list_tile.dart';
import '../../shared/widgets/bottom_nav_bar.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SearchResultsScreen — Provider listing with filter chips and staggered list
// PDF Page 9 widget tree
// ─────────────────────────────────────────────────────────────────────────────
class SearchResultsScreen extends StatefulWidget {
  final String query;
  const SearchResultsScreen({super.key, this.query = ''});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  static const bool enableAnimations = true;

  String _selectedFilter = AppConstants.searchFilterAll;

  static const List<String> _filters = [
    AppConstants.searchFilterAll,
    AppConstants.serviceDailyCook,
    AppConstants.serviceFullTimeMaid,
    AppConstants.servicePartTimeMaid,
    AppConstants.serviceBabyNurse,
  ];

  @override
  Widget build(BuildContext context) {
    // Filter the providers list based on selected category
    final providers = DummyData.providers.where((p) {
      if (_selectedFilter == AppConstants.searchFilterAll) return true;
      return p.serviceType == _selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          AppConstants.searchResultsTitle,
          style: AppTextStyles.headingSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Filter',
          ),
        ],
      ),
      bottomNavigationBar: const AmanGharBottomNav(currentIndex: 0),
      body: Column(
        children: [
          // ── Filter chips row ─────────────────────────────────────────
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            child: Row(
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Transform.scale(
                    scale: isSelected ? 1.04 : 1.0,
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (_) =>
                          setState(() => _selectedFilter = filter),
                      backgroundColor: AppColors.surface,
                      selectedColor: AppColors.primary,
                      labelStyle: AppTextStyles.bodyMedium.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.divider,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppRadius.chip),
                      ),
                      showCheckmark: false,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // ── Provider list with staggered FadeIn ──────────────────────
          Expanded(
            child: providers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded, size: 64, color: AppColors.textHint.withValues(alpha: 0.5)),
                        const SizedBox(height: 16),
                        Text(
                          'No providers found for this category',
                          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: providers.length,
                    itemBuilder: (_, i) {
                      final provider = providers[i];
                      return TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(
                          milliseconds: enableAnimations ? 400 + (i * 60) : 0,
                        ),
                        curve: Curves.easeOut,
                        builder: (_, value, child) => Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: ProviderListTile(
                            provider: provider,
                            onSelect: () =>
                                context.push('/provider/${provider.id}'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
