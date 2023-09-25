import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class ICancelBillItem {
  Future<Either<Failure, void>> call(String billId, String productId, int quantity);
}

class CancelBillItem implements ICancelBillItem {
  final AdministrationRepository repository;

  CancelBillItem(this.repository);

  @override
  Future<Either<Failure, void>> call(String billId, String productId, int quantity) async {
    return repository.cancelBillItemQuantity(billId, productId, quantity);
  }
}
