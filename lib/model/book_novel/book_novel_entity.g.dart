// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_novel_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookNovelEntityCollection on Isar {
  IsarCollection<BookNovelEntity> get bookNovelEntitys => this.collection();
}

const BookNovelEntitySchema = CollectionSchema(
  name: r'book_novel',
  id: -1613642014334645285,
  properties: {
    r'bookTitle': PropertySchema(
      id: 0,
      name: r'bookTitle',
      type: IsarType.string,
    ),
    r'lastReadChapterIndex': PropertySchema(
      id: 1,
      name: r'lastReadChapterIndex',
      type: IsarType.long,
    ),
    r'lastReadChapterOffset': PropertySchema(
      id: 2,
      name: r'lastReadChapterOffset',
      type: IsarType.long,
    ),
    r'lastReadChapterTitle': PropertySchema(
      id: 3,
      name: r'lastReadChapterTitle',
      type: IsarType.string,
    ),
    r'localPath': PropertySchema(
      id: 4,
      name: r'localPath',
      type: IsarType.string,
    )
  },
  estimateSize: _bookNovelEntityEstimateSize,
  serialize: _bookNovelEntitySerialize,
  deserialize: _bookNovelEntityDeserialize,
  deserializeProp: _bookNovelEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bookNovelEntityGetId,
  getLinks: _bookNovelEntityGetLinks,
  attach: _bookNovelEntityAttach,
  version: '3.1.0+1',
);

int _bookNovelEntityEstimateSize(
  BookNovelEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bookTitle.length * 3;
  {
    final value = object.lastReadChapterTitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.localPath.length * 3;
  return bytesCount;
}

void _bookNovelEntitySerialize(
  BookNovelEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bookTitle);
  writer.writeLong(offsets[1], object.lastReadChapterIndex);
  writer.writeLong(offsets[2], object.lastReadChapterOffset);
  writer.writeString(offsets[3], object.lastReadChapterTitle);
  writer.writeString(offsets[4], object.localPath);
}

BookNovelEntity _bookNovelEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookNovelEntity(
    bookTitle: reader.readString(offsets[0]),
    lastReadChapterIndex: reader.readLongOrNull(offsets[1]),
    lastReadChapterOffset: reader.readLongOrNull(offsets[2]),
    lastReadChapterTitle: reader.readStringOrNull(offsets[3]),
    localPath: reader.readString(offsets[4]),
  );
  object.id = id;
  return object;
}

P _bookNovelEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bookNovelEntityGetId(BookNovelEntity object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _bookNovelEntityGetLinks(BookNovelEntity object) {
  return [];
}

void _bookNovelEntityAttach(
    IsarCollection<dynamic> col, Id id, BookNovelEntity object) {
  object.id = id;
}

extension BookNovelEntityQueryWhereSort
    on QueryBuilder<BookNovelEntity, BookNovelEntity, QWhere> {
  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BookNovelEntityQueryWhere
    on QueryBuilder<BookNovelEntity, BookNovelEntity, QWhereClause> {
  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterWhereClause>
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

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterWhereClause> idBetween(
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

extension BookNovelEntityQueryFilter
    on QueryBuilder<BookNovelEntity, BookNovelEntity, QFilterCondition> {
  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      bookTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      bookTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      bookTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      bookTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      bookTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bookTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      bookTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bookTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      bookTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bookTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      bookTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bookTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      bookTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      bookTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bookTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
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

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastReadChapterIndex',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastReadChapterIndex',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterIndexEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReadChapterIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterIndexGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastReadChapterIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterIndexLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastReadChapterIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterIndexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastReadChapterIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterOffsetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastReadChapterOffset',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterOffsetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastReadChapterOffset',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterOffsetEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReadChapterOffset',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterOffsetGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastReadChapterOffset',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterOffsetLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastReadChapterOffset',
        value: value,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterOffsetBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastReadChapterOffset',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastReadChapterTitle',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastReadChapterTitle',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReadChapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastReadChapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastReadChapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastReadChapterTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastReadChapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastReadChapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastReadChapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastReadChapterTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReadChapterTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      lastReadChapterTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastReadChapterTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      localPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      localPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      localPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      localPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      localPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      localPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      localPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      localPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      localPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localPath',
        value: '',
      ));
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterFilterCondition>
      localPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localPath',
        value: '',
      ));
    });
  }
}

extension BookNovelEntityQueryObject
    on QueryBuilder<BookNovelEntity, BookNovelEntity, QFilterCondition> {}

extension BookNovelEntityQueryLinks
    on QueryBuilder<BookNovelEntity, BookNovelEntity, QFilterCondition> {}

extension BookNovelEntityQuerySortBy
    on QueryBuilder<BookNovelEntity, BookNovelEntity, QSortBy> {
  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      sortByBookTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookTitle', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      sortByBookTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookTitle', Sort.desc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      sortByLastReadChapterIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterIndex', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      sortByLastReadChapterIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterIndex', Sort.desc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      sortByLastReadChapterOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterOffset', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      sortByLastReadChapterOffsetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterOffset', Sort.desc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      sortByLastReadChapterTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterTitle', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      sortByLastReadChapterTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterTitle', Sort.desc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      sortByLocalPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      sortByLocalPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.desc);
    });
  }
}

extension BookNovelEntityQuerySortThenBy
    on QueryBuilder<BookNovelEntity, BookNovelEntity, QSortThenBy> {
  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      thenByBookTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookTitle', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      thenByBookTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookTitle', Sort.desc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      thenByLastReadChapterIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterIndex', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      thenByLastReadChapterIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterIndex', Sort.desc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      thenByLastReadChapterOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterOffset', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      thenByLastReadChapterOffsetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterOffset', Sort.desc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      thenByLastReadChapterTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterTitle', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      thenByLastReadChapterTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadChapterTitle', Sort.desc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      thenByLocalPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.asc);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QAfterSortBy>
      thenByLocalPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localPath', Sort.desc);
    });
  }
}

extension BookNovelEntityQueryWhereDistinct
    on QueryBuilder<BookNovelEntity, BookNovelEntity, QDistinct> {
  QueryBuilder<BookNovelEntity, BookNovelEntity, QDistinct> distinctByBookTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QDistinct>
      distinctByLastReadChapterIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReadChapterIndex');
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QDistinct>
      distinctByLastReadChapterOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReadChapterOffset');
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QDistinct>
      distinctByLastReadChapterTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReadChapterTitle',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookNovelEntity, BookNovelEntity, QDistinct> distinctByLocalPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localPath', caseSensitive: caseSensitive);
    });
  }
}

extension BookNovelEntityQueryProperty
    on QueryBuilder<BookNovelEntity, BookNovelEntity, QQueryProperty> {
  QueryBuilder<BookNovelEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BookNovelEntity, String, QQueryOperations> bookTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookTitle');
    });
  }

  QueryBuilder<BookNovelEntity, int?, QQueryOperations>
      lastReadChapterIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReadChapterIndex');
    });
  }

  QueryBuilder<BookNovelEntity, int?, QQueryOperations>
      lastReadChapterOffsetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReadChapterOffset');
    });
  }

  QueryBuilder<BookNovelEntity, String?, QQueryOperations>
      lastReadChapterTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReadChapterTitle');
    });
  }

  QueryBuilder<BookNovelEntity, String, QQueryOperations> localPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localPath');
    });
  }
}
