import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../utils/utils.dart';
import '../application/transactions_service.dart';
import '../domain/transaction_category.dart';
import '../domain/transaction_type.dart';
import '../../recurring/domain/recurrence_interval.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  TransactionType _type = TransactionType.expense;
  TransactionCategory _category = TransactionCategory.food;
  double _amount = 0.0;
  DateTime _date = DateTime.now();
  // String _note = '';
  bool _isRecurring = false;
  RecurrenceInterval _interval = RecurrenceInterval.monthly;
  bool _isSaving = false;

  final _amountController = TextEditingController(text: '0.00');
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryDark,
            onPrimary: AppColors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    final amount =
        double.tryParse(_amountController.text.replaceAll(',', '')) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    setState(() => _isSaving = true);

    await ref.read(transactionsProvider.notifier).addTransaction(
          amount: amount,
          type: _type,
          category: _category,
          date: _date,
          note: _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
          isRecurring: _isRecurring,
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
            // Header
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back,
                          size: 20, color: AppColors.primaryDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('New Transaction', style: AppTextStyles.heading3),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expense / Income Toggle
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusLarge),
                      ),
                      child: Row(
                        children: TransactionType.values.map((t) {
                          final isSelected = _type == t;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _type = t),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryDark
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.radiusMedium),
                                ),
                                child: Center(
                                  child: Text(
                                    t.label,
                                    style: TextStyle(
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Amount
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusCard),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('AMOUNT', style: AppTextStyles.label),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryDark,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('USD',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('\$',
                                  style: AppTextStyles.amountLarge
                                      .copyWith(color: AppColors.slateBlue)),
                              const SizedBox(width: 4),
                              Expanded(
                                child: TextField(
                                  controller: _amountController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  style: AppTextStyles.amountLarge,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '0.00',
                                    hintStyle: TextStyle(
                                        color: AppColors.slateBlue,
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  onChanged: (v) =>
                                      _amount = double.tryParse(v) ?? 0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Category
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusCard),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CATEGORY', style: AppTextStyles.label),
                          const SizedBox(height: AppSizes.paddingM),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            childAspectRatio: 1.1,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children:
                                TransactionCategory.values.take(6).map((cat) {
                              final isSelected = _category == cat;
                              return GestureDetector(
                                onTap: () => setState(() => _category = cat),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.white
                                        : AppColors.background,
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radiusMedium),
                                    border: isSelected
                                        ? Border.all(
                                            color: AppColors.primaryDark,
                                            width: 2)
                                        : null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        cat.icon,
                                        size: 24,
                                        color: isSelected
                                            ? AppColors.primaryDark
                                            : AppColors.textSecondary,
                                      ),
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
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Date
                    GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.paddingM),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusCard),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined,
                                size: 20, color: AppColors.primaryDark),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('DATE', style: AppTextStyles.label),
                                const SizedBox(height: 2),
                                Text(DateFormatter.format(_date),
                                    style: AppTextStyles.bodyMedium),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Notes
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusCard),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.notes,
                              size: 20, color: AppColors.primaryDark),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('NOTES', style: AppTextStyles.label),
                                TextField(
                                  controller: _noteController,
                                  style: AppTextStyles.body,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'What was this for?',
                                    hintStyle: AppTextStyles.body
                                        .copyWith(color: AppColors.slateBlue),
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Recurring Toggle
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusCard),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.autorenew,
                                  size: 22, color: AppColors.primary),
                              const SizedBox(width: 10),
                              Text('Recurring Transaction',
                                  style: AppTextStyles.bodyMedium),
                              const Spacer(),
                              Switch(
                                value: _isRecurring,
                                onChanged: (v) =>
                                    setState(() => _isRecurring = v),
                                activeThumbColor: AppColors.primaryDark,
                              ),
                            ],
                          ),
                          if (_isRecurring) ...[
                            const SizedBox(height: 12),
                            Row(
                              children:
                                  RecurrenceInterval.values.map((interval) {
                                final isSelected = _interval == interval;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => _interval = interval),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.primaryDark
                                            : AppColors.background,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          interval.label,
                                          style: TextStyle(
                                            color: isSelected
                                                ? AppColors.white
                                                : AppColors.textSecondary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingXL),
                  ],
                ),
              ),
            ),

            // Save Button
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: PrimaryButton(
                label: 'Save Transaction',
                isLoading: _isSaving,
                onPressed: _save,
                icon: const Icon(Icons.check_circle_outline,
                    color: AppColors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
