import 'package:administration/src/domain/use_cases/get_last_requests.dart';
import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

class UndeliveredRequestsStore extends StreamStore<Failure, List<Request>> {
  final GetLastRequests _getLastRequests;

  UndeliveredRequestsStore( this._getLastRequests) : super([]);

  Future<void> getUndeliveredRequests() async => executeEither(
        () => DartzEitherAdapter.adapter(_getLastRequests()),
      );
}
