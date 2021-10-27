class HistoryListData {
  HistoryListData(
      {this.total_price, this.invoice_code, this.pay_date, this.id});

  double total_price;
  String invoice_code;
  int pay_date;
  int id;
  static List historyList = <HistoryListData>[];
}
