import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../utils/utils.dart';
import '../application/budgets_service.dart';
import '../../transactions/domain/transaction_category.dart';

class AddBudgetScreen extends ConsumerStatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  ConsumerState<AddBudgetScreen> createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends ConsumerState<AddBudgetScreen> {
  TransactionCategory _category = TransactionCategory.food;
  final _limitController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate =
      DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  bool _isSaving = false;

  @override
  void dispose() {
    _limitController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final limit = double.tryParse(_limitController.text.replaceAll(',', ''));
    if (limit == null || limit <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid budget limit')),
      );
      return;
    }

    setState(() => _isSaving = true);
    await ref.read(budgetsProvider.notifier).addBudget(
          category: _category,
          limit: limit,
          startDate: _startDate,
          endDate: _endDate,
        );
    setState(() => _isSaving = false);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingM, vertical: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.arrow_back,
                          size: 20, color: AppColors.primaryDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Add Budget', style: AppTextStyles.heading3),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SELECT CATEGORY', style: AppTextStyles.label),
                    const SizedBox(height: AppSizes.paddingM),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: TransactionCategory.values.map((cat) {
                        final isSelected = _category == cat;
                        return GestureDetector(
                          onTap: () => setState(() => _category = cat),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryDark
                                      .withValues(alpha: 0.08)
                                  : AppColors.white,
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusMedium),
                              border: isSelected
                                  ? Border.all(
                                      color: AppColors.primaryDark, width: 2)
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(cat.icon,
                                    size: 22,
                                    color: isSelected
                                        ? AppColors.primaryDark
                                        : AppColors.slateBlue),
                                const SizedBox(height: 4),
                                Text(
                                  cat.label,
                                  style: AppTextStyles.caption.copyWith(
                                    color: isSelected
                                        ? AppColors.primaryDark
                                        : AppColors.textSecondary,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSizes.paddingL),
                    Text('BUDGET LIMIT', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingM, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusCard)),
                      child: Row(
                        children: [
                          const Text('\$',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: AppColors.slateBlue,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _limitController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              style: AppTextStyles.amountMedium,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '0.00',
                                hintStyle: AppTextStyles.amountMedium
                                    .copyWith(color: AppColors.slateBlue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingL),
                    Text('TIME PERIOD', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _DateTile(
                            label: 'Start',
                            date: _startDate,
                            onTap: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate: _startDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );
                              if (d != null) setState(() => _startDate = d);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _DateTile(
                            label: 'End',
                            date: _endDate,
                            onTap: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate: _endDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );
                              if (d != null) setState(() => _endDate = d);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingXL),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: PrimaryButton(
                  label: 'Add Budget', isLoading: _isSaving, onPressed: _save),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;

  const _DateTile(
      {required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusCard)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(), style: AppTextStyles.label),
            const SizedBox(height: 4),
            Text(DateFormatter.format(date), style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }
}
