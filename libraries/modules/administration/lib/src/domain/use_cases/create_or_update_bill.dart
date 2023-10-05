import 'package:administration/src/domain/repositories/administration_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

// ignore: one_member_abstracts
abstract class ICreateOrUpdateBill {
  Future<Either<Failure, String>> call(NewBill bill, NewRequest request);
}

class CreateOrUpdateBill implements ICreateOrUpdateBill {
  final AdministrationRepository repository;

  CreateOrUpdateBill(this.repository);

  @override
  Future<Either<Failure, String>> call(
    NewBill newBill,
    NewRequest request,
  ) async {
    Bill? bill;
    Failure? failure;

    // Ignore if bill does not exist 
    await repository
        .getBillByTable(newBill.table!)
        .then((value) => value.fold((l) => null, (r) => bill = r));

    if (bill == null) {
      await repository
          .createBill(newBill)
          .then((value) => value.fold((l) => failure = l, (r) => bill = r));
    }

    if (bill != null) return repository.createRequest(bill!.id, request);
    debugPrint(failure?.errorMessage);
    return Left(failure!);
  }
}
