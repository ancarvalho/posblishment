
import 'package:administration/src/domain/use_cases/close_bill.dart';
import 'package:administration/src/presenter/pages/bill/bill_page.dart';

import 'package:administration/src/presenter/pages/bills/bills_page.dart';
import 'package:administration/src/presenter/widgets/bills/bills_store.dart';
import 'package:administration/src/presenter/pages/cart/cart_page.dart';
import 'package:administration/src/presenter/pages/last_paid_bills/last_paid_bills_page.dart';
import 'package:administration/src/presenter/pages/last_paid_bills/last_paid_bills_store.dart';
import 'package:administration/src/presenter/pages/last_requests/last_requests_page.dart';
import 'package:administration/src/presenter/pages/menu/menu_page.dart';
import 'package:administration/src/presenter/widgets/dialog/bill_types_store.dart';

import 'package:administration/src/presenter/widgets/order_sheet/order_sheet_store.dart';
import 'package:administration/src/presenter/pages/payment/payment_page.dart';
import 'package:administration/src/presenter/pages/payment/payment_store.dart';
import 'package:administration/src/presenter/stores/bill/bill_total_store.dart';
import 'package:administration/src/presenter/stores/products/products_store.dart';
import 'package:administration/src/presenter/stores/request/make_request_store.dart';
import 'package:administration/src/presenter/widgets/bill_items/bill_items_store.dart';
import 'package:administration/src/presenter/widgets/bill_requests/bill_requests_store.dart';
import 'package:administration/src/presenter/widgets/last_requests/last_requests_store.dart';
import 'package:administration/src/presenter/widgets/undelivered_requests/undelivered_requests_store.dart';
import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/administration_repository.dart';


import 'domain/use_cases/cancel_bill_item.dart';
import 'domain/use_cases/use_cases.dart';

import 'infra/data_sources/administration_data_source.dart';
import 'infra/repositories/administration_repository_impl.dart';
import 'internal/data_source/administration_data_source_internal_impl.dart';
import 'presenter/pages/cart/cart_store.dart';
import 'presenter/pages/order_sheet/order_sheet_page.dart';
import 'presenter/stores/bill/bill_store.dart';



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
    Bind.lazySingleton((i) => MakeRequestStore(i(),i(),i(),),export: true,),
    Bind.lazySingleton((i) => OrderSheetStore(i()),export: true,),
    Bind.lazySingleton((i) => CartStore(i()),export: true,),
    Bind.lazySingleton((i) => BillStore(i()),export: true,),
    Bind.lazySingleton((i) => BillTypesStore(i()),export: true,),


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
    Bind.lazySingleton<ICreateOrUpdateBill>((i) => CreateOrUpdateBill(i()),),
    Bind.lazySingleton<ICancelRequest>((i) => CancelRequest(i()),),
    Bind.lazySingleton<ICancelBill>((i) => CancelBill(i()),),
    Bind.lazySingleton<ICloseBill>((i) => CloseBill(i()),),
    Bind.lazySingleton<ICancelBillItem>((i) => CancelBillItem(i()),),
    Bind.lazySingleton<IGetRequestItemCategorized>((i) => GetRequestItemCategorized(i()),),
    Bind.lazySingleton<IUpdateTypeOfBill>((i) => UpdateTypeOfBill(i()),),
    Bind.lazySingleton<IGetBillTypes>((i) => GetBillTypes(i()),),

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
    ChildRoute(PagesRoutes.cart.route, child: (_, args) => const CartPage()),
    ChildRoute(PagesRoutes.orderSheet.route, child: (_, args) => const OrderSheetPage()),

    ChildRoute(PagesRoutes.payment.route, child: (_, args) =>  PaymentPage(billID: args.data,)),
  ];
}
