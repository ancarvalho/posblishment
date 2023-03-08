import 'package:core/core.dart';
import 'package:objectbox/objectbox.dart' as objectbox;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class ObjectBoxStore {

  Future<objectbox.Store> initStore() async {
    final appDocumentsDirectory =
        await path_provider.getApplicationDocumentsDirectory();

    return objectbox.Store(
      getObjectBoxModel(),
      directory: path.join(appDocumentsDirectory.path, 'posblishment-db'),
    );
  }
}
