import 'package:flutter/material.dart';

enum TransactionCategory {
  food,
  travel,
  salary,
  shop,
  home,
  other,
  transport,
  entertainment,
  health,
  utilities,
  investment,
  groceries,
}

extension TransactionCategoryX on TransactionCategory {
  String get label => switch (this) {
        TransactionCategory.food => 'Food',
        TransactionCategory.travel => 'Travel',
        TransactionCategory.salary => 'Salary',
        TransactionCategory.shop => 'Shop',
        TransactionCategory.home => 'Home',
        TransactionCategory.other => 'Other',
        TransactionCategory.transport => 'Transport',
        TransactionCategory.entertainment => 'Entertainment',
        TransactionCategory.health => 'Health',
        TransactionCategory.utilities => 'Utilities',
        TransactionCategory.investment => 'Investment',
        TransactionCategory.groceries => 'Groceries',
      };

  IconData get icon => switch (this) {
        TransactionCategory.food => Icons.restaurant,
        TransactionCategory.travel => Icons.flight,
        TransactionCategory.salary => Icons.attach_money,
        TransactionCategory.shop => Icons.shopping_bag,
        TransactionCategory.home => Icons.home,
        TransactionCategory.other => Icons.more_horiz,
        TransactionCategory.transport => Icons.directions_car,
        TransactionCategory.entertainment => Icons.movie,
        TransactionCategory.health => Icons.favorite,
        TransactionCategory.utilities => Icons.bolt,
        TransactionCategory.investment => Icons.show_chart,
        TransactionCategory.groceries => Icons.shopping_cart,
      };
}
