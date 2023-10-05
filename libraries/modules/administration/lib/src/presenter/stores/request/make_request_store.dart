import "package:core/core.dart";
import "package:flutter_triple/flutter_triple.dart";

import "../../../domain/errors/administration_errors.dart";
import "../../../domain/use_cases/use_cases.dart";

class MakeRequestStore extends StreamStore<Failure, String> {
  MakeRequestStore(this._createOrUpdateBill, this._getRequestItemCategorized, this.printerExtend)
      : super("");

  final ICreateOrUpdateBill _createOrUpdateBill;
  final IGetRequestItemCategorized _getRequestItemCategorized;
  final PrinterAbstract? printerExtend;

  Future<void> createOrUpdateBill(NewBill bill, NewRequest request) async {
    if (!isLoading) {
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
      if (categorizedRequest != null) {
        printerExtend?.printRequestItemByCategory(categorizedRequest, bill.table!,);
        update(requestId);
      }
      
    }
    AdministrationError(
        StackTrace.current,
        "AdministrationModule-createOrUpdateBill",
        "",
        "Currently Executing Action");
  }
}
