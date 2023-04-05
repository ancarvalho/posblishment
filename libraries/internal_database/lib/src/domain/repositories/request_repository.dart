import "package:core/core.dart";

abstract class RequestRepository {
  Future<bool> createRequest(Request request);
  Future<bool> cancelRequest(String id);
  Future<bool> deleteRequest(String id);

}
