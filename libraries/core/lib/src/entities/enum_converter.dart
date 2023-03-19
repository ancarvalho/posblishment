import 'package:drift/drift.dart';
class JsonAwareIntEnumConverter<E extends Enum> extends EnumIndexConverter<E> {
  JsonAwareIntEnumConverter(super.values);
}
