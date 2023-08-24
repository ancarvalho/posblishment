
import 'package:administration/src/presenter/pages/bill/bill_page.dart';
import 'package:administration/src/presenter/pages/bills/bills_page.dart';
import 'package:administration/src/presenter/pages/bills/bills_store.dart';
import 'package:administration/src/presenter/pages/last_paid_bills/last_paid_bills_page.dart';
import 'package:administration/src/presenter/pages/last_requests/last_requests_page.dart';
import 'package:administration/src/presenter/pages/menu/menu_page.dart';
import 'package:administration/src/presenter/pages/payment/payment_page.dart';
import 'package:administration/src/presenter/pages/payment/payment_store.dart';
import 'package:administration/src/presenter/stores/products/products_store.dart';
import 'package:administration/src/presenter/widgets/bill_items/bill_items_store.dart';
import 'package:administration/src/presenter/widgets/bill_requests/bill_requests_store.dart';
import 'package:administration/src/presenter/widgets/bill_total/bill_total_store.dart';
import 'package:administration/src/presenter/widgets/last_paid_bills/last_paid_bills_store.dart';
import 'package:administration/src/presenter/widgets/last_requests/last_requests_store.dart';
import 'package:administration/src/presenter/widgets/undelivered_requests/undelivered_requests_store.dart';
import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/administration_repository.dart';
import 'domain/use_cases/cancel_bill.dart';
import 'domain/use_cases/cancel_request.dart';
// import 'domain/use_cases/create_bill.dart';
import 'domain/use_cases/finalize_bill.dart';
import 'domain/use_cases/get_all_products.dart';
import 'domain/use_cases/get_bill.dart';
import 'domain/use_cases/get_bill_items.dart';
import 'domain/use_cases/get_bill_requests.dart';
import 'domain/use_cases/get_bill_total.dart';
import 'domain/use_cases/get_last_paid_bills.dart';
import 'domain/use_cases/get_last_requests.dart';
import 'domain/use_cases/get_not_paid_bills.dart';
import 'domain/use_cases/set_item_delivered.dart';
import 'domain/use_cases/set_request_delivered.dart';
import 'infra/data_sources/administration_data_source.dart';
import 'infra/repositories/administration_repository_impl.dart';
import 'internal/data_source/administration_data_source_internal_impl.dart';
import 'presenter/pages/order_sheet/order_sheet_page.dart';



class AdministrationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NotPaidBillsStore(i(), ),export: true,),
    Bind.lazySingleton((i) => ProductStore(i()),export: true,),
    Bind.lazySingleton((i) => BillItemsStore(i()),export: true,),
    Bind.lazySingleton((i) => BillRequestsStore(i()),export: true,),
    Bind.lazySingleton((i) => BillTotalStore(i()),export: true,),
    Bind.lazySingleton((i) => LastPaidBillsStore(i()),export: true,),
    Bind.lazySingleton((i) => LastRequestsStore(i()),export: true,),
    Bind.lazySingleton((i) => UndeliveredRequestsStore(i()),export: true,),
    Bind.lazySingleton((i) => PaymentStore(i()),export: true,),



    //TODO Init Stores

    Bind.lazySingleton<ISetRequestDelivered>((i) => SetRequestDelivered(i()),),
    Bind.lazySingleton<ISetItemDelivered>((i) => SetItemDelivered(i()),),
    Bind.lazySingleton<IGetNotPaidBills>((i) => GetNotPaidBills(i()),),
    Bind.lazySingleton<IGetLastRequests>((i) => GetLastRequests(i()),),
    Bind.lazySingleton<IGetLastPaidBills>((i) => GetLastPaidBills(i()),),
    Bind.lazySingleton<IGetBill>((i) => GetBill(i()),),
    Bind.lazySingleton<IGetBillTotal>((i) => GetBillTotal(i()),),
    Bind.lazySingleton<IGetBillRequests>((i) => GetBillRequests(i()),),
    Bind.lazySingleton<IGetBillItems>((i) => GetBillItems(i()),),
    Bind.lazySingleton<IGetAllProducts>((i) => GetAllProducts(i()),),
    Bind.lazySingleton<IFinalizeBill>((i) => FinalizeBill(i()),),
    // Bind.lazySingleton<ICreateBill>((i) => CreateBill(i()),),
    Bind.lazySingleton<ICancelRequest>((i) => CancelRequest(i()),),
    Bind.lazySingleton<ICancelBill>((i) => CancelBill(i()),),


    Bind.lazySingleton<AdministrationRepository>((i) => AdministrationRepositoryImpl(i()),),

    Bind.lazySingleton<AdministrationDataSource>((i) => AdministrationDataSourceInternalImpl(i()),),

  ];

  @override
  final List<ModularRoute> routes = [

    ChildRoute(PagesRoutes.bills.route, child: (_, args) => const BillsPage()),
    ChildRoute(PagesRoutes.lastPaidBills.route, child: (_, args) => const LastPaidBillsPage()),
    ChildRoute(PagesRoutes.lastRequests.route, child: (_, args) => const LastRequestsPage()),

    ChildRoute(PagesRoutes.bill.route, child: (_, args) => BillPage(billID: args.data,)),
    ChildRoute(PagesRoutes.menu.route, child: (_, args) => const MenuPage()),
    ChildRoute(PagesRoutes.orderSheet.route, child: (_, args) => const OrderSheetPage()),

    ChildRoute(PagesRoutes.payment.route, child: (_, args) =>  PaymentPage(billID: args.data,)),
  ];
}
