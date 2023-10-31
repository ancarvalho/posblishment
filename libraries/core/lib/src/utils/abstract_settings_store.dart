import 'package:flutter_triple/flutter_triple.dart';

import '../../core.dart';

abstract class AbstractSettingsStore extends StreamStore<Failure, Settings> {
  AbstractSettingsStore(super.initialState);
  
}