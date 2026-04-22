// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TransactionsTableTable extends TransactionsTable
    with TableInfo<$TransactionsTableTable, TransactionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _typeIndexMeta =
      const VerificationMeta('typeIndex');
  @override
  late final GeneratedColumn<int> typeIndex = GeneratedColumn<int>(
      'type_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _categoryIndexMeta =
      const VerificationMeta('categoryIndex');
  @override
  late final GeneratedColumn<int> categoryIndex = GeneratedColumn<int>(
      'category_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isRecurringMeta =
      const VerificationMeta('isRecurring');
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
      'is_recurring', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_recurring" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _recurringIdMeta =
      const VerificationMeta('recurringId');
  @override
  late final GeneratedColumn<String> recurringId = GeneratedColumn<String>(
      'recurring_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        amount,
        typeIndex,
        categoryIndex,
        date,
        note,
        isRecurring,
        recurringId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type_index')) {
      context.handle(_typeIndexMeta,
          typeIndex.isAcceptableOrUnknown(data['type_index']!, _typeIndexMeta));
    } else if (isInserting) {
      context.missing(_typeIndexMeta);
    }
    if (data.containsKey('category_index')) {
      context.handle(
          _categoryIndexMeta,
          categoryIndex.isAcceptableOrUnknown(
              data['category_index']!, _categoryIndexMeta));
    } else if (isInserting) {
      context.missing(_categoryIndexMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
          _isRecurringMeta,
          isRecurring.isAcceptableOrUnknown(
              data['is_recurring']!, _isRecurringMeta));
    }
    if (data.containsKey('recurring_id')) {
      context.handle(
          _recurringIdMeta,
          recurringId.isAcceptableOrUnknown(
              data['recurring_id']!, _recurringIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      typeIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type_index'])!,
      categoryIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_index'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isRecurring: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_recurring'])!,
      recurringId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recurring_id']),
    );
  }

  @override
  $TransactionsTableTable createAlias(String alias) {
    return $TransactionsTableTable(attachedDatabase, alias);
  }
}

