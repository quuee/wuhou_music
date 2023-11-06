// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sl_songs_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSLSongsEntityCollection on Isar {
  IsarCollection<SLSongsEntity> get sLSongsEntitys => this.collection();
}

const SLSongsEntitySchema = CollectionSchema(
  name: r'SLSongsEntity',
  id: 6958730504031419610,
  properties: {
    r'apslid': PropertySchema(
      id: 0,
      name: r'apslid',
      type: IsarType.long,
    ),
    r'sid': PropertySchema(
      id: 1,
      name: r'sid',
      type: IsarType.long,
    )
  },
  estimateSize: _sLSongsEntityEstimateSize,
  serialize: _sLSongsEntitySerialize,
  deserialize: _sLSongsEntityDeserialize,
  deserializeProp: _sLSongsEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _sLSongsEntityGetId,
  getLinks: _sLSongsEntityGetLinks,
  attach: _sLSongsEntityAttach,
  version: '3.1.0+1',
);

int _sLSongsEntityEstimateSize(
  SLSongsEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _sLSongsEntitySerialize(
  SLSongsEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.apslid);
  writer.writeLong(offsets[1], object.sid);
}

SLSongsEntity _sLSongsEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SLSongsEntity(
    apslid: reader.readLongOrNull(offsets[0]),
    id: id,
    sid: reader.readLongOrNull(offsets[1]),
  );
  return object;
}

P _sLSongsEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sLSongsEntityGetId(SLSongsEntity object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _sLSongsEntityGetLinks(SLSongsEntity object) {
  return [];
}

void _sLSongsEntityAttach(
    IsarCollection<dynamic> col, Id id, SLSongsEntity object) {
  object.id = id;
}

extension SLSongsEntityQueryWhereSort
    on QueryBuilder<SLSongsEntity, SLSongsEntity, QWhere> {
  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SLSongsEntityQueryWhere
    on QueryBuilder<SLSongsEntity, SLSongsEntity, QWhereClause> {
  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterWhereClause> idBetween(
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

extension SLSongsEntityQueryFilter
    on QueryBuilder<SLSongsEntity, SLSongsEntity, QFilterCondition> {
  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      apslidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'apslid',
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      apslidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'apslid',
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      apslidEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apslid',
        value: value,
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      apslidGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'apslid',
        value: value,
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      apslidLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'apslid',
        value: value,
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      apslidBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'apslid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      sidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sid',
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      sidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sid',
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition> sidEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sid',
        value: value,
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition>
      sidGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sid',
        value: value,
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition> sidLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sid',
        value: value,
      ));
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterFilterCondition> sidBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SLSongsEntityQueryObject
    on QueryBuilder<SLSongsEntity, SLSongsEntity, QFilterCondition> {}

extension SLSongsEntityQueryLinks
    on QueryBuilder<SLSongsEntity, SLSongsEntity, QFilterCondition> {}

extension SLSongsEntityQuerySortBy
    on QueryBuilder<SLSongsEntity, SLSongsEntity, QSortBy> {
  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterSortBy> sortByApslid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apslid', Sort.asc);
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterSortBy> sortByApslidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apslid', Sort.desc);
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterSortBy> sortBySid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sid', Sort.asc);
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterSortBy> sortBySidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sid', Sort.desc);
    });
  }
}

extension SLSongsEntityQuerySortThenBy
    on QueryBuilder<SLSongsEntity, SLSongsEntity, QSortThenBy> {
  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterSortBy> thenByApslid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apslid', Sort.asc);
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterSortBy> thenByApslidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apslid', Sort.desc);
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterSortBy> thenBySid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sid', Sort.asc);
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QAfterSortBy> thenBySidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sid', Sort.desc);
    });
  }
}

extension SLSongsEntityQueryWhereDistinct
    on QueryBuilder<SLSongsEntity, SLSongsEntity, QDistinct> {
  QueryBuilder<SLSongsEntity, SLSongsEntity, QDistinct> distinctByApslid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apslid');
    });
  }

  QueryBuilder<SLSongsEntity, SLSongsEntity, QDistinct> distinctBySid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sid');
    });
  }
}

extension SLSongsEntityQueryProperty
    on QueryBuilder<SLSongsEntity, SLSongsEntity, QQueryProperty> {
  QueryBuilder<SLSongsEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SLSongsEntity, int?, QQueryOperations> apslidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apslid');
    });
  }

  QueryBuilder<SLSongsEntity, int?, QQueryOperations> sidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sid');
    });
  }
}
