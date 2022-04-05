import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_app/Hive/HiveClass/database.dart';

class IncomeData {
  final String catogory;
  final double amount;

  IncomeData(this.catogory, this.amount);
}

List<IncomeData> getIncomeDate() {
  List<Transactions> transactions =
      Hive.box<Transactions>('transactions').values.toList();
  List<Categories> categories =
      Hive.box<Categories>('categories').values.toList();

  final List<IncomeData> chartIncomeData = [];

  for (int i = 0; i < categories.length; i++) {
    if (categories[i].type == true) {
      double totalAmount = 0;
      for (int j = 0; j < transactions.length; j++) {
        if (transactions[j].categoryName == categories[i].category) {
          totalAmount += transactions[j].amount;
        }
      }
      chartIncomeData.add(IncomeData(categories[i].category, totalAmount));
    }
  }
  return chartIncomeData;
}

class ExpenseData {
  final String catogory;
  final double amount;

  ExpenseData(this.catogory, this.amount);
}

List<ExpenseData> getExpenseDate() {
  List<Transactions> transactions =
      Hive.box<Transactions>('transactions').values.toList();
  List<Categories> categories =
      Hive.box<Categories>('categories').values.toList();

  final List<ExpenseData> chartExpenseData = [];

  for (int i = 0; i < categories.length; i++) {
    if (categories[i].type == false) {
      double totalAmount = 0;
      for (int j = 0; j < transactions.length; j++) {
        if (transactions[j].categoryName == categories[i].category) {
          totalAmount += transactions[j].amount;
        }
      }
      chartExpenseData.add(ExpenseData(categories[i].category, -totalAmount));
    }
  }
  return chartExpenseData;
}
