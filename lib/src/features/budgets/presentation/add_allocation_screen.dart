import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../utils/utils.dart';
import '../../transactions/application/transactions_service.dart';
import '../../transactions/domain/transaction_category.dart';
import '../../transactions/domain/transaction_type.dart';

class AddAllocationScreen extends ConsumerStatefulWidget {
  const AddAllocationScreen({super.key});

  @override
  ConsumerState<AddAllocationScreen> createState() =>
      _AddAllocationScreenState();
}

class _AddAllocationScreenState extends ConsumerState<AddAllocationScreen> {
  TransactionType _type = TransactionType.expense;
  TransactionCategory _category = TransactionCategory.food;
  String _amount = '0';
  final _notesController = TextEditingController();
  String _timeframe = 'Monthly'; // Daily, Weekly, Monthly
  DateTime _date = DateTime.now();
  bool _isRecurring = false;
  bool _thresholdAlert = true;
  bool _isSaving = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amt = double.tryParse(_amount);
    if (amt == null || amt <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    setState(() => _isSaving = true);
    await ref.read(transactionsProvider.notifier).addTransaction(
          amount: amt,
          type: _type,
          category: _category,
          date: _date,
          note: _notesController.text.isEmpty ? null : _notesController.text,
          isRecurring: _isRecurring,
        );
    setState(() => _isSaving = false);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back,
                          size: 20, color: AppColors.primaryDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('New Budget/Allocation', style: AppTextStyles.heading3),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expense / Income Toggle
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusLarge),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(
                                  () => _type = TransactionType.expense),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _type == TransactionType.expense
                                      ? AppColors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.radiusMedium),
                                  boxShadow: _type == TransactionType.expense
                                      ? [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.05),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2))
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    'Expense',
                                    style: TextStyle(
                                      color: _type == TransactionType.expense
                                          ? AppColors.primaryDark
                                          : AppColors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(
                                  () => _type = TransactionType.income),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: _type == TransactionType.income
                                      ? AppColors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.radiusMedium),
                                  boxShadow: _type == TransactionType.income
                                      ? [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.05),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2))
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    'Income',
                                    style: TextStyle(
                                      color: _type == TransactionType.income
                                          ? AppColors.primaryDark
                                          : AppColors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingXL),

                    // Amount
                    Center(
                      child: Column(
                        children: [
                          Text('AMOUNT', style: AppTextStyles.label),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () async {
                              final val = await showAmountNumpad(context,
                                  initial: _amount);
                              if (val != null) {
                                setState(() => _amount = val);
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '\$ $_amount',
                                  style: AppTextStyles.amountLarge.copyWith(
                                      fontSize: 48,
                                      color: AppColors.primaryDark),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryDark
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text('USD',
                                      style: TextStyle(
                                          color: AppColors.primaryDark,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingXL),

                    Text('CATEGORY', style: AppTextStyles.label),
                    const SizedBox(height: 12),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: TransactionCategory.values.take(6).map((cat) {
                        final isSelected = _category == cat;
                        return GestureDetector(
                          onTap: () => setState(() => _category = cat),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryDark
                                      .withValues(alpha: 0.08)
                                  : AppColors.background,
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusMedium),
                              border: isSelected
                                  ? Border.all(
                                      color: AppColors.primaryDark, width: 1.5)
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(cat.icon,
                                    size: 24,
                                    color: isSelected
                                        ? AppColors.primaryDark
                                        : AppColors.slateBlue),
                                const SizedBox(height: 6),
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
                    const SizedBox(height: AppSizes.paddingXL),

                    // Timeframe
                    Row(
                      children: ['Daily', 'Weekly', 'Monthly'].map((t) {
                        final isSelected = _timeframe == t;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(() => _timeframe = t),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryDark
                                    : AppColors.background,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                t,
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
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSizes.paddingL),

                    // Date picker row
                    GestureDetector(
                      onTap: () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (d != null) setState(() => _date = d);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMedium),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined,
                                color: AppColors.slateBlue, size: 20),
                            const SizedBox(width: 12),
                            Text(DateFormatter.format(_date),
                                style: AppTextStyles.bodyMedium),
                            const Spacer(),
                            const Icon(Icons.chevron_right,
                                color: AppColors.slateBlue, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingL),

                    // Toggles
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.flash_on_outlined,
                              color: AppColors.slateBlue, size: 18),
                        ),
                        const SizedBox(width: 12),
                        const Text('Recurring Transaction',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary)),
                        const Spacer(),
                        Switch(
                          value: _isRecurring,
                          onChanged: (v) => setState(() => _isRecurring = v),
                          activeThumbColor: AppColors.primaryDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.notifications_outlined,
                              color: AppColors.slateBlue, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Notify at 80%',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary)),
                            Text('SPENDING LIMIT',
                                style: AppTextStyles.caption
                                    .copyWith(fontSize: 10)),
                          ],
                        ),
                        const Spacer(),
                        Switch(
                          value: _thresholdAlert,
                          onChanged: (v) => setState(() => _thresholdAlert = v),
                          activeThumbColor: AppColors.primaryDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingL),

                    Text('NOTES', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusMedium),
                      ),
                      child: TextField(
                        controller: _notesController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What was this for?',
                          hintStyle: AppTextStyles.body
                              .copyWith(color: AppColors.slateBlue),
                        ),
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingL),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusXL)),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: AppColors.white, strokeWidth: 2))
                      : const Text('Save Up!',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
