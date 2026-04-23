import 'package:flutter/material.dart';
import '../constants/constants.dart';

Future<String?> showAmountNumpad(
  BuildContext context, {
  String initial = '0',
}) async {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _AmountNumpad(initial: initial),
  );
}

class _AmountNumpad extends StatefulWidget {
  final String initial;
  const _AmountNumpad({required this.initial});

  @override
  State<_AmountNumpad> createState() => _AmountNumpadState();
}

class _AmountNumpadState extends State<_AmountNumpad> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initial == '0' ? '0' : widget.initial;
  }

  void _onKey(String key) {
    setState(() {
      if (key == '<') {
        if (_value.length <= 1) {
          _value = '0';
        } else {
          _value = _value.substring(0, _value.length - 1);
        }
      } else if (key == '.') {
        if (!_value.contains('.')) _value += '.';
      } else {
        if (_value == '0') {
          _value = key;
        } else {
          final parts = _value.split('.');
          if (parts.length == 2 && parts[1].length >= 2) return;
          _value += key;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusXL)),
      ),
      padding: const EdgeInsets.fromLTRB(AppSizes.paddingM, AppSizes.paddingM, AppSizes.paddingM, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppSizes.paddingM),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.radiusCard),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('\$', style: AppTextStyles.amountLarge.copyWith(color: AppColors.slateBlue)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _value,
                    style: AppTextStyles.amountLarge,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.paddingM),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 2.2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              '1', '2', '3',
              '4', '5', '6',
              '7', '8', '9',
              '.', '0', '<',
            ].map((k) => _NumKey(label: k, onTap: () => _onKey(k))).toList(),
          ),
          const SizedBox(height: AppSizes.paddingM),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, _value),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusLarge)),
              ),
              child: const Text('Continue', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumKey extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NumKey({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        child: Center(
          child: label == '<'
              ? const Icon(Icons.backspace_outlined, size: 20, color: AppColors.textSecondary)
              : Text(
                  label,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
                ),
        ),
      ),
    );
  }
}
