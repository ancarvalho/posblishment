import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/use_cases/get_last_requests.dart';

class LastRequestsStore extends StreamStore<Failure, List<Request>> {
  final GetLastRequests _getLastRequests;

  LastRequestsStore( this._getLastRequests) : super([]);

  Future<void> getLastRequests() async => executeEither(
        () => DartzEitherAdapter.adapter(_getLastRequests()),
      );
}
