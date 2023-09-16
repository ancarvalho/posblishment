import 'package:core/core.dart';
import 'package:drift/drift.dart';
import 'package:internal_database/internal_database.dart';
import 'package:statistics/src/domain/entities/entities.dart';
import 'package:statistics/src/domain/enums/frequency.dart';

import '../domain/adapter/basic_statistics.dart';
import '../infra/data_source/statistics_data_source.dart';

class StatisticsDataSourceImpl implements StatisticsDataSource {
  final AppDatabase _appDatabase;

  StatisticsDataSourceImpl(this._appDatabase);

  String getStartOfWeek(DateTime date) {
    final weekday = date.weekday;
    return "${date.year}-${date.day - weekday}-${date.month}";
  }

  String getStartOfMonth(DateTime date) {
    return "${date.year}-01-${date.month}";
  }

  DateRange getRange(Frequency frequency) {
    final dateNow = DateTime.now();
    final formattedDate = "${dateNow.year}-${dateNow.day}-${dateNow.month}";
    switch (frequency) {
      case Frequency.today:
        return DateRange(startDate: formattedDate, endDate: formattedDate);
      case Frequency.week:
        return DateRange(
            startDate: getStartOfWeek(dateNow), endDate: formattedDate,);
      case Frequency.month:
        return DateRange(
            startDate: getStartOfMonth(dateNow), endDate: formattedDate,);
    }
  }

  //Raw Bill
  @override
  Future<BasicStatistics> getBasicStatistics(Frequency frequency) async {
    final interval = getRange(frequency);
    final b = _appDatabase
        .customSelect(
          """
            SELECT 
              SUM(p.value) total_paid, 
              SUM(i.quantity * i.price) as subtotal,
              bt.value as bill_type_value, 
              bt.type as bill_type
            FROM bill b
            LEFT JOIN request r ON r.bill_id = b.id
            LEFT JOIN item i ON r.id = i.request_id
            LEFT JOIN payment p ON b.id = p.bill_id
            LEFT JOIN bill_type bt ON bt.id = b.bill_type_id
            WHERE b.created_at BETWEEN ? AND ? AND b.status IN () AND r.status IN () AND i.status IN ()
            GROUP BY b.id
      """,
          variables: [
            Variable.withString(interval.startDate),
            Variable.withString(interval.endDate),
          ],
          readsFrom: {
            _appDatabase.payment,
            _appDatabase.bill,
            _appDatabase.item,
            _appDatabase.request,
            _appDatabase.billType
          },
        )
        .get()
        .then((value) {
          return value
              .map(
                (row) => RaWBillSubtotal(
                  totalPaid: row.read<double>("total_paid"),
                  subtotal: row.read<double>("subtotal"),
                  billType:
                      BillTypes.values.elementAt(row.read<int>("bill_type")),
                  value: row.read<int?>("bill_type_value"),
                ),
              )
              .toList();
        })
        .then(BasicStatisticsAdapter.convertFromCalculateTotal);

    return b;
  }

  @override
  Future<List<ItemSold>> getMostSoldProducts(Frequency frequency) {
    final interval = getRange(frequency);
    final b = _appDatabase
        .customSelect(
          """
           SELECT 
            SUM(i.quantity) as total_quantity, 
            p.name as name
           FROM item i
           LEFT JOIN product p IN p.id = i.product_id
           WHERE i.created_at BETWEEN ? AND ? AND i.status NOT ?
           GROUP BY i.product_id
           ORDER BY total_quantity
           LIMIT 10
      """,
          variables: [
            Variable.withString(interval.startDate),
            Variable.withString(interval.endDate),
            Variable.withInt(ItemStatus.canceled.index)
          ],
          readsFrom: {
            _appDatabase.product,
            _appDatabase.item,
         
          },
        )
        .get()
        .then((value) {
          return value
              .map(
                (row) => ItemSold(
                  name: row.read<String>("name"),
                  quantity: row.read<int>("quantity"),
                  
                ),
              )
              .toList();
        });

    return b;
  }

  @override
  Future<List<ItemSold>> getMostSoldProductsByCategory(Frequency frequency, String categoryId) {
    final interval = getRange(frequency);
    final b = _appDatabase
        .customSelect(
          """
           SELECT 
            SUM(i.quantity) as total_quantity, 
            p.name as name
           FROM item i
           LEFT JOIN product p IN p.id = i.product_id
           WHERE i.created_at BETWEEN ? AND ? AND i.status NOT ? AND p.id = ?
           GROUP BY i.product_id
           ORDER BY total_quantity
           LIMIT 10
      """,
          variables: [
            Variable.withString(interval.startDate),
            Variable.withString(interval.endDate),
            Variable.withInt(ItemStatus.canceled.index),
            Variable.withString(categoryId),
          ],
          readsFrom: {
            _appDatabase.product,
            _appDatabase.item,
         
          },
        )
        .get()
        .then((value) {
          return value
              .map(
                (row) => ItemSold(
                  name: row.read<String>("name"),
                  quantity: row.read<int>("quantity"),
                  
                ),
              )
              .toList();
        });

    return b;
  }

  
}
