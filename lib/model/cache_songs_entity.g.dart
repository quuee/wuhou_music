// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_songs_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCacheSongEntityCollection on Isar {
  IsarCollection<CacheSongEntity> get cacheSongEntitys => this.collection();
}

const CacheSongEntitySchema = CollectionSchema(
  name: r'CacheSongEntity',
  id: -3239792833030045118,
  properties: {
    r'album': PropertySchema(
      id: 0,
      name: r'album',
      type: IsarType.string,
    ),
    r'albumArt': PropertySchema(
      id: 1,
      name: r'albumArt',
      type: IsarType.string,
    ),
    r'albumId': PropertySchema(
      id: 2,
      name: r'albumId',
      type: IsarType.long,
    ),
    r'artist': PropertySchema(
      id: 3,
      name: r'artist',
      type: IsarType.string,
    ),
    r'bucketDisplayName': PropertySchema(
      id: 4,
      name: r'bucketDisplayName',
      type: IsarType.string,
    ),
    r'data': PropertySchema(
      id: 5,
      name: r'data',
      type: IsarType.string,
    ),
    r'duration': PropertySchema(
      id: 6,
      name: r'duration',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 7,
      name: r'id',
      type: IsarType.string,
    ),
    r'quality': PropertySchema(
      id: 8,
      name: r'quality',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 9,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _cacheSongEntityEstimateSize,
  serialize: _cacheSongEntitySerialize,
  deserialize: _cacheSongEntityDeserialize,
  deserializeProp: _cacheSongEntityDeserializeProp,
  idName: r'gid',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _cacheSongEntityGetId,
  getLinks: _cacheSongEntityGetLinks,
  attach: _cacheSongEntityAttach,
  version: '3.1.0+1',
);

int _cacheSongEntityEstimateSize(
  CacheSongEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.album;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.albumArt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.artist.length * 3;
  {
    final value = object.bucketDisplayName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.data;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.quality;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _cacheSongEntitySerialize(
  CacheSongEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.album);
  writer.writeString(offsets[1], object.albumArt);
  writer.writeLong(offsets[2], object.albumId);
  writer.writeString(offsets[3], object.artist);
  writer.writeString(offsets[4], object.bucketDisplayName);
  writer.writeString(offsets[5], object.data);
  writer.writeLong(offsets[6], object.duration);
  writer.writeString(offsets[7], object.id);
  writer.writeString(offsets[8], object.quality);
  writer.writeString(offsets[9], object.title);
}

CacheSongEntity _cacheSongEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CacheSongEntity(
    album: reader.readStringOrNull(offsets[0]),
    albumArt: reader.readStringOrNull(offsets[1]),
    albumId: reader.readLongOrNull(offsets[2]),
    artist: reader.readString(offsets[3]),
    bucketDisplayName: reader.readStringOrNull(offsets[4]),
    data: reader.readStringOrNull(offsets[5]),
    duration: reader.readLong(offsets[6]),
    id: reader.readString(offsets[7]),
    quality: reader.readStringOrNull(offsets[8]),
    title: reader.readString(offsets[9]),
  );
  object.gid = id;
  return object;
}

P _cacheSongEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cacheSongEntityGetId(CacheSongEntity object) {
  return object.gid;
}

List<IsarLinkBase<dynamic>> _cacheSongEntityGetLinks(CacheSongEntity object) {
  return [];
}

void _cacheSongEntityAttach(
    IsarCollection<dynamic> col, Id id, CacheSongEntity object) {
  object.gid = id;
}

extension CacheSongEntityQueryWhereSort
    on QueryBuilder<CacheSongEntity, CacheSongEntity, QWhere> {
  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterWhere> anyGid() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CacheSongEntityQueryWhere
    on QueryBuilder<CacheSongEntity, CacheSongEntity, QWhereClause> {
  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterWhereClause> gidEqualTo(
      Id gid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: gid,
        upper: gid,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterWhereClause>
      gidNotEqualTo(Id gid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: gid, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: gid, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: gid, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: gid, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterWhereClause>
      gidGreaterThan(Id gid, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: gid, includeLower: include),
      );
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterWhereClause> gidLessThan(
      Id gid,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: gid, includeUpper: include),
      );
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterWhereClause> gidBetween(
    Id lowerGid,
    Id upperGid, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerGid,
        includeLower: includeLower,
        upper: upperGid,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CacheSongEntityQueryFilter
    on QueryBuilder<CacheSongEntity, CacheSongEntity, QFilterCondition> {
  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'album',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'album',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'album',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'album',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'album',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'album',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'album',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumArt',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumArt',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumArt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'albumArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'albumArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'albumArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'albumArt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumArt',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumArtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'albumArt',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumId',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumId',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumId',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      albumIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      artistEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      artistGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      artistLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      artistBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artist',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      artistStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      artistEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      artistContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      artistMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artist',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      artistIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artist',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      artistIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artist',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bucketDisplayName',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bucketDisplayName',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bucketDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bucketDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bucketDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bucketDisplayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bucketDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bucketDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bucketDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bucketDisplayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bucketDisplayName',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      bucketDisplayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bucketDisplayName',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'data',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'data',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'data',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'data',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      dataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'data',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      durationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      durationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      durationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      durationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      gidEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gid',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      gidGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gid',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      gidLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gid',
        value: value,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      gidBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quality',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quality',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quality',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quality',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quality',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      qualityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quality',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension CacheSongEntityQueryObject
    on QueryBuilder<CacheSongEntity, CacheSongEntity, QFilterCondition> {}

extension CacheSongEntityQueryLinks
    on QueryBuilder<CacheSongEntity, CacheSongEntity, QFilterCondition> {}

extension CacheSongEntityQuerySortBy
    on QueryBuilder<CacheSongEntity, CacheSongEntity, QSortBy> {
  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> sortByAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'album', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'album', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByAlbumArt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArt', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByAlbumArtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArt', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> sortByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByAlbumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> sortByArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByBucketDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketDisplayName', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByBucketDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketDisplayName', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> sortByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> sortByQuality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quality', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByQualityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quality', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension CacheSongEntityQuerySortThenBy
    on QueryBuilder<CacheSongEntity, CacheSongEntity, QSortThenBy> {
  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> thenByAlbum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'album', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByAlbumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'album', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByAlbumArt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArt', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByAlbumArtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumArt', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> thenByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByAlbumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> thenByArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByBucketDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketDisplayName', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByBucketDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketDisplayName', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> thenByData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'data', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> thenByGid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gid', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> thenByGidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gid', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> thenByQuality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quality', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByQualityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quality', Sort.desc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension CacheSongEntityQueryWhereDistinct
    on QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct> {
  QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct> distinctByAlbum(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'album', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct> distinctByAlbumArt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumArt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct>
      distinctByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumId');
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct> distinctByArtist(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artist', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct>
      distinctByBucketDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bucketDisplayName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct> distinctByData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct>
      distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct> distinctByQuality(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quality', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CacheSongEntity, CacheSongEntity, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension CacheSongEntityQueryProperty
    on QueryBuilder<CacheSongEntity, CacheSongEntity, QQueryProperty> {
  QueryBuilder<CacheSongEntity, int, QQueryOperations> gidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gid');
    });
  }

  QueryBuilder<CacheSongEntity, String?, QQueryOperations> albumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'album');
    });
  }

  QueryBuilder<CacheSongEntity, String?, QQueryOperations> albumArtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumArt');
    });
  }

  QueryBuilder<CacheSongEntity, int?, QQueryOperations> albumIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumId');
    });
  }

  QueryBuilder<CacheSongEntity, String, QQueryOperations> artistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artist');
    });
  }

  QueryBuilder<CacheSongEntity, String?, QQueryOperations>
      bucketDisplayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bucketDisplayName');
    });
  }

  QueryBuilder<CacheSongEntity, String?, QQueryOperations> dataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'data');
    });
  }

  QueryBuilder<CacheSongEntity, int, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<CacheSongEntity, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CacheSongEntity, String?, QQueryOperations> qualityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quality');
    });
  }

  QueryBuilder<CacheSongEntity, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
