// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'any_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnyEntityCollection on Isar {
  IsarCollection<AnyEntity> get anyEntitys => this.collection();
}

const AnyEntitySchema = CollectionSchema(
  name: r'AnyEntity',
  id: -1059155840778019463,
  properties: {
    r'anything': PropertySchema(
      id: 0,
      name: r'anything',
      type: IsarType.string,
    ),
    r'keyName': PropertySchema(
      id: 1,
      name: r'keyName',
      type: IsarType.string,
    )
  },
  estimateSize: _anyEntityEstimateSize,
  serialize: _anyEntitySerialize,
  deserialize: _anyEntityDeserialize,
  deserializeProp: _anyEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _anyEntityGetId,
  getLinks: _anyEntityGetLinks,
  attach: _anyEntityAttach,
  version: '3.1.0+1',
);

int _anyEntityEstimateSize(
  AnyEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.anything.length * 3;
  bytesCount += 3 + object.keyName.length * 3;
  return bytesCount;
}

void _anyEntitySerialize(
  AnyEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.anything);
  writer.writeString(offsets[1], object.keyName);
}

AnyEntity _anyEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnyEntity(
    anything: reader.readString(offsets[0]),
    id: id,
    keyName: reader.readString(offsets[1]),
  );
  return object;
}

P _anyEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _anyEntityGetId(AnyEntity object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _anyEntityGetLinks(AnyEntity object) {
  return [];
}

void _anyEntityAttach(IsarCollection<dynamic> col, Id id, AnyEntity object) {
  object.id = id;
}

extension AnyEntityQueryWhereSort
    on QueryBuilder<AnyEntity, AnyEntity, QWhere> {
  QueryBuilder<AnyEntity, AnyEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnyEntityQueryWhere
    on QueryBuilder<AnyEntity, AnyEntity, QWhereClause> {
  QueryBuilder<AnyEntity, AnyEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AnyEntityQueryFilter
    on QueryBuilder<AnyEntity, AnyEntity, QFilterCondition> {
  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> anythingEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'anything',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> anythingGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'anything',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> anythingLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'anything',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> anythingBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'anything',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> anythingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'anything',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> anythingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'anything',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> anythingContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'anything',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> anythingMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'anything',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> anythingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'anything',
        value: '',
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition>
      anythingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'anything',
        value: '',
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> keyNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> keyNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> keyNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> keyNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keyName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> keyNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> keyNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> keyNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'keyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> keyNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'keyName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition> keyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyName',
        value: '',
      ));
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterFilterCondition>
      keyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'keyName',
        value: '',
      ));
    });
  }
}

extension AnyEntityQueryObject
    on QueryBuilder<AnyEntity, AnyEntity, QFilterCondition> {}

extension AnyEntityQueryLinks
    on QueryBuilder<AnyEntity, AnyEntity, QFilterCondition> {}

extension AnyEntityQuerySortBy on QueryBuilder<AnyEntity, AnyEntity, QSortBy> {
  QueryBuilder<AnyEntity, AnyEntity, QAfterSortBy> sortByAnything() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anything', Sort.asc);
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterSortBy> sortByAnythingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anything', Sort.desc);
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterSortBy> sortByKeyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keyName', Sort.asc);
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterSortBy> sortByKeyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keyName', Sort.desc);
    });
  }
}

extension AnyEntityQuerySortThenBy
    on QueryBuilder<AnyEntity, AnyEntity, QSortThenBy> {
  QueryBuilder<AnyEntity, AnyEntity, QAfterSortBy> thenByAnything() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anything', Sort.asc);
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterSortBy> thenByAnythingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anything', Sort.desc);
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterSortBy> thenByKeyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keyName', Sort.asc);
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QAfterSortBy> thenByKeyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keyName', Sort.desc);
    });
  }
}

extension AnyEntityQueryWhereDistinct
    on QueryBuilder<AnyEntity, AnyEntity, QDistinct> {
  QueryBuilder<AnyEntity, AnyEntity, QDistinct> distinctByAnything(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'anything', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnyEntity, AnyEntity, QDistinct> distinctByKeyName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'keyName', caseSensitive: caseSensitive);
    });
  }
}

extension AnyEntityQueryProperty
    on QueryBuilder<AnyEntity, AnyEntity, QQueryProperty> {
  QueryBuilder<AnyEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnyEntity, String, QQueryOperations> anythingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'anything');
    });
  }

  QueryBuilder<AnyEntity, String, QQueryOperations> keyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'keyName');
    });
  }
}
