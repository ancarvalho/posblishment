import 'package:core/core.dart';
import 'package:drift/drift.dart';
import 'package:internal_database/internal_database.dart';
import 'package:statistics/src/domain/entities/entities.dart';
import 'package:statistics/src/domain/enums/frequency.dart';
import 'package:statistics/src/domain/errors/dashboard_failures.dart';

import '../domain/adapter/basic_statistics.dart';
import '../infra/data_source/statistics_data_source.dart';

class StatisticsDataSourceImpl implements StatisticsDataSource {
  final AppDatabase _appDatabase;

  StatisticsDataSourceImpl(this._appDatabase);

  String getStartOfWeek(DateTime date) {
    final weekday = date.weekday;
    return "${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day - weekday} 00:00:00";
  }

  String getStartOfMonth(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, "0")}-01 00:00:00";
  }

  String getStartOfDay(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day} 00:00:00";
  }

  DateRange getRange(Frequency frequency) {
    final dateNow = DateTime.now();
    final endFormattedDate =
        "${dateNow.year}-${dateNow.month.toString().padLeft(2, "0")}-${dateNow.day} 23:59:59";
    switch (frequency) {
      case Frequency.today:
        return DateRange(
          startDate: getStartOfDay(dateNow),
          endDate: endFormattedDate,
        );
      case Frequency.week:
        return DateRange(
          startDate: getStartOfWeek(dateNow),
          endDate: endFormattedDate,
        );
      case Frequency.month:
        return DateRange(
          startDate: getStartOfMonth(dateNow),
          endDate: endFormattedDate,
        );
    }
  }

  Future<double> getNotPaidSubtotal(DateRange interval) async {
    try {
      final b = _appDatabase
          .customSelect(
            """
            SELECT 
              SUM(i.quantity * i.price) as subtotal
            FROM bill b
            LEFT JOIN request r ON r.bill_id = b.id
            LEFT JOIN item i ON r.id = i.request_id
            WHERE b.created_at BETWEEN ? AND ? AND b.status IN (0, 1) AND r.status IN (0,1) AND i.status IN (0,1)
            
      """,
            variables: [
              Variable.withDateTime(DateTime.parse(interval.startDate)),
              Variable.withDateTime(DateTime.parse(interval.endDate)),
            ],
            readsFrom: {
              _appDatabase.payment,
              _appDatabase.bill,
              _appDatabase.item,
              _appDatabase.request,
              _appDatabase.billType
            },
          )
          .getSingle()
          .then((value) {
            return value.read<double>("subtotal");
          });

      return b;
    } catch (e, s) {
      throw StatisticsError(
          s, "StatisticsModule-getNotPaidSubtotal", e, e.toString());
    }
  }

  //Raw Bill
  @override
  Future<BasicStatistics> getBasicStatistics(Frequency frequency) async {
    try {
      final interval = getRange(frequency);
      final b = await _appDatabase
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
            WHERE b.created_at BETWEEN ? AND ? AND b.status IN (2,3,5) AND r.status IN (0,1) AND i.status IN (0,1)
            GROUP BY b.id
      """,
            variables: [
              Variable.withDateTime(DateTime.parse(interval.startDate)),
              Variable.withDateTime(DateTime.parse(interval.endDate)),
              // Variable.withString([BillStatus.paid, BillStatus.partiallyPaid, BillStatus.paidWithoutCommission].join(",")),
              // Variable.withString([RequestStatus.delivered ,RequestStatus.preparing].join(",")),
              // Variable.withString([ItemStatus.delivered, ItemStatus.preparing].join(","))
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
                    value: row.read<double?>("bill_type_value"),
                  ),
                )
                .toList();
          })
          .then(BasicStatisticsAdapter.convertFromCalculateTotal);

      b.notPaid = await getNotPaidSubtotal(interval);

      return b;
    } catch (e, s) {
      throw StatisticsError(
          s, "StatisticsModule-getBasicStatistics", e, e.toString());
    }
  }

  @override
  Future<List<ItemSold>> getMostSoldProducts(Frequency frequency) async {
    try {
      final interval = getRange(frequency);
      final b = await _appDatabase
          .customSelect(
            """
           SELECT 
            SUM(i.quantity) as total_quantity, 
            p.name as name
           FROM item i
           LEFT JOIN product p ON p.id = i.product_id
           WHERE i.created_at BETWEEN ? AND ? AND i.status IS NOT ?
           GROUP BY i.product_id
           ORDER BY total_quantity
           LIMIT 10
      """,
            variables: [
              Variable.withDateTime(DateTime.parse(interval.startDate)),
              Variable.withDateTime(DateTime.parse(interval.endDate)),
              Variable.withInt(ItemStatus.canceled.index),
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
                    quantity: row.read<int>("total_quantity"),
                  ),
                )
                .toList();
          });
      // debugPrint(interval.endDate);

      return b;
    } catch (e, s) {
      throw StatisticsError(
          s, "StatisticsModule-getMostSoldProducts", e, e.toString());
    }
  }

  @override
  Future<List<ItemSold>> getMostSoldProductsByCategory(
      Frequency frequency, String categoryId) {
    try {
      final interval = getRange(frequency);
      final b = _appDatabase
          .customSelect(
            """
           SELECT 
            SUM(i.quantity) as total_quantity, 
            p.name as name
           FROM item i
           LEFT JOIN product p ON p.id = i.product_id
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
    } catch (e, s) {
      throw StatisticsError(
          s, "StatisticsModule-getMostSoldProductsByCategory", e, e.toString());
    }
  }
}
