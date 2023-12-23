// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_config_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReadConfigEntityCollection on Isar {
  IsarCollection<ReadConfigEntity> get readConfigEntitys => this.collection();
}

const ReadConfigEntitySchema = CollectionSchema(
  name: r'read_config',
  id: 6575219253580425829,
  properties: {
    r'background': PropertySchema(
      id: 0,
      name: r'background',
      type: IsarType.string,
    ),
    r'fontColor': PropertySchema(
      id: 1,
      name: r'fontColor',
      type: IsarType.long,
    ),
    r'fontHeight': PropertySchema(
      id: 2,
      name: r'fontHeight',
      type: IsarType.double,
    ),
    r'fontSize': PropertySchema(
      id: 3,
      name: r'fontSize',
      type: IsarType.double,
    )
  },
  estimateSize: _readConfigEntityEstimateSize,
  serialize: _readConfigEntitySerialize,
  deserialize: _readConfigEntityDeserialize,
  deserializeProp: _readConfigEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _readConfigEntityGetId,
  getLinks: _readConfigEntityGetLinks,
  attach: _readConfigEntityAttach,
  version: '3.1.0+1',
);

int _readConfigEntityEstimateSize(
  ReadConfigEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.background.length * 3;
  return bytesCount;
}

void _readConfigEntitySerialize(
  ReadConfigEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.background);
  writer.writeLong(offsets[1], object.fontColor);
  writer.writeDouble(offsets[2], object.fontHeight);
  writer.writeDouble(offsets[3], object.fontSize);
}

ReadConfigEntity _readConfigEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReadConfigEntity(
    background: reader.readString(offsets[0]),
    fontColor: reader.readLong(offsets[1]),
    fontHeight: reader.readDouble(offsets[2]),
    fontSize: reader.readDouble(offsets[3]),
  );
  return object;
}

P _readConfigEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _readConfigEntityGetId(ReadConfigEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _readConfigEntityGetLinks(ReadConfigEntity object) {
  return [];
}

void _readConfigEntityAttach(
    IsarCollection<dynamic> col, Id id, ReadConfigEntity object) {}

extension ReadConfigEntityQueryWhereSort
    on QueryBuilder<ReadConfigEntity, ReadConfigEntity, QWhere> {
  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReadConfigEntityQueryWhere
    on QueryBuilder<ReadConfigEntity, ReadConfigEntity, QWhereClause> {
  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterWhereClause> idBetween(
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

extension ReadConfigEntityQueryFilter
    on QueryBuilder<ReadConfigEntity, ReadConfigEntity, QFilterCondition> {
  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      backgroundEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      backgroundGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      backgroundLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      backgroundBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'background',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      backgroundStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      backgroundEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      backgroundContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'background',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      backgroundMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'background',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      backgroundIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'background',
        value: '',
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      backgroundIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'background',
        value: '',
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontColorEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontColorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fontColor',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fontColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontHeightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fontHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontHeightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fontHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontHeightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fontHeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontHeightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fontHeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontSizeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fontSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontSizeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fontSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontSizeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fontSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      fontSizeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fontSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
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

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      idLessThan(
    Id value, {
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

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
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
}

extension ReadConfigEntityQueryObject
    on QueryBuilder<ReadConfigEntity, ReadConfigEntity, QFilterCondition> {}

extension ReadConfigEntityQueryLinks
    on QueryBuilder<ReadConfigEntity, ReadConfigEntity, QFilterCondition> {}

extension ReadConfigEntityQuerySortBy
    on QueryBuilder<ReadConfigEntity, ReadConfigEntity, QSortBy> {
  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      sortByBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'background', Sort.asc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      sortByBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'background', Sort.desc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      sortByFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontColor', Sort.asc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      sortByFontColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontColor', Sort.desc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      sortByFontHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontHeight', Sort.asc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      sortByFontHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontHeight', Sort.desc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      sortByFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.asc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      sortByFontSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.desc);
    });
  }
}

extension ReadConfigEntityQuerySortThenBy
    on QueryBuilder<ReadConfigEntity, ReadConfigEntity, QSortThenBy> {
  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      thenByBackground() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'background', Sort.asc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      thenByBackgroundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'background', Sort.desc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      thenByFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontColor', Sort.asc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      thenByFontColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontColor', Sort.desc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      thenByFontHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontHeight', Sort.asc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      thenByFontHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontHeight', Sort.desc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      thenByFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.asc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      thenByFontSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fontSize', Sort.desc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ReadConfigEntityQueryWhereDistinct
    on QueryBuilder<ReadConfigEntity, ReadConfigEntity, QDistinct> {
  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QDistinct>
      distinctByBackground({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'background', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QDistinct>
      distinctByFontColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fontColor');
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QDistinct>
      distinctByFontHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fontHeight');
    });
  }

  QueryBuilder<ReadConfigEntity, ReadConfigEntity, QDistinct>
      distinctByFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fontSize');
    });
  }
}

extension ReadConfigEntityQueryProperty
    on QueryBuilder<ReadConfigEntity, ReadConfigEntity, QQueryProperty> {
  QueryBuilder<ReadConfigEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ReadConfigEntity, String, QQueryOperations>
      backgroundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'background');
    });
  }

  QueryBuilder<ReadConfigEntity, int, QQueryOperations> fontColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fontColor');
    });
  }

  QueryBuilder<ReadConfigEntity, double, QQueryOperations>
      fontHeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fontHeight');
    });
  }

  QueryBuilder<ReadConfigEntity, double, QQueryOperations> fontSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fontSize');
    });
  }
}
