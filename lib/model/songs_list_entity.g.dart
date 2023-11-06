// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_list_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSongsListEntityCollection on Isar {
  IsarCollection<SongsListEntity> get songsListEntitys => this.collection();
}

const SongsListEntitySchema = CollectionSchema(
  name: r'songs_list',
  id: -3814521649370126682,
  properties: {
    r'count': PropertySchema(
      id: 0,
      name: r'count',
      type: IsarType.long,
    ),
    r'listAlbum': PropertySchema(
      id: 1,
      name: r'listAlbum',
      type: IsarType.string,
    ),
    r'listTitle': PropertySchema(
      id: 2,
      name: r'listTitle',
      type: IsarType.string,
    ),
    r'slid': PropertySchema(
      id: 3,
      name: r'slid',
      type: IsarType.string,
    )
  },
  estimateSize: _songsListEntityEstimateSize,
  serialize: _songsListEntitySerialize,
  deserialize: _songsListEntityDeserialize,
  deserializeProp: _songsListEntityDeserializeProp,
  idName: r'apslid',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _songsListEntityGetId,
  getLinks: _songsListEntityGetLinks,
  attach: _songsListEntityAttach,
  version: '3.1.0+1',
);

int _songsListEntityEstimateSize(
  SongsListEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.listAlbum;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.listTitle.length * 3;
  {
    final value = object.slid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _songsListEntitySerialize(
  SongsListEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.count);
  writer.writeString(offsets[1], object.listAlbum);
  writer.writeString(offsets[2], object.listTitle);
  writer.writeString(offsets[3], object.slid);
}

SongsListEntity _songsListEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SongsListEntity(
    apslid: id,
    count: reader.readLongOrNull(offsets[0]),
    listAlbum: reader.readStringOrNull(offsets[1]),
    listTitle: reader.readString(offsets[2]),
    slid: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _songsListEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _songsListEntityGetId(SongsListEntity object) {
  return object.apslid ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _songsListEntityGetLinks(SongsListEntity object) {
  return [];
}

void _songsListEntityAttach(
    IsarCollection<dynamic> col, Id id, SongsListEntity object) {
  object.apslid = id;
}

extension SongsListEntityQueryWhereSort
    on QueryBuilder<SongsListEntity, SongsListEntity, QWhere> {
  QueryBuilder<SongsListEntity, SongsListEntity, QAfterWhere> anyApslid() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SongsListEntityQueryWhere
    on QueryBuilder<SongsListEntity, SongsListEntity, QWhereClause> {
  QueryBuilder<SongsListEntity, SongsListEntity, QAfterWhereClause>
      apslidEqualTo(Id apslid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: apslid,
        upper: apslid,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterWhereClause>
      apslidNotEqualTo(Id apslid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: apslid, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: apslid, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: apslid, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: apslid, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterWhereClause>
      apslidGreaterThan(Id apslid, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: apslid, includeLower: include),
      );
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterWhereClause>
      apslidLessThan(Id apslid, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: apslid, includeUpper: include),
      );
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterWhereClause>
      apslidBetween(
    Id lowerApslid,
    Id upperApslid, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerApslid,
        includeLower: includeLower,
        upper: upperApslid,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SongsListEntityQueryFilter
    on QueryBuilder<SongsListEntity, SongsListEntity, QFilterCondition> {
  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      apslidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'apslid',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      apslidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'apslid',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      apslidEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apslid',
        value: value,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      apslidGreaterThan(
    Id? value, {
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

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      apslidLessThan(
    Id? value, {
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

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      apslidBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      countIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'count',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      countIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'count',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      countEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      countGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      countLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      countBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'count',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'listAlbum',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'listAlbum',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listAlbum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'listAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'listAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'listAlbum',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'listAlbum',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listAlbum',
        value: '',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listAlbumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'listAlbum',
        value: '',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'listTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'listTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'listTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'listTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      listTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'listTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'slid',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'slid',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'slid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'slid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'slid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'slid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'slid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'slid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'slid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'slid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'slid',
        value: '',
      ));
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterFilterCondition>
      slidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'slid',
        value: '',
      ));
    });
  }
}

extension SongsListEntityQueryObject
    on QueryBuilder<SongsListEntity, SongsListEntity, QFilterCondition> {}

extension SongsListEntityQueryLinks
    on QueryBuilder<SongsListEntity, SongsListEntity, QFilterCondition> {}

extension SongsListEntityQuerySortBy
    on QueryBuilder<SongsListEntity, SongsListEntity, QSortBy> {
  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy> sortByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.asc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      sortByCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.desc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      sortByListAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listAlbum', Sort.asc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      sortByListAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listAlbum', Sort.desc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      sortByListTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listTitle', Sort.asc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      sortByListTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listTitle', Sort.desc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy> sortBySlid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slid', Sort.asc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      sortBySlidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slid', Sort.desc);
    });
  }
}

extension SongsListEntityQuerySortThenBy
    on QueryBuilder<SongsListEntity, SongsListEntity, QSortThenBy> {
  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy> thenByApslid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apslid', Sort.asc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      thenByApslidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apslid', Sort.desc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy> thenByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.asc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      thenByCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.desc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      thenByListAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listAlbum', Sort.asc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      thenByListAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listAlbum', Sort.desc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      thenByListTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listTitle', Sort.asc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      thenByListTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listTitle', Sort.desc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy> thenBySlid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slid', Sort.asc);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QAfterSortBy>
      thenBySlidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slid', Sort.desc);
    });
  }
}

extension SongsListEntityQueryWhereDistinct
    on QueryBuilder<SongsListEntity, SongsListEntity, QDistinct> {
  QueryBuilder<SongsListEntity, SongsListEntity, QDistinct> distinctByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'count');
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QDistinct> distinctByListAlbum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listAlbum', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QDistinct> distinctByListTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SongsListEntity, SongsListEntity, QDistinct> distinctBySlid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slid', caseSensitive: caseSensitive);
    });
  }
}

extension SongsListEntityQueryProperty
    on QueryBuilder<SongsListEntity, SongsListEntity, QQueryProperty> {
  QueryBuilder<SongsListEntity, int, QQueryOperations> apslidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apslid');
    });
  }

  QueryBuilder<SongsListEntity, int?, QQueryOperations> countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'count');
    });
  }

  QueryBuilder<SongsListEntity, String?, QQueryOperations> listAlbumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listAlbum');
    });
  }

  QueryBuilder<SongsListEntity, String, QQueryOperations> listTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listTitle');
    });
  }

  QueryBuilder<SongsListEntity, String?, QQueryOperations> slidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slid');
    });
  }
}
