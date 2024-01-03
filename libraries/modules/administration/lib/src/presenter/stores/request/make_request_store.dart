import "dart:async";

import "package:core/core.dart";
import "package:flutter_triple/flutter_triple.dart";

import "../../../domain/errors/administration_errors.dart";
import "../../../domain/use_cases/use_cases.dart";

class MakeRequestStore extends StreamStore<Failure, String> {
  MakeRequestStore(
    this._createOrUpdateBill,
    this._getRequestItemCategorized,
    this.printerExtend,
    this.settingsStore,
  ) : super("");

  final ICreateOrUpdateBill _createOrUpdateBill;
  final IGetRequestItemCategorized _getRequestItemCategorized;
  final AbstractSettingsStore settingsStore;
  final PrinterAbstract? printerExtend;

  Future<void> createOrUpdateBill(NewBill bill, NewRequest request) async {
    if (!isLoading) {
      setLoading(true);
      Failure? failure;
      final requestId = await _createOrUpdateBill(bill, request).then(
        (value) => value.fold(
          (l) {
            failure = l;
            return null;
          },
          (r) => r,
        ),
      );
      if (failure != null) return setError(failure!);
      final categorizedRequest =
          await _getRequestItemCategorized(requestId!).then(
        (value) => value.fold(
          (l) {
            failure = l;
            return null;
          },
          (r) => r,
        ),
      );
      if (failure != null) return setError(failure!);
      // debugPrint(categorizedRequest?.map((e) => "${e.categoryId}${e.categoryName}${e.productName}").join());
      //TODO setTimeout to paralel func, or run
      if (categorizedRequest != null &&
          settingsStore.state.printerSettings!.enablePrinter) {
        Timer(Duration.zero, () {
          printerExtend?.printRequestItemByCategory(
            categorizedRequest,
            bill.table!,
          );
        });

        // printerExtend?.printRequestItemByCategory(
        //   categorizedRequest,
        //   bill.table!,
        // );
        setLoading(false);
        update(requestId);
      }
    }
    AdministrationError(
      StackTrace.current,
      "AdministrationModule-createOrUpdateBill",
      "",
      "Currently Executing Action",
    );
  }
}
