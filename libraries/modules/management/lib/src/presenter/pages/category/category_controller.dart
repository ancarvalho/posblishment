// import "package:core/core.dart";
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';

// import '../../../domain/errors/management_failures.dart';
// import 'category_store.dart';

// class CategoryController extends Disposable {
//   // avoiding inject dependency because disposable state
//   final store = Modular.get<CategoryStore>();

//   final formKey = GlobalKey<FormState>();

//   final nameTextController = TextEditingController();
//   final descriptionTextController = TextEditingController();

//   CategoryController();

//   void resetFields(Category? category) {
//     nameTextController.text = category?.name ?? "";
//     descriptionTextController.text = category?.description ?? "";
//   }


//   void clearFields() {
//     nameTextController.text =  "";
//     descriptionTextController.text = "";
//   }


//   Future<Either<Failure, void>> saveChanges(String? id) async {
//     if (formKey.currentState!.validate() && id != null) {
//       return Right(updateCategory(id));
//     } else if (formKey.currentState!.validate()) {
//       return Right(createCategory());
//     }
//     return Left(
//       ManagementError(
//         StackTrace.current,
//         "ManagementError-createOrUpdateCategory",
//         "",
//         "Category name needed",
//       ),
//     );
//   }

//   Future<void> createCategory() async {
//     await store.createCategory(
//       Category(
//         name: nameTextController.text,
//         description: descriptionTextController.text,
//       ),
//     );
//   }

//   Future<void> updateCategory(String id) async {
//     await store.updateCategory(
//       Category(
//         id: id,
//         name: nameTextController.text,
//         description: descriptionTextController.text,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // formKey.currentState?.dispose();
//     nameTextController.dispose();
//     descriptionTextController.dispose();
//   }
// }
