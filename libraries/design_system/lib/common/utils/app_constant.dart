class AppConstant {
  static String appName = "Posblishment";
  static String appNameDev = "Posblishment Development";
  static String noInternetConnection = "No Internet Connection";
  static String noData = "Any Products Found";
  static String noBills = "Bills Not Found";
  static String noOrders = "Orders Not Found";

  static const home = "/";
  static const bills = "/open_bills";
  static const bill = "/bill/:id";
  static const orders = "/active_orders"; // in desc order
  static const latestOrders = "/latest_orders"; // latest 5 orders

  static const products = "/products";
  static const product = "/product/:id";
  static const createProduct = "/create_product";
  static const updateProduct = "/update_product";

  static const categories = "/categories";
  static const category = "/category/:id";
  static const createCategory = "/create_category";
  static const updateCategory = "/update_category";

  static const stock = "/stock";

  static const statistics = "/statistics";

  static const config = "/config";
}