class TransactionsTableData extends DataClass
    implements Insertable<TransactionsTableData> {
  final String id;
  final double amount;
  final int typeIndex;
  final int categoryIndex;
  final DateTime date;
  final String? note;
  final bool isRecurring;
  final String? recurringId;
  const TransactionsTableData(
      {required this.id,
      required this.amount,
      required this.typeIndex,
      required this.categoryIndex,
      required this.date,
      this.note,
      required this.isRecurring,
      this.recurringId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<double>(amount);
    map['type_index'] = Variable<int>(typeIndex);
    map['category_index'] = Variable<int>(categoryIndex);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_recurring'] = Variable<bool>(isRecurring);
    if (!nullToAbsent || recurringId != null) {
      map['recurring_id'] = Variable<String>(recurringId);
    }
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      amount: Value(amount),
      typeIndex: Value(typeIndex),
      categoryIndex: Value(categoryIndex),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isRecurring: Value(isRecurring),
      recurringId: recurringId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurringId),
    );
  }

  factory TransactionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionsTableData(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      typeIndex: serializer.fromJson<int>(json['typeIndex']),
      categoryIndex: serializer.fromJson<int>(json['categoryIndex']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
      recurringId: serializer.fromJson<String?>(json['recurringId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<double>(amount),
      'typeIndex': serializer.toJson<int>(typeIndex),
      'categoryIndex': serializer.toJson<int>(categoryIndex),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
      'isRecurring': serializer.toJson<bool>(isRecurring),
      'recurringId': serializer.toJson<String?>(recurringId),
    };
  }

  TransactionsTableData copyWith(
          {String? id,
          double? amount,
          int? typeIndex,
          int? categoryIndex,
          DateTime? date,
          Value<String?> note = const Value.absent(),
          bool? isRecurring,
          Value<String?> recurringId = const Value.absent()}) =>
      TransactionsTableData(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        typeIndex: typeIndex ?? this.typeIndex,
        categoryIndex: categoryIndex ?? this.categoryIndex,
        date: date ?? this.date,
        note: note.present ? note.value : this.note,
        isRecurring: isRecurring ?? this.isRecurring,
        recurringId: recurringId.present ? recurringId.value : this.recurringId,
      );
  TransactionsTableData copyWithCompanion(TransactionsTableCompanion data) {
    return TransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      typeIndex: data.typeIndex.present ? data.typeIndex.value : this.typeIndex,
      categoryIndex: data.categoryIndex.present
          ? data.categoryIndex.value
          : this.categoryIndex,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      isRecurring:
          data.isRecurring.present ? data.isRecurring.value : this.isRecurring,
      recurringId:
          data.recurringId.present ? data.recurringId.value : this.recurringId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableData(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('typeIndex: $typeIndex, ')
          ..write('categoryIndex: $categoryIndex, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('recurringId: $recurringId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, typeIndex, categoryIndex, date,
      note, isRecurring, recurringId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionsTableData &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.typeIndex == this.typeIndex &&
          other.categoryIndex == this.categoryIndex &&
          other.date == this.date &&
          other.note == this.note &&
          other.isRecurring == this.isRecurring &&
          other.recurringId == this.recurringId);
}

class TransactionsTableCompanion
    extends UpdateCompanion<TransactionsTableData> {
  final Value<String> id;
  final Value<double> amount;
  final Value<int> typeIndex;
  final Value<int> categoryIndex;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<bool> isRecurring;
  final Value<String?> recurringId;
  final Value<int> rowid;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.typeIndex = const Value.absent(),
    this.categoryIndex = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.recurringId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    required String id,
    required double amount,
    required int typeIndex,
    required int categoryIndex,
    required DateTime date,
    this.note = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.recurringId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        amount = Value(amount),
        typeIndex = Value(typeIndex),
        categoryIndex = Value(categoryIndex),
        date = Value(date);
  static Insertable<TransactionsTableData> custom({
    Expression<String>? id,
    Expression<double>? amount,
    Expression<int>? typeIndex,
    Expression<int>? categoryIndex,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<bool>? isRecurring,
    Expression<String>? recurringId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (typeIndex != null) 'type_index': typeIndex,
      if (categoryIndex != null) 'category_index': categoryIndex,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (recurringId != null) 'recurring_id': recurringId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsTableCompanion copyWith(
      {Value<String>? id,
      Value<double>? amount,
      Value<int>? typeIndex,
      Value<int>? categoryIndex,
      Value<DateTime>? date,
      Value<String?>? note,
      Value<bool>? isRecurring,
      Value<String?>? recurringId,
      Value<int>? rowid}) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      typeIndex: typeIndex ?? this.typeIndex,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      date: date ?? this.date,
      note: note ?? this.note,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringId: recurringId ?? this.recurringId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (typeIndex.present) {
      map['type_index'] = Variable<int>(typeIndex.value);
    }
    if (categoryIndex.present) {
      map['category_index'] = Variable<int>(categoryIndex.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (recurringId.present) {
      map['recurring_id'] = Variable<String>(recurringId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('typeIndex: $typeIndex, ')
          ..write('categoryIndex: $categoryIndex, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('recurringId: $recurringId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTableTable extends BudgetsTable
    with TableInfo<$BudgetsTableTable, BudgetsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIndexMeta =
      const VerificationMeta('categoryIndex');
  @override
  late final GeneratedColumn<int> categoryIndex = GeneratedColumn<int>(
      'category_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _budgetLimitMeta =
      const VerificationMeta('budgetLimit');
  @override
  late final GeneratedColumn<double> budgetLimit = GeneratedColumn<double>(
      'budget_limit', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryIndex, budgetLimit, startDate, endDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_index')) {
      context.handle(
          _categoryIndexMeta,
          categoryIndex.isAcceptableOrUnknown(
              data['category_index']!, _categoryIndexMeta));
    } else if (isInserting) {
      context.missing(_categoryIndexMeta);
    }
    if (data.containsKey('budget_limit')) {
      context.handle(
          _budgetLimitMeta,
          budgetLimit.isAcceptableOrUnknown(
              data['budget_limit']!, _budgetLimitMeta));
    } else if (isInserting) {
      context.missing(_budgetLimitMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      categoryIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_index'])!,
      budgetLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}budget_limit'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date'])!,
    );
  }

  @override
  $BudgetsTableTable createAlias(String alias) {
    return $BudgetsTableTable(attachedDatabase, alias);
  }
}

class BudgetsTableData extends DataClass
    implements Insertable<BudgetsTableData> {
  final String id;
  final int categoryIndex;
  final double budgetLimit;
  final DateTime startDate;
  final DateTime endDate;
  const BudgetsTableData(
      {required this.id,
      required this.categoryIndex,
      required this.budgetLimit,
      required this.startDate,
      required this.endDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_index'] = Variable<int>(categoryIndex);
    map['budget_limit'] = Variable<double>(budgetLimit);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    return map;
  }

  BudgetsTableCompanion toCompanion(bool nullToAbsent) {
    return BudgetsTableCompanion(
      id: Value(id),
      categoryIndex: Value(categoryIndex),
      budgetLimit: Value(budgetLimit),
      startDate: Value(startDate),
      endDate: Value(endDate),
    );
  }

  factory BudgetsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetsTableData(
      id: serializer.fromJson<String>(json['id']),
      categoryIndex: serializer.fromJson<int>(json['categoryIndex']),
      budgetLimit: serializer.fromJson<double>(json['budgetLimit']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryIndex': serializer.toJson<int>(categoryIndex),
      'budgetLimit': serializer.toJson<double>(budgetLimit),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
    };
  }

  BudgetsTableData copyWith(
          {String? id,
          int? categoryIndex,
          double? budgetLimit,
          DateTime? startDate,
          DateTime? endDate}) =>
      BudgetsTableData(
        id: id ?? this.id,
        categoryIndex: categoryIndex ?? this.categoryIndex,
        budgetLimit: budgetLimit ?? this.budgetLimit,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
  BudgetsTableData copyWithCompanion(BudgetsTableCompanion data) {
    return BudgetsTableData(
      id: data.id.present ? data.id.value : this.id,
      categoryIndex: data.categoryIndex.present
          ? data.categoryIndex.value
          : this.categoryIndex,
      budgetLimit:
          data.budgetLimit.present ? data.budgetLimit.value : this.budgetLimit,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsTableData(')
          ..write('id: $id, ')
          ..write('categoryIndex: $categoryIndex, ')
          ..write('budgetLimit: $budgetLimit, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, categoryIndex, budgetLimit, startDate, endDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetsTableData &&
          other.id == this.id &&
          other.categoryIndex == this.categoryIndex &&
          other.budgetLimit == this.budgetLimit &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class BudgetsTableCompanion extends UpdateCompanion<BudgetsTableData> {
  final Value<String> id;
  final Value<int> categoryIndex;
  final Value<double> budgetLimit;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<int> rowid;
  const BudgetsTableCompanion({
    this.id = const Value.absent(),
    this.categoryIndex = const Value.absent(),
    this.budgetLimit = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetsTableCompanion.insert({
    required String id,
    required int categoryIndex,
    required double budgetLimit,
    required DateTime startDate,
    required DateTime endDate,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        categoryIndex = Value(categoryIndex),
        budgetLimit = Value(budgetLimit),
        startDate = Value(startDate),
        endDate = Value(endDate);
  static Insertable<BudgetsTableData> custom({
    Expression<String>? id,
    Expression<int>? categoryIndex,
    Expression<double>? budgetLimit,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryIndex != null) 'category_index': categoryIndex,
      if (budgetLimit != null) 'budget_limit': budgetLimit,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetsTableCompanion copyWith(
      {Value<String>? id,
      Value<int>? categoryIndex,
      Value<double>? budgetLimit,
      Value<DateTime>? startDate,
      Value<DateTime>? endDate,
      Value<int>? rowid}) {
    return BudgetsTableCompanion(
      id: id ?? this.id,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      budgetLimit: budgetLimit ?? this.budgetLimit,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryIndex.present) {
      map['category_index'] = Variable<int>(categoryIndex.value);
    }
    if (budgetLimit.present) {
      map['budget_limit'] = Variable<double>(budgetLimit.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryIndex: $categoryIndex, ')
          ..write('budgetLimit: $budgetLimit, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurringTransactionsTableTable extends RecurringTransactionsTable
    with
        TableInfo<$RecurringTransactionsTableTable,
            RecurringTransactionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringTransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _typeIndexMeta =
      const VerificationMeta('typeIndex');
  @override
  late final GeneratedColumn<int> typeIndex = GeneratedColumn<int>(
      'type_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _categoryIndexMeta =
      const VerificationMeta('categoryIndex');
  @override
  late final GeneratedColumn<int> categoryIndex = GeneratedColumn<int>(
      'category_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _intervalIndexMeta =
      const VerificationMeta('intervalIndex');
  @override
  late final GeneratedColumn<int> intervalIndex = GeneratedColumn<int>(
      'interval_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastPostedMeta =
      const VerificationMeta('lastPosted');
  @override
  late final GeneratedColumn<DateTime> lastPosted = GeneratedColumn<DateTime>(
      'last_posted', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        amount,
        typeIndex,
        categoryIndex,
        intervalIndex,
        startDate,
        lastPosted,
        note,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_transactions';
  @override
  VerificationContext validateIntegrity(
      Insertable<RecurringTransactionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type_index')) {
      context.handle(_typeIndexMeta,
          typeIndex.isAcceptableOrUnknown(data['type_index']!, _typeIndexMeta));
    } else if (isInserting) {
      context.missing(_typeIndexMeta);
    }
    if (data.containsKey('category_index')) {
      context.handle(
          _categoryIndexMeta,
          categoryIndex.isAcceptableOrUnknown(
              data['category_index']!, _categoryIndexMeta));
    } else if (isInserting) {
      context.missing(_categoryIndexMeta);
    }
    if (data.containsKey('interval_index')) {
      context.handle(
          _intervalIndexMeta,
          intervalIndex.isAcceptableOrUnknown(
              data['interval_index']!, _intervalIndexMeta));
    } else if (isInserting) {
      context.missing(_intervalIndexMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('last_posted')) {
      context.handle(
          _lastPostedMeta,
          lastPosted.isAcceptableOrUnknown(
              data['last_posted']!, _lastPostedMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringTransactionsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringTransactionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      typeIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type_index'])!,
      categoryIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_index'])!,
      intervalIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interval_index'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      lastPosted: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_posted']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $RecurringTransactionsTableTable createAlias(String alias) {
    return $RecurringTransactionsTableTable(attachedDatabase, alias);
  }
}

class RecurringTransactionsTableData extends DataClass
    implements Insertable<RecurringTransactionsTableData> {
  final String id;
  final double amount;
  final int typeIndex;
  final int categoryIndex;
  final int intervalIndex;
  final DateTime startDate;
  final DateTime? lastPosted;
  final String? note;
  final bool isActive;
  const RecurringTransactionsTableData(
      {required this.id,
      required this.amount,
      required this.typeIndex,
      required this.categoryIndex,
      required this.intervalIndex,
      required this.startDate,
      this.lastPosted,
      this.note,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<double>(amount);
    map['type_index'] = Variable<int>(typeIndex);
    map['category_index'] = Variable<int>(categoryIndex);
    map['interval_index'] = Variable<int>(intervalIndex);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || lastPosted != null) {
      map['last_posted'] = Variable<DateTime>(lastPosted);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  RecurringTransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return RecurringTransactionsTableCompanion(
      id: Value(id),
      amount: Value(amount),
      typeIndex: Value(typeIndex),
      categoryIndex: Value(categoryIndex),
      intervalIndex: Value(intervalIndex),
      startDate: Value(startDate),
      lastPosted: lastPosted == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPosted),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isActive: Value(isActive),
    );
  }

  factory RecurringTransactionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringTransactionsTableData(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      typeIndex: serializer.fromJson<int>(json['typeIndex']),
      categoryIndex: serializer.fromJson<int>(json['categoryIndex']),
      intervalIndex: serializer.fromJson<int>(json['intervalIndex']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      lastPosted: serializer.fromJson<DateTime?>(json['lastPosted']),
      note: serializer.fromJson<String?>(json['note']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<double>(amount),
      'typeIndex': serializer.toJson<int>(typeIndex),
      'categoryIndex': serializer.toJson<int>(categoryIndex),
      'intervalIndex': serializer.toJson<int>(intervalIndex),
      'startDate': serializer.toJson<DateTime>(startDate),
      'lastPosted': serializer.toJson<DateTime?>(lastPosted),
      'note': serializer.toJson<String?>(note),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  RecurringTransactionsTableData copyWith(
          {String? id,
          double? amount,
          int? typeIndex,
          int? categoryIndex,
          int? intervalIndex,
          DateTime? startDate,
          Value<DateTime?> lastPosted = const Value.absent(),
          Value<String?> note = const Value.absent(),
          bool? isActive}) =>
      RecurringTransactionsTableData(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        typeIndex: typeIndex ?? this.typeIndex,
        categoryIndex: categoryIndex ?? this.categoryIndex,
        intervalIndex: intervalIndex ?? this.intervalIndex,
        startDate: startDate ?? this.startDate,
        lastPosted: lastPosted.present ? lastPosted.value : this.lastPosted,
        note: note.present ? note.value : this.note,
        isActive: isActive ?? this.isActive,
      );
  RecurringTransactionsTableData copyWithCompanion(
      RecurringTransactionsTableCompanion data) {
    return RecurringTransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      typeIndex: data.typeIndex.present ? data.typeIndex.value : this.typeIndex,
      categoryIndex: data.categoryIndex.present
          ? data.categoryIndex.value
          : this.categoryIndex,
      intervalIndex: data.intervalIndex.present
          ? data.intervalIndex.value
          : this.intervalIndex,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      lastPosted:
          data.lastPosted.present ? data.lastPosted.value : this.lastPosted,
      note: data.note.present ? data.note.value : this.note,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringTransactionsTableData(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('typeIndex: $typeIndex, ')
          ..write('categoryIndex: $categoryIndex, ')
          ..write('intervalIndex: $intervalIndex, ')
          ..write('startDate: $startDate, ')
          ..write('lastPosted: $lastPosted, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, typeIndex, categoryIndex,
      intervalIndex, startDate, lastPosted, note, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringTransactionsTableData &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.typeIndex == this.typeIndex &&
          other.categoryIndex == this.categoryIndex &&
          other.intervalIndex == this.intervalIndex &&
          other.startDate == this.startDate &&
          other.lastPosted == this.lastPosted &&
          other.note == this.note &&
          other.isActive == this.isActive);
}

class RecurringTransactionsTableCompanion
    extends UpdateCompanion<RecurringTransactionsTableData> {
  final Value<String> id;
  final Value<double> amount;
  final Value<int> typeIndex;
  final Value<int> categoryIndex;
  final Value<int> intervalIndex;
  final Value<DateTime> startDate;
  final Value<DateTime?> lastPosted;
  final Value<String?> note;
  final Value<bool> isActive;
  final Value<int> rowid;
  const RecurringTransactionsTableCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.typeIndex = const Value.absent(),
    this.categoryIndex = const Value.absent(),
    this.intervalIndex = const Value.absent(),
    this.startDate = const Value.absent(),
    this.lastPosted = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurringTransactionsTableCompanion.insert({
    required String id,
    required double amount,
    required int typeIndex,
    required int categoryIndex,
    required int intervalIndex,
    required DateTime startDate,
    this.lastPosted = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        amount = Value(amount),
        typeIndex = Value(typeIndex),
        categoryIndex = Value(categoryIndex),
        intervalIndex = Value(intervalIndex),
        startDate = Value(startDate);
  static Insertable<RecurringTransactionsTableData> custom({
    Expression<String>? id,
    Expression<double>? amount,
    Expression<int>? typeIndex,
    Expression<int>? categoryIndex,
    Expression<int>? intervalIndex,
    Expression<DateTime>? startDate,
    Expression<DateTime>? lastPosted,
    Expression<String>? note,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (typeIndex != null) 'type_index': typeIndex,
      if (categoryIndex != null) 'category_index': categoryIndex,
      if (intervalIndex != null) 'interval_index': intervalIndex,
      if (startDate != null) 'start_date': startDate,
      if (lastPosted != null) 'last_posted': lastPosted,
      if (note != null) 'note': note,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurringTransactionsTableCompanion copyWith(
      {Value<String>? id,
      Value<double>? amount,
      Value<int>? typeIndex,
      Value<int>? categoryIndex,
      Value<int>? intervalIndex,
      Value<DateTime>? startDate,
      Value<DateTime?>? lastPosted,
      Value<String?>? note,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return RecurringTransactionsTableCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      typeIndex: typeIndex ?? this.typeIndex,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      intervalIndex: intervalIndex ?? this.intervalIndex,
      startDate: startDate ?? this.startDate,
      lastPosted: lastPosted ?? this.lastPosted,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (typeIndex.present) {
      map['type_index'] = Variable<int>(typeIndex.value);
    }
    if (categoryIndex.present) {
      map['category_index'] = Variable<int>(categoryIndex.value);
    }
    if (intervalIndex.present) {
      map['interval_index'] = Variable<int>(intervalIndex.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (lastPosted.present) {
      map['last_posted'] = Variable<DateTime>(lastPosted.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringTransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('typeIndex: $typeIndex, ')
          ..write('categoryIndex: $categoryIndex, ')
          ..write('intervalIndex: $intervalIndex, ')
          ..write('startDate: $startDate, ')
          ..write('lastPosted: $lastPosted, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, AppSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currency_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('USD'));
  static const VerificationMeta _currencySymbolMeta =
      const VerificationMeta('currencySymbol');
  @override
  late final GeneratedColumn<String> currencySymbol = GeneratedColumn<String>(
      'currency_symbol', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('\$'));
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('English (US)'));
  static const VerificationMeta _biometricsEnabledMeta =
      const VerificationMeta('biometricsEnabled');
  @override
  late final GeneratedColumn<bool> biometricsEnabled = GeneratedColumn<bool>(
      'biometrics_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("biometrics_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Alexander Sterling'));
  static const VerificationMeta _monthlyBudgetLimitMeta =
      const VerificationMeta('monthlyBudgetLimit');
  @override
  late final GeneratedColumn<double> monthlyBudgetLimit =
      GeneratedColumn<double>('monthly_budget_limit', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(6850.0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        currencyCode,
        currencySymbol,
        language,
        biometricsEnabled,
        userName,
        monthlyBudgetLimit
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
      Insertable<AppSettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('currency_code')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currency_code']!, _currencyCodeMeta));
    }
    if (data.containsKey('currency_symbol')) {
      context.handle(
          _currencySymbolMeta,
          currencySymbol.isAcceptableOrUnknown(
              data['currency_symbol']!, _currencySymbolMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    if (data.containsKey('biometrics_enabled')) {
      context.handle(
          _biometricsEnabledMeta,
          biometricsEnabled.isAcceptableOrUnknown(
              data['biometrics_enabled']!, _biometricsEnabledMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    }
    if (data.containsKey('monthly_budget_limit')) {
      context.handle(
          _monthlyBudgetLimitMeta,
          monthlyBudgetLimit.isAcceptableOrUnknown(
              data['monthly_budget_limit']!, _monthlyBudgetLimitMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_code'])!,
      currencySymbol: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}currency_symbol'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
      biometricsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}biometrics_enabled'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name'])!,
      monthlyBudgetLimit: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}monthly_budget_limit'])!,
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class AppSettingsTableData extends DataClass
    implements Insertable<AppSettingsTableData> {
  final int id;
  final String currencyCode;
  final String currencySymbol;
  final String language;
  final bool biometricsEnabled;
  final String userName;
  final double monthlyBudgetLimit;
  const AppSettingsTableData(
      {required this.id,
      required this.currencyCode,
      required this.currencySymbol,
      required this.language,
      required this.biometricsEnabled,
      required this.userName,
      required this.monthlyBudgetLimit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['currency_code'] = Variable<String>(currencyCode);
    map['currency_symbol'] = Variable<String>(currencySymbol);
    map['language'] = Variable<String>(language);
    map['biometrics_enabled'] = Variable<bool>(biometricsEnabled);
    map['user_name'] = Variable<String>(userName);
    map['monthly_budget_limit'] = Variable<double>(monthlyBudgetLimit);
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      id: Value(id),
      currencyCode: Value(currencyCode),
      currencySymbol: Value(currencySymbol),
      language: Value(language),
      biometricsEnabled: Value(biometricsEnabled),
      userName: Value(userName),
      monthlyBudgetLimit: Value(monthlyBudgetLimit),
    );
  }

  factory AppSettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      currencySymbol: serializer.fromJson<String>(json['currencySymbol']),
      language: serializer.fromJson<String>(json['language']),
      biometricsEnabled: serializer.fromJson<bool>(json['biometricsEnabled']),
      userName: serializer.fromJson<String>(json['userName']),
      monthlyBudgetLimit:
          serializer.fromJson<double>(json['monthlyBudgetLimit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'currencySymbol': serializer.toJson<String>(currencySymbol),
      'language': serializer.toJson<String>(language),
      'biometricsEnabled': serializer.toJson<bool>(biometricsEnabled),
      'userName': serializer.toJson<String>(userName),
      'monthlyBudgetLimit': serializer.toJson<double>(monthlyBudgetLimit),
    };
  }

  AppSettingsTableData copyWith(
          {int? id,
          String? currencyCode,
          String? currencySymbol,
          String? language,
          bool? biometricsEnabled,
          String? userName,
          double? monthlyBudgetLimit}) =>
      AppSettingsTableData(
        id: id ?? this.id,
        currencyCode: currencyCode ?? this.currencyCode,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        language: language ?? this.language,
        biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
        userName: userName ?? this.userName,
        monthlyBudgetLimit: monthlyBudgetLimit ?? this.monthlyBudgetLimit,
      );
  AppSettingsTableData copyWithCompanion(AppSettingsTableCompanion data) {
    return AppSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      currencySymbol: data.currencySymbol.present
          ? data.currencySymbol.value
          : this.currencySymbol,
      language: data.language.present ? data.language.value : this.language,
      biometricsEnabled: data.biometricsEnabled.present
          ? data.biometricsEnabled.value
          : this.biometricsEnabled,
      userName: data.userName.present ? data.userName.value : this.userName,
      monthlyBudgetLimit: data.monthlyBudgetLimit.present
          ? data.monthlyBudgetLimit.value
          : this.monthlyBudgetLimit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableData(')
          ..write('id: $id, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('language: $language, ')
          ..write('biometricsEnabled: $biometricsEnabled, ')
          ..write('userName: $userName, ')
          ..write('monthlyBudgetLimit: $monthlyBudgetLimit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currencyCode, currencySymbol, language,
      biometricsEnabled, userName, monthlyBudgetLimit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsTableData &&
          other.id == this.id &&
          other.currencyCode == this.currencyCode &&
          other.currencySymbol == this.currencySymbol &&
          other.language == this.language &&
          other.biometricsEnabled == this.biometricsEnabled &&
          other.userName == this.userName &&
          other.monthlyBudgetLimit == this.monthlyBudgetLimit);
}

class AppSettingsTableCompanion extends UpdateCompanion<AppSettingsTableData> {
  final Value<int> id;
  final Value<String> currencyCode;
  final Value<String> currencySymbol;
  final Value<String> language;
  final Value<bool> biometricsEnabled;
  final Value<String> userName;
  final Value<double> monthlyBudgetLimit;
  const AppSettingsTableCompanion({
    this.id = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.currencySymbol = const Value.absent(),
    this.language = const Value.absent(),
    this.biometricsEnabled = const Value.absent(),
    this.userName = const Value.absent(),
    this.monthlyBudgetLimit = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.currencySymbol = const Value.absent(),
    this.language = const Value.absent(),
    this.biometricsEnabled = const Value.absent(),
    this.userName = const Value.absent(),
    this.monthlyBudgetLimit = const Value.absent(),
  });
  static Insertable<AppSettingsTableData> custom({
    Expression<int>? id,
    Expression<String>? currencyCode,
    Expression<String>? currencySymbol,
    Expression<String>? language,
    Expression<bool>? biometricsEnabled,
    Expression<String>? userName,
    Expression<double>? monthlyBudgetLimit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (currencySymbol != null) 'currency_symbol': currencySymbol,
      if (language != null) 'language': language,
      if (biometricsEnabled != null) 'biometrics_enabled': biometricsEnabled,
      if (userName != null) 'user_name': userName,
      if (monthlyBudgetLimit != null)
        'monthly_budget_limit': monthlyBudgetLimit,
    });
  }

  AppSettingsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? currencyCode,
      Value<String>? currencySymbol,
      Value<String>? language,
      Value<bool>? biometricsEnabled,
      Value<String>? userName,
      Value<double>? monthlyBudgetLimit}) {
    return AppSettingsTableCompanion(
      id: id ?? this.id,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      language: language ?? this.language,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      userName: userName ?? this.userName,
      monthlyBudgetLimit: monthlyBudgetLimit ?? this.monthlyBudgetLimit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (currencySymbol.present) {
      map['currency_symbol'] = Variable<String>(currencySymbol.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (biometricsEnabled.present) {
      map['biometrics_enabled'] = Variable<bool>(biometricsEnabled.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (monthlyBudgetLimit.present) {
      map['monthly_budget_limit'] = Variable<double>(monthlyBudgetLimit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencySymbol: $currencySymbol, ')
          ..write('language: $language, ')
          ..write('biometricsEnabled: $biometricsEnabled, ')
          ..write('userName: $userName, ')
          ..write('monthlyBudgetLimit: $monthlyBudgetLimit')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  late final $BudgetsTableTable budgetsTable = $BudgetsTableTable(this);
  late final $RecurringTransactionsTableTable recurringTransactionsTable =
      $RecurringTransactionsTableTable(this);
  late final $AppSettingsTableTable appSettingsTable =
      $AppSettingsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        transactionsTable,
        budgetsTable,
        recurringTransactionsTable,
        appSettingsTable
      ];
}

typedef $$TransactionsTableTableCreateCompanionBuilder
    = TransactionsTableCompanion Function({
  required String id,
  required double amount,
  required int typeIndex,
  required int categoryIndex,
  required DateTime date,
  Value<String?> note,
  Value<bool> isRecurring,
  Value<String?> recurringId,
  Value<int> rowid,
});
typedef $$TransactionsTableTableUpdateCompanionBuilder
    = TransactionsTableCompanion Function({
  Value<String> id,
  Value<double> amount,
  Value<int> typeIndex,
  Value<int> categoryIndex,
  Value<DateTime> date,
  Value<String?> note,
  Value<bool> isRecurring,
  Value<String?> recurringId,
  Value<int> rowid,
});

class $$TransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get typeIndex => $composableBuilder(
      column: $table.typeIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get categoryIndex => $composableBuilder(
      column: $table.categoryIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRecurring => $composableBuilder(
      column: $table.isRecurring, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recurringId => $composableBuilder(
      column: $table.recurringId, builder: (column) => ColumnFilters(column));
}

class $$TransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get typeIndex => $composableBuilder(
      column: $table.typeIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get categoryIndex => $composableBuilder(
      column: $table.categoryIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRecurring => $composableBuilder(
      column: $table.isRecurring, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recurringId => $composableBuilder(
      column: $table.recurringId, builder: (column) => ColumnOrderings(column));
}

class $$TransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get typeIndex =>
      $composableBuilder(column: $table.typeIndex, builder: (column) => column);

  GeneratedColumn<int> get categoryIndex => $composableBuilder(
      column: $table.categoryIndex, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isRecurring => $composableBuilder(
      column: $table.isRecurring, builder: (column) => column);

  GeneratedColumn<String> get recurringId => $composableBuilder(
      column: $table.recurringId, builder: (column) => column);
}

class $$TransactionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTableTable,
    TransactionsTableData,
    $$TransactionsTableTableFilterComposer,
    $$TransactionsTableTableOrderingComposer,
    $$TransactionsTableTableAnnotationComposer,
    $$TransactionsTableTableCreateCompanionBuilder,
    $$TransactionsTableTableUpdateCompanionBuilder,
    (
      TransactionsTableData,
      BaseReferences<_$AppDatabase, $TransactionsTableTable,
          TransactionsTableData>
    ),
    TransactionsTableData,
    PrefetchHooks Function()> {
  $$TransactionsTableTableTableManager(
      _$AppDatabase db, $TransactionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<int> typeIndex = const Value.absent(),
            Value<int> categoryIndex = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isRecurring = const Value.absent(),
            Value<String?> recurringId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionsTableCompanion(
            id: id,
            amount: amount,
            typeIndex: typeIndex,
            categoryIndex: categoryIndex,
            date: date,
            note: note,
            isRecurring: isRecurring,
            recurringId: recurringId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required double amount,
            required int typeIndex,
            required int categoryIndex,
            required DateTime date,
            Value<String?> note = const Value.absent(),
            Value<bool> isRecurring = const Value.absent(),
            Value<String?> recurringId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionsTableCompanion.insert(
            id: id,
            amount: amount,
            typeIndex: typeIndex,
            categoryIndex: categoryIndex,
            date: date,
            note: note,
            isRecurring: isRecurring,
            recurringId: recurringId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionsTableTable,
    TransactionsTableData,
    $$TransactionsTableTableFilterComposer,
    $$TransactionsTableTableOrderingComposer,
    $$TransactionsTableTableAnnotationComposer,
    $$TransactionsTableTableCreateCompanionBuilder,
    $$TransactionsTableTableUpdateCompanionBuilder,
    (
      TransactionsTableData,
      BaseReferences<_$AppDatabase, $TransactionsTableTable,
          TransactionsTableData>
    ),
    TransactionsTableData,
    PrefetchHooks Function()>;
typedef $$BudgetsTableTableCreateCompanionBuilder = BudgetsTableCompanion
    Function({
  required String id,
  required int categoryIndex,
  required double budgetLimit,
  required DateTime startDate,
  required DateTime endDate,
  Value<int> rowid,
});
typedef $$BudgetsTableTableUpdateCompanionBuilder = BudgetsTableCompanion
    Function({
  Value<String> id,
  Value<int> categoryIndex,
  Value<double> budgetLimit,
  Value<DateTime> startDate,
  Value<DateTime> endDate,
  Value<int> rowid,
});

class $$BudgetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get categoryIndex => $composableBuilder(
      column: $table.categoryIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get budgetLimit => $composableBuilder(
      column: $table.budgetLimit, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));
}

class $$BudgetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get categoryIndex => $composableBuilder(
      column: $table.categoryIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get budgetLimit => $composableBuilder(
      column: $table.budgetLimit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));
}

class $$BudgetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get categoryIndex => $composableBuilder(
      column: $table.categoryIndex, builder: (column) => column);

  GeneratedColumn<double> get budgetLimit => $composableBuilder(
      column: $table.budgetLimit, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);
}

class $$BudgetsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BudgetsTableTable,
    BudgetsTableData,
    $$BudgetsTableTableFilterComposer,
    $$BudgetsTableTableOrderingComposer,
    $$BudgetsTableTableAnnotationComposer,
    $$BudgetsTableTableCreateCompanionBuilder,
    $$BudgetsTableTableUpdateCompanionBuilder,
    (
      BudgetsTableData,
      BaseReferences<_$AppDatabase, $BudgetsTableTable, BudgetsTableData>
    ),
    BudgetsTableData,
    PrefetchHooks Function()> {
  $$BudgetsTableTableTableManager(_$AppDatabase db, $BudgetsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> categoryIndex = const Value.absent(),
            Value<double> budgetLimit = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime> endDate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BudgetsTableCompanion(
            id: id,
            categoryIndex: categoryIndex,
            budgetLimit: budgetLimit,
            startDate: startDate,
            endDate: endDate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int categoryIndex,
            required double budgetLimit,
            required DateTime startDate,
            required DateTime endDate,
            Value<int> rowid = const Value.absent(),
          }) =>
              BudgetsTableCompanion.insert(
            id: id,
            categoryIndex: categoryIndex,
            budgetLimit: budgetLimit,
            startDate: startDate,
            endDate: endDate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BudgetsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BudgetsTableTable,
    BudgetsTableData,
    $$BudgetsTableTableFilterComposer,
    $$BudgetsTableTableOrderingComposer,
    $$BudgetsTableTableAnnotationComposer,
    $$BudgetsTableTableCreateCompanionBuilder,
    $$BudgetsTableTableUpdateCompanionBuilder,
    (
      BudgetsTableData,
      BaseReferences<_$AppDatabase, $BudgetsTableTable, BudgetsTableData>
    ),
    BudgetsTableData,
    PrefetchHooks Function()>;
typedef $$RecurringTransactionsTableTableCreateCompanionBuilder
    = RecurringTransactionsTableCompanion Function({
  required String id,
  required double amount,
  required int typeIndex,
  required int categoryIndex,
  required int intervalIndex,
  required DateTime startDate,
  Value<DateTime?> lastPosted,
  Value<String?> note,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$RecurringTransactionsTableTableUpdateCompanionBuilder
    = RecurringTransactionsTableCompanion Function({
  Value<String> id,
  Value<double> amount,
  Value<int> typeIndex,
  Value<int> categoryIndex,
  Value<int> intervalIndex,
  Value<DateTime> startDate,
  Value<DateTime?> lastPosted,
  Value<String?> note,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$RecurringTransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringTransactionsTableTable> {
  $$RecurringTransactionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get typeIndex => $composableBuilder(
      column: $table.typeIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get categoryIndex => $composableBuilder(
      column: $table.categoryIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intervalIndex => $composableBuilder(
      column: $table.intervalIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastPosted => $composableBuilder(
      column: $table.lastPosted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));
}

class $$RecurringTransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringTransactionsTableTable> {
  $$RecurringTransactionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get typeIndex => $composableBuilder(
      column: $table.typeIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get categoryIndex => $composableBuilder(
      column: $table.categoryIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervalIndex => $composableBuilder(
      column: $table.intervalIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastPosted => $composableBuilder(
      column: $table.lastPosted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$RecurringTransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringTransactionsTableTable> {
  $$RecurringTransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get typeIndex =>
      $composableBuilder(column: $table.typeIndex, builder: (column) => column);

  GeneratedColumn<int> get categoryIndex => $composableBuilder(
      column: $table.categoryIndex, builder: (column) => column);

  GeneratedColumn<int> get intervalIndex => $composableBuilder(
      column: $table.intervalIndex, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPosted => $composableBuilder(
      column: $table.lastPosted, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$RecurringTransactionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecurringTransactionsTableTable,
    RecurringTransactionsTableData,
    $$RecurringTransactionsTableTableFilterComposer,
    $$RecurringTransactionsTableTableOrderingComposer,
    $$RecurringTransactionsTableTableAnnotationComposer,
    $$RecurringTransactionsTableTableCreateCompanionBuilder,
    $$RecurringTransactionsTableTableUpdateCompanionBuilder,
    (
      RecurringTransactionsTableData,
      BaseReferences<_$AppDatabase, $RecurringTransactionsTableTable,
          RecurringTransactionsTableData>
    ),
    RecurringTransactionsTableData,
    PrefetchHooks Function()> {
  $$RecurringTransactionsTableTableTableManager(
      _$AppDatabase db, $RecurringTransactionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringTransactionsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringTransactionsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringTransactionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<int> typeIndex = const Value.absent(),
            Value<int> categoryIndex = const Value.absent(),
            Value<int> intervalIndex = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> lastPosted = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecurringTransactionsTableCompanion(
            id: id,
            amount: amount,
            typeIndex: typeIndex,
            categoryIndex: categoryIndex,
            intervalIndex: intervalIndex,
            startDate: startDate,
            lastPosted: lastPosted,
            note: note,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required double amount,
            required int typeIndex,
            required int categoryIndex,
            required int intervalIndex,
            required DateTime startDate,
            Value<DateTime?> lastPosted = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecurringTransactionsTableCompanion.insert(
            id: id,
            amount: amount,
            typeIndex: typeIndex,
            categoryIndex: categoryIndex,
            intervalIndex: intervalIndex,
            startDate: startDate,
            lastPosted: lastPosted,
            note: note,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RecurringTransactionsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $RecurringTransactionsTableTable,
        RecurringTransactionsTableData,
        $$RecurringTransactionsTableTableFilterComposer,
        $$RecurringTransactionsTableTableOrderingComposer,
        $$RecurringTransactionsTableTableAnnotationComposer,
        $$RecurringTransactionsTableTableCreateCompanionBuilder,
        $$RecurringTransactionsTableTableUpdateCompanionBuilder,
        (
          RecurringTransactionsTableData,
          BaseReferences<_$AppDatabase, $RecurringTransactionsTableTable,
              RecurringTransactionsTableData>
        ),
        RecurringTransactionsTableData,
        PrefetchHooks Function()>;
typedef $$AppSettingsTableTableCreateCompanionBuilder
    = AppSettingsTableCompanion Function({
  Value<int> id,
  Value<String> currencyCode,
  Value<String> currencySymbol,
  Value<String> language,
  Value<bool> biometricsEnabled,
  Value<String> userName,
  Value<double> monthlyBudgetLimit,
});
typedef $$AppSettingsTableTableUpdateCompanionBuilder
    = AppSettingsTableCompanion Function({
  Value<int> id,
  Value<String> currencyCode,
  Value<String> currencySymbol,
  Value<String> language,
  Value<bool> biometricsEnabled,
  Value<String> userName,
  Value<double> monthlyBudgetLimit,
});

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currencySymbol => $composableBuilder(
      column: $table.currencySymbol,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get biometricsEnabled => $composableBuilder(
      column: $table.biometricsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userName => $composableBuilder(
      column: $table.userName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monthlyBudgetLimit => $composableBuilder(
      column: $table.monthlyBudgetLimit,
      builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currencySymbol => $composableBuilder(
      column: $table.currencySymbol,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get biometricsEnabled => $composableBuilder(
      column: $table.biometricsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userName => $composableBuilder(
      column: $table.userName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monthlyBudgetLimit => $composableBuilder(
      column: $table.monthlyBudgetLimit,
      builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => column);

  GeneratedColumn<String> get currencySymbol => $composableBuilder(
      column: $table.currencySymbol, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<bool> get biometricsEnabled => $composableBuilder(
      column: $table.biometricsEnabled, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<double> get monthlyBudgetLimit => $composableBuilder(
      column: $table.monthlyBudgetLimit, builder: (column) => column);
}

class $$AppSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTableTable,
    AppSettingsTableData,
    $$AppSettingsTableTableFilterComposer,
    $$AppSettingsTableTableOrderingComposer,
    $$AppSettingsTableTableAnnotationComposer,
    $$AppSettingsTableTableCreateCompanionBuilder,
    $$AppSettingsTableTableUpdateCompanionBuilder,
    (
      AppSettingsTableData,
      BaseReferences<_$AppDatabase, $AppSettingsTableTable,
          AppSettingsTableData>
    ),
    AppSettingsTableData,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableTableManager(
      _$AppDatabase db, $AppSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<String> currencySymbol = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<bool> biometricsEnabled = const Value.absent(),
            Value<String> userName = const Value.absent(),
            Value<double> monthlyBudgetLimit = const Value.absent(),
          }) =>
              AppSettingsTableCompanion(
            id: id,
            currencyCode: currencyCode,
            currencySymbol: currencySymbol,
            language: language,
            biometricsEnabled: biometricsEnabled,
            userName: userName,
            monthlyBudgetLimit: monthlyBudgetLimit,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<String> currencySymbol = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<bool> biometricsEnabled = const Value.absent(),
            Value<String> userName = const Value.absent(),
            Value<double> monthlyBudgetLimit = const Value.absent(),
          }) =>
              AppSettingsTableCompanion.insert(
            id: id,
            currencyCode: currencyCode,
            currencySymbol: currencySymbol,
            language: language,
            biometricsEnabled: biometricsEnabled,
            userName: userName,
            monthlyBudgetLimit: monthlyBudgetLimit,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTableTable,
    AppSettingsTableData,
    $$AppSettingsTableTableFilterComposer,
    $$AppSettingsTableTableOrderingComposer,
    $$AppSettingsTableTableAnnotationComposer,
    $$AppSettingsTableTableCreateCompanionBuilder,
    $$AppSettingsTableTableUpdateCompanionBuilder,
    (
      AppSettingsTableData,
      BaseReferences<_$AppDatabase, $AppSettingsTableTable,
          AppSettingsTableData>
    ),
    AppSettingsTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(_db, _db.transactionsTable);
  $$BudgetsTableTableTableManager get budgetsTable =>
      $$BudgetsTableTableTableManager(_db, _db.budgetsTable);
  $$RecurringTransactionsTableTableTableManager
      get recurringTransactionsTable =>
          $$RecurringTransactionsTableTableTableManager(
              _db, _db.recurringTransactionsTable);
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
}
