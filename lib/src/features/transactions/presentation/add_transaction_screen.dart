import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants/constants.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../utils/utils.dart';
import '../application/transactions_service.dart';
import '../domain/transaction_category.dart';
import '../domain/transaction_type.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  int _tabIndex = 0; // 0=Manual, 1=Capture, 2=Upload Data

  // Manual Tab State
  final TransactionType _type = TransactionType.expense;
  TransactionCategory _category = TransactionCategory.food;
  String _amount = '0';
  DateTime _date = DateTime.now();
  final _noteController = TextEditingController();

  // Capture/Upload State
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  bool _isSaving = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(source: source);
      if (picked != null) {
        setState(() {
          _imageFile = File(picked.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _saveManual() async {
    final amt = double.tryParse(_amount);
    if (amt == null || amt <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid amount')));
      return;
    }

    setState(() => _isSaving = true);
    await ref.read(transactionsProvider.notifier).addTransaction(
          amount: amt,
          type: _type,
          category: _category,
          date: _date,
          note: _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
          isRecurring: false,
        );
    setState(() => _isSaving = false);
    if (mounted) context.pop();
  }

  Future<void> _saveCaptured() async {
    if (_imageFile == null) return;

    setState(() => _isSaving = true);
    // Dummy amount and category for OCR/captured data since OCR isn't implemented
    await ref.read(transactionsProvider.notifier).addTransaction(
          amount: 45.99,
          type: TransactionType.expense,
          category: TransactionCategory.other,
          date: DateTime.now(),
          note: 'Captured receipt',
          isRecurring: false,
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
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.arrow_back,
                          size: 20, color: AppColors.primaryDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Add Transaction', style: AppTextStyles.heading3),
                ],
              ),
            ),

            // Tabs
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                ),
                child: Row(
                  children: ['Manual', 'Capture', 'Upload Data']
                      .asMap()
                      .entries
                      .map((e) {
                    final isSelected = _tabIndex == e.key;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _tabIndex = e.key;
                            _imageFile =
                                null; // Reset image when switching tabs
                          });
                          if (_tabIndex == 1) _pickImage(ImageSource.camera);
                          if (_tabIndex == 2) _pickImage(ImageSource.gallery);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.white
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusMedium),
                            boxShadow: isSelected
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
                              e.value,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.primaryDark
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
              ),
            ),

            Expanded(
              child: _tabIndex == 0 ? _buildManualTab() : _buildCaptureTab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualTab() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text('AMOUNT', style: AppTextStyles.label),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () async {
                          final val =
                              await showAmountNumpad(context, initial: _amount);
                          if (val != null) setState(() => _amount = val);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$ $_amount',
                              style: AppTextStyles.amountLarge.copyWith(
                                  fontSize: 48, color: AppColors.primaryDark),
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
                              ? AppColors.primaryDark.withValues(alpha: 0.08)
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
                const SizedBox(height: AppSizes.paddingL),
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
                Text('NOTES', style: AppTextStyles.label),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  ),
                  child: TextField(
                    controller: _noteController,
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
              onPressed: _saveManual,
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
    );
  }

  Widget _buildCaptureTab() {
    if (_imageFile == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                _tabIndex == 1
                    ? Icons.camera_alt_outlined
                    : Icons.image_outlined,
                size: 64,
                color: AppColors.slateBlue),
            const SizedBox(height: 16),
            Text(
              _tabIndex == 1 ? 'Tap to open camera' : 'Tap to open gallery',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _pickImage(
                  _tabIndex == 1 ? ImageSource.camera : ImageSource.gallery),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge)),
              ),
              child: Text(_tabIndex == 1 ? 'Open Camera' : 'Open Gallery',
                  style: const TextStyle(color: AppColors.white)),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Result of captured Data', style: AppTextStyles.heading3),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                      image: DecorationImage(
                        image: FileImage(_imageFile!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSizes.paddingL),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveCaptured,
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
    );
  }
}
