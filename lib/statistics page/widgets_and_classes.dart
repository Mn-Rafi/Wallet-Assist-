class IncomeData {
  final String catogory;
  final double amount;

  IncomeData(this.catogory, this.amount);
}

List<IncomeData> getIncomeChartData() {
  final List<IncomeData> chartIncomeData = [
    IncomeData('Gift', 2000),
    IncomeData('Salary', 3000),
    IncomeData('Bonus', 1000),
    IncomeData('ReFund', 499),
    IncomeData('Profit', 900),
    IncomeData('Interest', 1100),
    IncomeData('Other', 4000),
  ];
  return chartIncomeData;
}

class ExpenseData {
  final String catogory;
  final double amount;

  ExpenseData(this.catogory, this.amount);
}

List<ExpenseData> getExpenseChartData() {
  final List<ExpenseData> chartExpenseData = [
    ExpenseData('Food', 500),
    ExpenseData('Gift', 300),
    ExpenseData('Travel', 5000),
    ExpenseData('Cloth', 5000),
    ExpenseData('Loss', 2000),
    ExpenseData('Other', 3020),
  ];
  return chartExpenseData;
}

