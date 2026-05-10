// Purpose: Search Results screen with horizontal category filters.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 4

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/data/dummy_data.dart';
import '../../shared/widgets/provider_list_tile.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;
  const SearchResultsScreen({super.key, required this.query});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _activeCategory = AppStrings.filterAll;
  
  final List<String> _categories = [
    AppStrings.filterAll,
    AppStrings.dailyCook,
    AppStrings.fullTimeMaid,
    AppStrings.partTimeMaid,
    AppStrings.babyNurse,
    AppStrings.driver,
  ];

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.query;
    // Basic category inference
    final queryLower = widget.query.toLowerCase();
    if (queryLower.contains('cook')) {
      _activeCategory = AppStrings.dailyCook;
    } else if (queryLower.contains('maid')) {
      _activeCategory = AppStrings.fullTimeMaid;
    } else if (queryLower.contains('nurse') || queryLower.contains('baby')) {
      _activeCategory = AppStrings.babyNurse;
    } else if (queryLower.contains('driver')) {
      _activeCategory = AppStrings.driver;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final queryText = _searchController.text.toLowerCase();
    
    // Filter dummy data based on active category and search query
    final providers = DummyData.providers.where((p) {
      final matchesCategory = _activeCategory == AppStrings.filterAll || p.serviceType == _activeCategory;
      final matchesSearch = queryText.isEmpty || 
                            p.name.toLowerCase().contains(queryText) || 
                            p.serviceType.toLowerCase().contains(queryText);
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.searchResultsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Search Bar ───────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(AppSpacing.md.w, AppSpacing.sm.h, AppSpacing.md.w, AppSpacing.md.h),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                style: AppTextStyles.bodyLarge,
                onChanged: (value) => setState(() {}),
                onSubmitted: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: AppStrings.searchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),

            // ── Category Chips ───────────────────────────────────────
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => SizedBox(width: AppSpacing.sm.w),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat == _activeCategory;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _activeCategory = cat);
                      }
                    },
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    labelStyle: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : AppColors.divider,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                    ),
                  );
                },
              ),
            ),
            
            SizedBox(height: AppSpacing.sm.h),
            
            // ── Results List ─────────────────────────────────────────
            Expanded(
              child: providers.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 64.sp, color: AppColors.textHint.withValues(alpha: 0.5)),
                          SizedBox(height: AppSpacing.md.h),
                          Text(
                            AppStrings.noProvidersFound,
                            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(AppSpacing.md.w),
                      itemCount: providers.length,
                      itemBuilder: (context, index) {
                        final provider = providers[index];
                        // Staggered slide animation
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 300 + (index * 60)),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, 20 * (1 - value)),
                                child: child,
                              ),
                            );
                          },
                          child: ProviderListTile(
                            provider: provider,
                            onSelect: () => context.push('/provider/${provider.id}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
