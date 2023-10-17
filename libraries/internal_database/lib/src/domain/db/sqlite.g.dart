// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sqlite.dart';

// ignore_for_file: type=lint
class $CategoryTable extends Category
    with TableInfo<$CategoryTable, CategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(const Uuid().v4()));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 6,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'category';
  @override
  String get actualTableName => 'category';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  CategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $CategoryTable createAlias(String alias) {
    return $CategoryTable(attachedDatabase, alias);
  }
}

class CategoryData extends DataClass implements Insertable<CategoryData> {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const CategoryData(
      {required this.id,
      required this.name,
      this.description,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CategoryCompanion toCompanion(bool nullToAbsent) {
    return CategoryCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory CategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  CategoryData copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      CategoryData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoryCompanion extends UpdateCompanion<CategoryData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const CategoryCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CategoryData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return CategoryCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductTable extends Product with TableInfo<$ProductTable, ProductData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(const Uuid().v4()));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 6,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<int> code = GeneratedColumn<int>(
      'code', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _preparableMeta =
      const VerificationMeta('preparable');
  @override
  late final GeneratedColumn<bool> preparable =
      GeneratedColumn<bool>('preparable', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("preparable" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _variationsMeta =
      const VerificationMeta('variations');
  @override
  late final GeneratedColumn<String> variations = GeneratedColumn<String>(
      'variations', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES category (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        price,
        code,
        preparable,
        variations,
        categoryId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'product';
  @override
  String get actualTableName => 'product';
  @override
  VerificationContext validateIntegrity(Insertable<ProductData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('preparable')) {
      context.handle(
          _preparableMeta,
          preparable.isAcceptableOrUnknown(
              data['preparable']!, _preparableMeta));
    }
    if (data.containsKey('variations')) {
      context.handle(
          _variationsMeta,
          variations.isAcceptableOrUnknown(
              data['variations']!, _variationsMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ProductData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}code']),
      preparable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}preparable'])!,
      variations: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variations']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ProductTable createAlias(String alias) {
    return $ProductTable(attachedDatabase, alias);
  }
}

class ProductData extends DataClass implements Insertable<ProductData> {
  final String id;
  final String name;
  final String? description;
  final double price;
  final int? code;
  final bool preparable;
  final String? variations;
  final String categoryId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const ProductData(
      {required this.id,
      required this.name,
      this.description,
      required this.price,
      this.code,
      required this.preparable,
      this.variations,
      required this.categoryId,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<int>(code);
    }
    map['preparable'] = Variable<bool>(preparable);
    if (!nullToAbsent || variations != null) {
      map['variations'] = Variable<String>(variations);
    }
    map['category_id'] = Variable<String>(categoryId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ProductCompanion toCompanion(bool nullToAbsent) {
    return ProductCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      price: Value(price),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      preparable: Value(preparable),
      variations: variations == null && nullToAbsent
          ? const Value.absent()
          : Value(variations),
      categoryId: Value(categoryId),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ProductData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      price: serializer.fromJson<double>(json['price']),
      code: serializer.fromJson<int?>(json['code']),
      preparable: serializer.fromJson<bool>(json['preparable']),
      variations: serializer.fromJson<String?>(json['variations']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'price': serializer.toJson<double>(price),
      'code': serializer.toJson<int?>(code),
      'preparable': serializer.toJson<bool>(preparable),
      'variations': serializer.toJson<String?>(variations),
      'categoryId': serializer.toJson<String>(categoryId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ProductData copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          double? price,
          Value<int?> code = const Value.absent(),
          bool? preparable,
          Value<String?> variations = const Value.absent(),
          String? categoryId,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ProductData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        price: price ?? this.price,
        code: code.present ? code.value : this.code,
        preparable: preparable ?? this.preparable,
        variations: variations.present ? variations.value : this.variations,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('ProductData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('code: $code, ')
          ..write('preparable: $preparable, ')
          ..write('variations: $variations, ')
          ..write('categoryId: $categoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, price, code,
      preparable, variations, categoryId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.price == this.price &&
          other.code == this.code &&
          other.preparable == this.preparable &&
          other.variations == this.variations &&
          other.categoryId == this.categoryId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductCompanion extends UpdateCompanion<ProductData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<double> price;
  final Value<int?> code;
  final Value<bool> preparable;
  final Value<String?> variations;
  final Value<String> categoryId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const ProductCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.code = const Value.absent(),
    this.preparable = const Value.absent(),
    this.variations = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required double price,
    this.code = const Value.absent(),
    this.preparable = const Value.absent(),
    this.variations = const Value.absent(),
    required String categoryId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        price = Value(price),
        categoryId = Value(categoryId);
  static Insertable<ProductData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? price,
    Expression<int>? code,
    Expression<bool>? preparable,
    Expression<String>? variations,
    Expression<String>? categoryId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (code != null) 'code': code,
      if (preparable != null) 'preparable': preparable,
      if (variations != null) 'variations': variations,
      if (categoryId != null) 'category_id': categoryId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<double>? price,
      Value<int?>? code,
      Value<bool>? preparable,
      Value<String?>? variations,
      Value<String>? categoryId,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return ProductCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      code: code ?? this.code,
      preparable: preparable ?? this.preparable,
      variations: variations ?? this.variations,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (code.present) {
      map['code'] = Variable<int>(code.value);
    }
    if (preparable.present) {
      map['preparable'] = Variable<bool>(preparable.value);
    }
    if (variations.present) {
      map['variations'] = Variable<String>(variations.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('code: $code, ')
          ..write('preparable: $preparable, ')
          ..write('variations: $variations, ')
          ..write('categoryId: $categoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillTypeTable extends BillType
    with TableInfo<$BillTypeTable, BillTypeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillTypeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(const Uuid().v4()));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<BillTypes, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<BillTypes>($BillTypeTable.$convertertype);
  static const VerificationMeta _defaultTypeMeta =
      const VerificationMeta('defaultType');
  @override
  late final GeneratedColumn<bool> defaultType =
      GeneratedColumn<bool>('default_type', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("default_type" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, value, name, type, defaultType, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'bill_type';
  @override
  String get actualTableName => 'bill_type';
  @override
  VerificationContext validateIntegrity(Insertable<BillTypeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('default_type')) {
      context.handle(
          _defaultTypeMeta,
          defaultType.isAcceptableOrUnknown(
              data['default_type']!, _defaultTypeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  BillTypeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillTypeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: $BillTypeTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      defaultType: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}default_type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $BillTypeTable createAlias(String alias) {
    return $BillTypeTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BillTypes, int, int> $convertertype =
      JsonAwareIntEnumConverter(BillTypes.values);
}

class BillTypeData extends DataClass implements Insertable<BillTypeData> {
  final String id;
  final double? value;
  final String name;
  final BillTypes type;
  final bool defaultType;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const BillTypeData(
      {required this.id,
      this.value,
      required this.name,
      required this.type,
      required this.defaultType,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    map['name'] = Variable<String>(name);
    {
      final converter = $BillTypeTable.$convertertype;
      map['type'] = Variable<int>(converter.toSql(type));
    }
    map['default_type'] = Variable<bool>(defaultType);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  BillTypeCompanion toCompanion(bool nullToAbsent) {
    return BillTypeCompanion(
      id: Value(id),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      name: Value(name),
      type: Value(type),
      defaultType: Value(defaultType),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory BillTypeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillTypeData(
      id: serializer.fromJson<String>(json['id']),
      value: serializer.fromJson<double?>(json['value']),
      name: serializer.fromJson<String>(json['name']),
      type: $BillTypeTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      defaultType: serializer.fromJson<bool>(json['defaultType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'value': serializer.toJson<double?>(value),
      'name': serializer.toJson<String>(name),
      'type':
          serializer.toJson<int>($BillTypeTable.$convertertype.toJson(type)),
      'defaultType': serializer.toJson<bool>(defaultType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  BillTypeData copyWith(
          {String? id,
          Value<double?> value = const Value.absent(),
          String? name,
          BillTypes? type,
          bool? defaultType,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      BillTypeData(
        id: id ?? this.id,
        value: value.present ? value.value : this.value,
        name: name ?? this.name,
        type: type ?? this.type,
        defaultType: defaultType ?? this.defaultType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('BillTypeData(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('defaultType: $defaultType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, value, name, type, defaultType, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillTypeData &&
          other.id == this.id &&
          other.value == this.value &&
          other.name == this.name &&
          other.type == this.type &&
          other.defaultType == this.defaultType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BillTypeCompanion extends UpdateCompanion<BillTypeData> {
  final Value<String> id;
  final Value<double?> value;
  final Value<String> name;
  final Value<BillTypes> type;
  final Value<bool> defaultType;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const BillTypeCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.defaultType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillTypeCompanion.insert({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
    required String name,
    required BillTypes type,
    this.defaultType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        type = Value(type);
  static Insertable<BillTypeData> custom({
    Expression<String>? id,
    Expression<double>? value,
    Expression<String>? name,
    Expression<int>? type,
    Expression<bool>? defaultType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (defaultType != null) 'default_type': defaultType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillTypeCompanion copyWith(
      {Value<String>? id,
      Value<double?>? value,
      Value<String>? name,
      Value<BillTypes>? type,
      Value<bool>? defaultType,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return BillTypeCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
      name: name ?? this.name,
      type: type ?? this.type,
      defaultType: defaultType ?? this.defaultType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      final converter = $BillTypeTable.$convertertype;
      map['type'] = Variable<int>(converter.toSql(type.value));
    }
    if (defaultType.present) {
      map['default_type'] = Variable<bool>(defaultType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillTypeCompanion(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('defaultType: $defaultType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillTable extends Bill with TableInfo<$BillTable, BillData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(const Uuid().v4()));
  static const VerificationMeta _tableMeta = const VerificationMeta('table');
  @override
  late final GeneratedColumn<int> table = GeneratedColumn<int>(
      'table', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _customerNameMeta =
      const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
      'customer_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<BillStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<BillStatus>($BillTable.$converterstatus);
  static const VerificationMeta _billTypeIdMeta =
      const VerificationMeta('billTypeId');
  @override
  late final GeneratedColumn<String> billTypeId = GeneratedColumn<String>(
      'bill_type_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bill_type (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, table, customerName, status, billTypeId, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'bill';
  @override
  String get actualTableName => 'bill';
  @override
  VerificationContext validateIntegrity(Insertable<BillData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('table')) {
      context.handle(
          _tableMeta, table.isAcceptableOrUnknown(data['table']!, _tableMeta));
    }
    if (data.containsKey('customer_name')) {
      context.handle(
          _customerNameMeta,
          customerName.isAcceptableOrUnknown(
              data['customer_name']!, _customerNameMeta));
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('bill_type_id')) {
      context.handle(
          _billTypeIdMeta,
          billTypeId.isAcceptableOrUnknown(
              data['bill_type_id']!, _billTypeIdMeta));
    } else if (isInserting) {
      context.missing(_billTypeIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  BillData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      table: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}table']),
      customerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_name']),
      status: $BillTable.$converterstatus.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      billTypeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bill_type_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $BillTable createAlias(String alias) {
    return $BillTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BillStatus, int, int> $converterstatus =
      JsonAwareIntEnumConverter(BillStatus.values);
}

class BillData extends DataClass implements Insertable<BillData> {
  final String id;
  final int? table;
  final String? customerName;
  final BillStatus status;
  final String billTypeId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const BillData(
      {required this.id,
      this.table,
      this.customerName,
      required this.status,
      required this.billTypeId,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || table != null) {
      map['table'] = Variable<int>(table);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    {
      final converter = $BillTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status));
    }
    map['bill_type_id'] = Variable<String>(billTypeId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  BillCompanion toCompanion(bool nullToAbsent) {
    return BillCompanion(
      id: Value(id),
      table:
          table == null && nullToAbsent ? const Value.absent() : Value(table),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      status: Value(status),
      billTypeId: Value(billTypeId),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory BillData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillData(
      id: serializer.fromJson<String>(json['id']),
      table: serializer.fromJson<int?>(json['table']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      status: $BillTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      billTypeId: serializer.fromJson<String>(json['billTypeId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'table': serializer.toJson<int?>(table),
      'customerName': serializer.toJson<String?>(customerName),
      'status':
          serializer.toJson<int>($BillTable.$converterstatus.toJson(status)),
      'billTypeId': serializer.toJson<String>(billTypeId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  BillData copyWith(
          {String? id,
          Value<int?> table = const Value.absent(),
          Value<String?> customerName = const Value.absent(),
          BillStatus? status,
          String? billTypeId,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      BillData(
        id: id ?? this.id,
        table: table.present ? table.value : this.table,
        customerName:
            customerName.present ? customerName.value : this.customerName,
        status: status ?? this.status,
        billTypeId: billTypeId ?? this.billTypeId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('BillData(')
          ..write('id: $id, ')
          ..write('table: $table, ')
          ..write('customerName: $customerName, ')
          ..write('status: $status, ')
          ..write('billTypeId: $billTypeId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, table, customerName, status, billTypeId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillData &&
          other.id == this.id &&
          other.table == this.table &&
          other.customerName == this.customerName &&
          other.status == this.status &&
          other.billTypeId == this.billTypeId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BillCompanion extends UpdateCompanion<BillData> {
  final Value<String> id;
  final Value<int?> table;
  final Value<String?> customerName;
  final Value<BillStatus> status;
  final Value<String> billTypeId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const BillCompanion({
    this.id = const Value.absent(),
    this.table = const Value.absent(),
    this.customerName = const Value.absent(),
    this.status = const Value.absent(),
    this.billTypeId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillCompanion.insert({
    this.id = const Value.absent(),
    this.table = const Value.absent(),
    this.customerName = const Value.absent(),
    required BillStatus status,
    required String billTypeId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : status = Value(status),
        billTypeId = Value(billTypeId);
  static Insertable<BillData> custom({
    Expression<String>? id,
    Expression<int>? table,
    Expression<String>? customerName,
    Expression<int>? status,
    Expression<String>? billTypeId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (table != null) 'table': table,
      if (customerName != null) 'customer_name': customerName,
      if (status != null) 'status': status,
      if (billTypeId != null) 'bill_type_id': billTypeId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillCompanion copyWith(
      {Value<String>? id,
      Value<int?>? table,
      Value<String?>? customerName,
      Value<BillStatus>? status,
      Value<String>? billTypeId,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return BillCompanion(
      id: id ?? this.id,
      table: table ?? this.table,
      customerName: customerName ?? this.customerName,
      status: status ?? this.status,
      billTypeId: billTypeId ?? this.billTypeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (table.present) {
      map['table'] = Variable<int>(table.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (status.present) {
      final converter = $BillTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status.value));
    }
    if (billTypeId.present) {
      map['bill_type_id'] = Variable<String>(billTypeId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillCompanion(')
          ..write('id: $id, ')
          ..write('table: $table, ')
          ..write('customerName: $customerName, ')
          ..write('status: $status, ')
          ..write('billTypeId: $billTypeId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RequestTable extends Request with TableInfo<$RequestTable, RequestData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RequestTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(const Uuid().v4()));
  static const VerificationMeta _observationMeta =
      const VerificationMeta('observation');
  @override
  late final GeneratedColumn<String> observation = GeneratedColumn<String>(
      'observation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
      'bill_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bill (id)'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<RequestStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<RequestStatus>($RequestTable.$converterstatus);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, observation, billId, status, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'request';
  @override
  String get actualTableName => 'request';
  @override
  VerificationContext validateIntegrity(Insertable<RequestData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('observation')) {
      context.handle(
          _observationMeta,
          observation.isAcceptableOrUnknown(
              data['observation']!, _observationMeta));
    }
    if (data.containsKey('bill_id')) {
      context.handle(_billIdMeta,
          billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta));
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  RequestData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RequestData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      observation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observation']),
      billId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bill_id'])!,
      status: $RequestTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $RequestTable createAlias(String alias) {
    return $RequestTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RequestStatus, int, int> $converterstatus =
      JsonAwareIntEnumConverter(RequestStatus.values);
}

class RequestData extends DataClass implements Insertable<RequestData> {
  final String id;
  final String? observation;
  final String billId;
  final RequestStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const RequestData(
      {required this.id,
      this.observation,
      required this.billId,
      required this.status,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || observation != null) {
      map['observation'] = Variable<String>(observation);
    }
    map['bill_id'] = Variable<String>(billId);
    {
      final converter = $RequestTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  RequestCompanion toCompanion(bool nullToAbsent) {
    return RequestCompanion(
      id: Value(id),
      observation: observation == null && nullToAbsent
          ? const Value.absent()
          : Value(observation),
      billId: Value(billId),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory RequestData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RequestData(
      id: serializer.fromJson<String>(json['id']),
      observation: serializer.fromJson<String?>(json['observation']),
      billId: serializer.fromJson<String>(json['billId']),
      status: $RequestTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'observation': serializer.toJson<String?>(observation),
      'billId': serializer.toJson<String>(billId),
      'status':
          serializer.toJson<int>($RequestTable.$converterstatus.toJson(status)),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  RequestData copyWith(
          {String? id,
          Value<String?> observation = const Value.absent(),
          String? billId,
          RequestStatus? status,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      RequestData(
        id: id ?? this.id,
        observation: observation.present ? observation.value : this.observation,
        billId: billId ?? this.billId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RequestData(')
          ..write('id: $id, ')
          ..write('observation: $observation, ')
          ..write('billId: $billId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, observation, billId, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RequestData &&
          other.id == this.id &&
          other.observation == this.observation &&
          other.billId == this.billId &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RequestCompanion extends UpdateCompanion<RequestData> {
  final Value<String> id;
  final Value<String?> observation;
  final Value<String> billId;
  final Value<RequestStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const RequestCompanion({
    this.id = const Value.absent(),
    this.observation = const Value.absent(),
    this.billId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RequestCompanion.insert({
    this.id = const Value.absent(),
    this.observation = const Value.absent(),
    required String billId,
    required RequestStatus status,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : billId = Value(billId),
        status = Value(status);
  static Insertable<RequestData> custom({
    Expression<String>? id,
    Expression<String>? observation,
    Expression<String>? billId,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (observation != null) 'observation': observation,
      if (billId != null) 'bill_id': billId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RequestCompanion copyWith(
      {Value<String>? id,
      Value<String?>? observation,
      Value<String>? billId,
      Value<RequestStatus>? status,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return RequestCompanion(
      id: id ?? this.id,
      observation: observation ?? this.observation,
      billId: billId ?? this.billId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (observation.present) {
      map['observation'] = Variable<String>(observation.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (status.present) {
      final converter = $RequestTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RequestCompanion(')
          ..write('id: $id, ')
          ..write('observation: $observation, ')
          ..write('billId: $billId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemTable extends Item with TableInfo<$ItemTable, ItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(const Uuid().v4()));
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _totalQuantityMeta =
      const VerificationMeta('totalQuantity');
  @override
  late final GeneratedColumn<int> totalQuantity = GeneratedColumn<int>(
      'total_quantity', aliasedName, false,
      generatedAs: GeneratedAs(quantity, false),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<ItemStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ItemStatus>($ItemTable.$converterstatus);
  static const VerificationMeta _variationMeta =
      const VerificationMeta('variation');
  @override
  late final GeneratedColumn<String> variation = GeneratedColumn<String>(
      'variation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES product (id)'));
  static const VerificationMeta _requestIdMeta =
      const VerificationMeta('requestId');
  @override
  late final GeneratedColumn<String> requestId = GeneratedColumn<String>(
      'request_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES request (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        price,
        quantity,
        totalQuantity,
        status,
        variation,
        productId,
        requestId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'item';
  @override
  String get actualTableName => 'item';
  @override
  VerificationContext validateIntegrity(Insertable<ItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('total_quantity')) {
      context.handle(
          _totalQuantityMeta,
          totalQuantity.isAcceptableOrUnknown(
              data['total_quantity']!, _totalQuantityMeta));
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('variation')) {
      context.handle(_variationMeta,
          variation.isAcceptableOrUnknown(data['variation']!, _variationMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('request_id')) {
      context.handle(_requestIdMeta,
          requestId.isAcceptableOrUnknown(data['request_id']!, _requestIdMeta));
    } else if (isInserting) {
      context.missing(_requestIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      totalQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_quantity'])!,
      status: $ItemTable.$converterstatus.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      variation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variation']),
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      requestId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}request_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ItemTable createAlias(String alias) {
    return $ItemTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ItemStatus, int, int> $converterstatus =
      JsonAwareIntEnumConverter(ItemStatus.values);
}

class ItemData extends DataClass implements Insertable<ItemData> {
  final String id;
  final double price;
  final int quantity;
  final int totalQuantity;
  final ItemStatus status;
  final String? variation;
  final String productId;
  final String requestId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const ItemData(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.totalQuantity,
      required this.status,
      this.variation,
      required this.productId,
      required this.requestId,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['price'] = Variable<double>(price);
    map['quantity'] = Variable<int>(quantity);
    {
      final converter = $ItemTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status));
    }
    if (!nullToAbsent || variation != null) {
      map['variation'] = Variable<String>(variation);
    }
    map['product_id'] = Variable<String>(productId);
    map['request_id'] = Variable<String>(requestId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ItemCompanion toCompanion(bool nullToAbsent) {
    return ItemCompanion(
      id: Value(id),
      price: Value(price),
      quantity: Value(quantity),
      status: Value(status),
      variation: variation == null && nullToAbsent
          ? const Value.absent()
          : Value(variation),
      productId: Value(productId),
      requestId: Value(requestId),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemData(
      id: serializer.fromJson<String>(json['id']),
      price: serializer.fromJson<double>(json['price']),
      quantity: serializer.fromJson<int>(json['quantity']),
      totalQuantity: serializer.fromJson<int>(json['totalQuantity']),
      status: $ItemTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      variation: serializer.fromJson<String?>(json['variation']),
      productId: serializer.fromJson<String>(json['productId']),
      requestId: serializer.fromJson<String>(json['requestId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'price': serializer.toJson<double>(price),
      'quantity': serializer.toJson<int>(quantity),
      'totalQuantity': serializer.toJson<int>(totalQuantity),
      'status':
          serializer.toJson<int>($ItemTable.$converterstatus.toJson(status)),
      'variation': serializer.toJson<String?>(variation),
      'productId': serializer.toJson<String>(productId),
      'requestId': serializer.toJson<String>(requestId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ItemData copyWith(
          {String? id,
          double? price,
          int? quantity,
          int? totalQuantity,
          ItemStatus? status,
          Value<String?> variation = const Value.absent(),
          String? productId,
          String? requestId,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ItemData(
        id: id ?? this.id,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        status: status ?? this.status,
        variation: variation.present ? variation.value : this.variation,
        productId: productId ?? this.productId,
        requestId: requestId ?? this.requestId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('ItemData(')
          ..write('id: $id, ')
          ..write('price: $price, ')
          ..write('quantity: $quantity, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('status: $status, ')
          ..write('variation: $variation, ')
          ..write('productId: $productId, ')
          ..write('requestId: $requestId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, price, quantity, totalQuantity, status,
      variation, productId, requestId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemData &&
          other.id == this.id &&
          other.price == this.price &&
          other.quantity == this.quantity &&
          other.totalQuantity == this.totalQuantity &&
          other.status == this.status &&
          other.variation == this.variation &&
          other.productId == this.productId &&
          other.requestId == this.requestId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ItemCompanion extends UpdateCompanion<ItemData> {
  final Value<String> id;
  final Value<double> price;
  final Value<int> quantity;
  final Value<ItemStatus> status;
  final Value<String?> variation;
  final Value<String> productId;
  final Value<String> requestId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const ItemCompanion({
    this.id = const Value.absent(),
    this.price = const Value.absent(),
    this.quantity = const Value.absent(),
    this.status = const Value.absent(),
    this.variation = const Value.absent(),
    this.productId = const Value.absent(),
    this.requestId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemCompanion.insert({
    this.id = const Value.absent(),
    required double price,
    this.quantity = const Value.absent(),
    required ItemStatus status,
    this.variation = const Value.absent(),
    required String productId,
    required String requestId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : price = Value(price),
        status = Value(status),
        productId = Value(productId),
        requestId = Value(requestId);
  static Insertable<ItemData> custom({
    Expression<String>? id,
    Expression<double>? price,
    Expression<int>? quantity,
    Expression<int>? status,
    Expression<String>? variation,
    Expression<String>? productId,
    Expression<String>? requestId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
      if (status != null) 'status': status,
      if (variation != null) 'variation': variation,
      if (productId != null) 'product_id': productId,
      if (requestId != null) 'request_id': requestId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemCompanion copyWith(
      {Value<String>? id,
      Value<double>? price,
      Value<int>? quantity,
      Value<ItemStatus>? status,
      Value<String?>? variation,
      Value<String>? productId,
      Value<String>? requestId,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return ItemCompanion(
      id: id ?? this.id,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      variation: variation ?? this.variation,
      productId: productId ?? this.productId,
      requestId: requestId ?? this.requestId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (status.present) {
      final converter = $ItemTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status.value));
    }
    if (variation.present) {
      map['variation'] = Variable<String>(variation.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (requestId.present) {
      map['request_id'] = Variable<String>(requestId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemCompanion(')
          ..write('id: $id, ')
          ..write('price: $price, ')
          ..write('quantity: $quantity, ')
          ..write('status: $status, ')
          ..write('variation: $variation, ')
          ..write('productId: $productId, ')
          ..write('requestId: $requestId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentTable extends Payment with TableInfo<$PaymentTable, PaymentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(const Uuid().v4()));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  @override
  late final GeneratedColumnWithTypeConverter<PaymentType, int> paymentType =
      GeneratedColumn<int>('payment_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<PaymentType>($PaymentTable.$converterpaymentType);
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
      'bill_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bill (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, value, paymentType, billId, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'payment';
  @override
  String get actualTableName => 'payment';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    context.handle(_paymentTypeMeta, const VerificationResult.success());
    if (data.containsKey('bill_id')) {
      context.handle(_billIdMeta,
          billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta));
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PaymentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      paymentType: $PaymentTable.$converterpaymentType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_type'])!),
      billId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bill_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $PaymentTable createAlias(String alias) {
    return $PaymentTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaymentType, int, int> $converterpaymentType =
      JsonAwareIntEnumConverter(PaymentType.values);
}

class PaymentData extends DataClass implements Insertable<PaymentData> {
  final String id;
  final double value;
  final PaymentType paymentType;
  final String billId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const PaymentData(
      {required this.id,
      required this.value,
      required this.paymentType,
      required this.billId,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['value'] = Variable<double>(value);
    {
      final converter = $PaymentTable.$converterpaymentType;
      map['payment_type'] = Variable<int>(converter.toSql(paymentType));
    }
    map['bill_id'] = Variable<String>(billId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  PaymentCompanion toCompanion(bool nullToAbsent) {
    return PaymentCompanion(
      id: Value(id),
      value: Value(value),
      paymentType: Value(paymentType),
      billId: Value(billId),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory PaymentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentData(
      id: serializer.fromJson<String>(json['id']),
      value: serializer.fromJson<double>(json['value']),
      paymentType: $PaymentTable.$converterpaymentType
          .fromJson(serializer.fromJson<int>(json['paymentType'])),
      billId: serializer.fromJson<String>(json['billId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'value': serializer.toJson<double>(value),
      'paymentType': serializer
          .toJson<int>($PaymentTable.$converterpaymentType.toJson(paymentType)),
      'billId': serializer.toJson<String>(billId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  PaymentData copyWith(
          {String? id,
          double? value,
          PaymentType? paymentType,
          String? billId,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      PaymentData(
        id: id ?? this.id,
        value: value ?? this.value,
        paymentType: paymentType ?? this.paymentType,
        billId: billId ?? this.billId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('PaymentData(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('paymentType: $paymentType, ')
          ..write('billId: $billId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, value, paymentType, billId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentData &&
          other.id == this.id &&
          other.value == this.value &&
          other.paymentType == this.paymentType &&
          other.billId == this.billId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PaymentCompanion extends UpdateCompanion<PaymentData> {
  final Value<String> id;
  final Value<double> value;
  final Value<PaymentType> paymentType;
  final Value<String> billId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const PaymentCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.billId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentCompanion.insert({
    this.id = const Value.absent(),
    required double value,
    required PaymentType paymentType,
    required String billId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : value = Value(value),
        paymentType = Value(paymentType),
        billId = Value(billId);
  static Insertable<PaymentData> custom({
    Expression<String>? id,
    Expression<double>? value,
    Expression<int>? paymentType,
    Expression<String>? billId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
      if (paymentType != null) 'payment_type': paymentType,
      if (billId != null) 'bill_id': billId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentCompanion copyWith(
      {Value<String>? id,
      Value<double>? value,
      Value<PaymentType>? paymentType,
      Value<String>? billId,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return PaymentCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
      paymentType: paymentType ?? this.paymentType,
      billId: billId ?? this.billId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (paymentType.present) {
      final converter = $PaymentTable.$converterpaymentType;
      map['payment_type'] = Variable<int>(converter.toSql(paymentType.value));
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentCompanion(')
          ..write('id: $id, ')
          ..write('value: $value, ')
          ..write('paymentType: $paymentType, ')
          ..write('billId: $billId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EstablishmentSettingsTable extends EstablishmentSettings
    with TableInfo<$EstablishmentSettingsTable, EstablishmentSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EstablishmentSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(const Uuid().v4()));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 6,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _establishmentTypeMeta =
      const VerificationMeta('establishmentType');
  @override
  late final GeneratedColumnWithTypeConverter<EstablishmentTypes, int>
      establishmentType = GeneratedColumn<int>(
              'establishment_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<EstablishmentTypes>(
              $EstablishmentSettingsTable.$converterestablishmentType);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageSrcMeta =
      const VerificationMeta('imageSrc');
  @override
  late final GeneratedColumn<String> imageSrc = GeneratedColumn<String>(
      'image_src', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _enableOrderSheetMeta =
      const VerificationMeta('enableOrderSheet');
  @override
  late final GeneratedColumn<bool> enableOrderSheet =
      GeneratedColumn<bool>('enable_order_sheet', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("enable_order_sheet" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _enableWideViewModeMeta =
      const VerificationMeta('enableWideViewMode');
  @override
  late final GeneratedColumn<bool> enableWideViewMode =
      GeneratedColumn<bool>('enable_wide_view_mode', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("enable_wide_view_mode" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(true));
  static const VerificationMeta _printerEnabledMeta =
      const VerificationMeta('printerEnabled');
  @override
  late final GeneratedColumn<bool> printerEnabled =
      GeneratedColumn<bool>('printer_enabled', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("printer_enabled" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(true));
  static const VerificationMeta _printerIpMeta =
      const VerificationMeta('printerIp');
  @override
  late final GeneratedColumn<String> printerIp = GeneratedColumn<String>(
      'printer_ip', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _printerPortMeta =
      const VerificationMeta('printerPort');
  @override
  late final GeneratedColumn<int> printerPort = GeneratedColumn<int>(
      'printer_port', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(9100));
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumnWithTypeConverter<ThemesOptions, int> theme =
      GeneratedColumn<int>('theme', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ThemesOptions>(
              $EstablishmentSettingsTable.$convertertheme);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        establishmentType,
        description,
        address,
        imageSrc,
        enableOrderSheet,
        enableWideViewMode,
        printerEnabled,
        printerIp,
        printerPort,
        theme,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'establishment_settings';
  @override
  String get actualTableName => 'establishment_settings';
  @override
  VerificationContext validateIntegrity(
      Insertable<EstablishmentSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_establishmentTypeMeta, const VerificationResult.success());
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('image_src')) {
      context.handle(_imageSrcMeta,
          imageSrc.isAcceptableOrUnknown(data['image_src']!, _imageSrcMeta));
    }
    if (data.containsKey('enable_order_sheet')) {
      context.handle(
          _enableOrderSheetMeta,
          enableOrderSheet.isAcceptableOrUnknown(
              data['enable_order_sheet']!, _enableOrderSheetMeta));
    }
    if (data.containsKey('enable_wide_view_mode')) {
      context.handle(
          _enableWideViewModeMeta,
          enableWideViewMode.isAcceptableOrUnknown(
              data['enable_wide_view_mode']!, _enableWideViewModeMeta));
    }
    if (data.containsKey('printer_enabled')) {
      context.handle(
          _printerEnabledMeta,
          printerEnabled.isAcceptableOrUnknown(
              data['printer_enabled']!, _printerEnabledMeta));
    }
    if (data.containsKey('printer_ip')) {
      context.handle(_printerIpMeta,
          printerIp.isAcceptableOrUnknown(data['printer_ip']!, _printerIpMeta));
    }
    if (data.containsKey('printer_port')) {
      context.handle(
          _printerPortMeta,
          printerPort.isAcceptableOrUnknown(
              data['printer_port']!, _printerPortMeta));
    }
    context.handle(_themeMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  EstablishmentSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EstablishmentSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      establishmentType: $EstablishmentSettingsTable.$converterestablishmentType
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}establishment_type'])!),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      imageSrc: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_src']),
      enableOrderSheet: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}enable_order_sheet'])!,
      enableWideViewMode: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}enable_wide_view_mode'])!,
      printerEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}printer_enabled'])!,
      printerIp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}printer_ip']),
      printerPort: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}printer_port']),
      theme: $EstablishmentSettingsTable.$convertertheme.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}theme'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $EstablishmentSettingsTable createAlias(String alias) {
    return $EstablishmentSettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EstablishmentTypes, int, int>
      $converterestablishmentType =
      JsonAwareIntEnumConverter(EstablishmentTypes.values);
  static JsonTypeConverter2<ThemesOptions, int, int> $convertertheme =
      JsonAwareIntEnumConverter(ThemesOptions.values);
}

class EstablishmentSetting extends DataClass
    implements Insertable<EstablishmentSetting> {
  final String id;
  final String name;
  final EstablishmentTypes establishmentType;
  final String? description;
  final String? address;
  final String? imageSrc;
  final bool enableOrderSheet;
  final bool enableWideViewMode;
  final bool printerEnabled;
  final String? printerIp;
  final int? printerPort;
  final ThemesOptions theme;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const EstablishmentSetting(
      {required this.id,
      required this.name,
      required this.establishmentType,
      this.description,
      this.address,
      this.imageSrc,
      required this.enableOrderSheet,
      required this.enableWideViewMode,
      required this.printerEnabled,
      this.printerIp,
      this.printerPort,
      required this.theme,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      final converter = $EstablishmentSettingsTable.$converterestablishmentType;
      map['establishment_type'] =
          Variable<int>(converter.toSql(establishmentType));
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || imageSrc != null) {
      map['image_src'] = Variable<String>(imageSrc);
    }
    map['enable_order_sheet'] = Variable<bool>(enableOrderSheet);
    map['enable_wide_view_mode'] = Variable<bool>(enableWideViewMode);
    map['printer_enabled'] = Variable<bool>(printerEnabled);
    if (!nullToAbsent || printerIp != null) {
      map['printer_ip'] = Variable<String>(printerIp);
    }
    if (!nullToAbsent || printerPort != null) {
      map['printer_port'] = Variable<int>(printerPort);
    }
    {
      final converter = $EstablishmentSettingsTable.$convertertheme;
      map['theme'] = Variable<int>(converter.toSql(theme));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  EstablishmentSettingsCompanion toCompanion(bool nullToAbsent) {
    return EstablishmentSettingsCompanion(
      id: Value(id),
      name: Value(name),
      establishmentType: Value(establishmentType),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      imageSrc: imageSrc == null && nullToAbsent
          ? const Value.absent()
          : Value(imageSrc),
      enableOrderSheet: Value(enableOrderSheet),
      enableWideViewMode: Value(enableWideViewMode),
      printerEnabled: Value(printerEnabled),
      printerIp: printerIp == null && nullToAbsent
          ? const Value.absent()
          : Value(printerIp),
      printerPort: printerPort == null && nullToAbsent
          ? const Value.absent()
          : Value(printerPort),
      theme: Value(theme),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory EstablishmentSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EstablishmentSetting(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      establishmentType: $EstablishmentSettingsTable.$converterestablishmentType
          .fromJson(serializer.fromJson<int>(json['establishmentType'])),
      description: serializer.fromJson<String?>(json['description']),
      address: serializer.fromJson<String?>(json['address']),
      imageSrc: serializer.fromJson<String?>(json['imageSrc']),
      enableOrderSheet: serializer.fromJson<bool>(json['enableOrderSheet']),
      enableWideViewMode: serializer.fromJson<bool>(json['enableWideViewMode']),
      printerEnabled: serializer.fromJson<bool>(json['printerEnabled']),
      printerIp: serializer.fromJson<String?>(json['printerIp']),
      printerPort: serializer.fromJson<int?>(json['printerPort']),
      theme: $EstablishmentSettingsTable.$convertertheme
          .fromJson(serializer.fromJson<int>(json['theme'])),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'establishmentType': serializer.toJson<int>($EstablishmentSettingsTable
          .$converterestablishmentType
          .toJson(establishmentType)),
      'description': serializer.toJson<String?>(description),
      'address': serializer.toJson<String?>(address),
      'imageSrc': serializer.toJson<String?>(imageSrc),
      'enableOrderSheet': serializer.toJson<bool>(enableOrderSheet),
      'enableWideViewMode': serializer.toJson<bool>(enableWideViewMode),
      'printerEnabled': serializer.toJson<bool>(printerEnabled),
      'printerIp': serializer.toJson<String?>(printerIp),
      'printerPort': serializer.toJson<int?>(printerPort),
      'theme': serializer.toJson<int>(
          $EstablishmentSettingsTable.$convertertheme.toJson(theme)),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  EstablishmentSetting copyWith(
          {String? id,
          String? name,
          EstablishmentTypes? establishmentType,
          Value<String?> description = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> imageSrc = const Value.absent(),
          bool? enableOrderSheet,
          bool? enableWideViewMode,
          bool? printerEnabled,
          Value<String?> printerIp = const Value.absent(),
          Value<int?> printerPort = const Value.absent(),
          ThemesOptions? theme,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      EstablishmentSetting(
        id: id ?? this.id,
        name: name ?? this.name,
        establishmentType: establishmentType ?? this.establishmentType,
        description: description.present ? description.value : this.description,
        address: address.present ? address.value : this.address,
        imageSrc: imageSrc.present ? imageSrc.value : this.imageSrc,
        enableOrderSheet: enableOrderSheet ?? this.enableOrderSheet,
        enableWideViewMode: enableWideViewMode ?? this.enableWideViewMode,
        printerEnabled: printerEnabled ?? this.printerEnabled,
        printerIp: printerIp.present ? printerIp.value : this.printerIp,
        printerPort: printerPort.present ? printerPort.value : this.printerPort,
        theme: theme ?? this.theme,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('EstablishmentSetting(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('establishmentType: $establishmentType, ')
          ..write('description: $description, ')
          ..write('address: $address, ')
          ..write('imageSrc: $imageSrc, ')
          ..write('enableOrderSheet: $enableOrderSheet, ')
          ..write('enableWideViewMode: $enableWideViewMode, ')
          ..write('printerEnabled: $printerEnabled, ')
          ..write('printerIp: $printerIp, ')
          ..write('printerPort: $printerPort, ')
          ..write('theme: $theme, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      establishmentType,
      description,
      address,
      imageSrc,
      enableOrderSheet,
      enableWideViewMode,
      printerEnabled,
      printerIp,
      printerPort,
      theme,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EstablishmentSetting &&
          other.id == this.id &&
          other.name == this.name &&
          other.establishmentType == this.establishmentType &&
          other.description == this.description &&
          other.address == this.address &&
          other.imageSrc == this.imageSrc &&
          other.enableOrderSheet == this.enableOrderSheet &&
          other.enableWideViewMode == this.enableWideViewMode &&
          other.printerEnabled == this.printerEnabled &&
          other.printerIp == this.printerIp &&
          other.printerPort == this.printerPort &&
          other.theme == this.theme &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EstablishmentSettingsCompanion
    extends UpdateCompanion<EstablishmentSetting> {
  final Value<String> id;
  final Value<String> name;
  final Value<EstablishmentTypes> establishmentType;
  final Value<String?> description;
  final Value<String?> address;
  final Value<String?> imageSrc;
  final Value<bool> enableOrderSheet;
  final Value<bool> enableWideViewMode;
  final Value<bool> printerEnabled;
  final Value<String?> printerIp;
  final Value<int?> printerPort;
  final Value<ThemesOptions> theme;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const EstablishmentSettingsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.establishmentType = const Value.absent(),
    this.description = const Value.absent(),
    this.address = const Value.absent(),
    this.imageSrc = const Value.absent(),
    this.enableOrderSheet = const Value.absent(),
    this.enableWideViewMode = const Value.absent(),
    this.printerEnabled = const Value.absent(),
    this.printerIp = const Value.absent(),
    this.printerPort = const Value.absent(),
    this.theme = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EstablishmentSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required EstablishmentTypes establishmentType,
    this.description = const Value.absent(),
    this.address = const Value.absent(),
    this.imageSrc = const Value.absent(),
    this.enableOrderSheet = const Value.absent(),
    this.enableWideViewMode = const Value.absent(),
    this.printerEnabled = const Value.absent(),
    this.printerIp = const Value.absent(),
    this.printerPort = const Value.absent(),
    required ThemesOptions theme,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        establishmentType = Value(establishmentType),
        theme = Value(theme);
  static Insertable<EstablishmentSetting> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? establishmentType,
    Expression<String>? description,
    Expression<String>? address,
    Expression<String>? imageSrc,
    Expression<bool>? enableOrderSheet,
    Expression<bool>? enableWideViewMode,
    Expression<bool>? printerEnabled,
    Expression<String>? printerIp,
    Expression<int>? printerPort,
    Expression<int>? theme,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (establishmentType != null) 'establishment_type': establishmentType,
      if (description != null) 'description': description,
      if (address != null) 'address': address,
      if (imageSrc != null) 'image_src': imageSrc,
      if (enableOrderSheet != null) 'enable_order_sheet': enableOrderSheet,
      if (enableWideViewMode != null)
        'enable_wide_view_mode': enableWideViewMode,
      if (printerEnabled != null) 'printer_enabled': printerEnabled,
      if (printerIp != null) 'printer_ip': printerIp,
      if (printerPort != null) 'printer_port': printerPort,
      if (theme != null) 'theme': theme,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EstablishmentSettingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<EstablishmentTypes>? establishmentType,
      Value<String?>? description,
      Value<String?>? address,
      Value<String?>? imageSrc,
      Value<bool>? enableOrderSheet,
      Value<bool>? enableWideViewMode,
      Value<bool>? printerEnabled,
      Value<String?>? printerIp,
      Value<int?>? printerPort,
      Value<ThemesOptions>? theme,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return EstablishmentSettingsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      establishmentType: establishmentType ?? this.establishmentType,
      description: description ?? this.description,
      address: address ?? this.address,
      imageSrc: imageSrc ?? this.imageSrc,
      enableOrderSheet: enableOrderSheet ?? this.enableOrderSheet,
      enableWideViewMode: enableWideViewMode ?? this.enableWideViewMode,
      printerEnabled: printerEnabled ?? this.printerEnabled,
      printerIp: printerIp ?? this.printerIp,
      printerPort: printerPort ?? this.printerPort,
      theme: theme ?? this.theme,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (establishmentType.present) {
      final converter = $EstablishmentSettingsTable.$converterestablishmentType;
      map['establishment_type'] =
          Variable<int>(converter.toSql(establishmentType.value));
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (imageSrc.present) {
      map['image_src'] = Variable<String>(imageSrc.value);
    }
    if (enableOrderSheet.present) {
      map['enable_order_sheet'] = Variable<bool>(enableOrderSheet.value);
    }
    if (enableWideViewMode.present) {
      map['enable_wide_view_mode'] = Variable<bool>(enableWideViewMode.value);
    }
    if (printerEnabled.present) {
      map['printer_enabled'] = Variable<bool>(printerEnabled.value);
    }
    if (printerIp.present) {
      map['printer_ip'] = Variable<String>(printerIp.value);
    }
    if (printerPort.present) {
      map['printer_port'] = Variable<int>(printerPort.value);
    }
    if (theme.present) {
      final converter = $EstablishmentSettingsTable.$convertertheme;
      map['theme'] = Variable<int>(converter.toSql(theme.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EstablishmentSettingsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('establishmentType: $establishmentType, ')
          ..write('description: $description, ')
          ..write('address: $address, ')
          ..write('imageSrc: $imageSrc, ')
          ..write('enableOrderSheet: $enableOrderSheet, ')
          ..write('enableWideViewMode: $enableWideViewMode, ')
          ..write('printerEnabled: $printerEnabled, ')
          ..write('printerIp: $printerIp, ')
          ..write('printerPort: $printerPort, ')
          ..write('theme: $theme, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $CategoryTable category = $CategoryTable(this);
  late final $ProductTable product = $ProductTable(this);
  late final $BillTypeTable billType = $BillTypeTable(this);
  late final $BillTable bill = $BillTable(this);
  late final $RequestTable request = $RequestTable(this);
  late final $ItemTable item = $ItemTable(this);
  late final $PaymentTable payment = $PaymentTable(this);
  late final $EstablishmentSettingsTable establishmentSettings =
      $EstablishmentSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        category,
        product,
        billType,
        bill,
        request,
        item,
        payment,
        establishmentSettings
      ];
}
