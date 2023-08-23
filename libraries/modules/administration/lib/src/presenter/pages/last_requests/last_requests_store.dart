import 'package:administration/src/domain/use_cases/get_last_requests.dart';
import 'package:core/core.dart';
import 'package:flutter_triple/flutter_triple.dart';

class LastRequestsStore extends StreamStore<Failure, List<Request>> {
  LastRequestsStore(super.initialState, this._getLastRequests);
  final IGetLastRequests _getLastRequests;

  Future<void> load() async =>
      executeEither(() => DartzEitherAdapter.adapter(_getLastRequests()));
}
