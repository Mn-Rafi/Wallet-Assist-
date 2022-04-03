import 'package:hive/hive.dart';

part 'database.g.dart';

@HiveType(typeId: 0)
class ProfileDetails extends HiveObject {
  @HiveField(0)
  final String nameofUser;

  @HiveField(1)
  final String initialWalletBalance;

  @HiveField(2)
  final String? imageUrl;

  ProfileDetails({
    required this.nameofUser,
    required this.initialWalletBalance,
    this.imageUrl,
  });
}

@HiveType(typeId: 1)
class Categories extends HiveObject {
  @HiveField(0)
  late final String category;

  @HiveField(1)
  final bool type;

  Categories({required this.category, required this.type});
}

@HiveType(typeId: 2)
class Transactions extends HiveObject {
  @HiveField(0)
  final String categoryName;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String dateofTransaction;

  @HiveField(3)
  final String notes;

  @HiveField(4)
  final bool type;

  Transactions({
    required this.categoryName,
    required this.amount,
    required this.dateofTransaction,
    required this.notes,
    required this.type
  });
}