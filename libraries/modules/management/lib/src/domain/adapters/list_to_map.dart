Map<String, String> listsToMapConverter(
  List<String> keys,
  List<String> values,
) {
  if (keys.length != values.length) {
    return {};
  }
  return Map.fromIterables(keys, values);
}
