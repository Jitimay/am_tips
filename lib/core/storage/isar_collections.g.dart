// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_collections.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedProfileCollection on Isar {
  IsarCollection<CachedProfile> get cachedProfiles => this.collection();
}

const CachedProfileSchema = CollectionSchema(
  name: r'CachedProfile',
  id: -3272954809300854847,
  properties: {
    r'avatarUrl': PropertySchema(
      id: 0,
      name: r'avatarUrl',
      type: IsarType.string,
    ),
    r'averageRating': PropertySchema(
      id: 1,
      name: r'averageRating',
      type: IsarType.double,
    ),
    r'cachedAt': PropertySchema(
      id: 2,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'city': PropertySchema(id: 3, name: r'city', type: IsarType.string),
    r'country': PropertySchema(id: 4, name: r'country', type: IsarType.string),
    r'createdAt': PropertySchema(
      id: 5,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'fullName': PropertySchema(
      id: 6,
      name: r'fullName',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(id: 7, name: r'isActive', type: IsarType.bool),
    r'paymentAccountId': PropertySchema(
      id: 8,
      name: r'paymentAccountId',
      type: IsarType.string,
    ),
    r'paymentAccountIdentifier': PropertySchema(
      id: 9,
      name: r'paymentAccountIdentifier',
      type: IsarType.string,
    ),
    r'paymentAccountIsActive': PropertySchema(
      id: 10,
      name: r'paymentAccountIsActive',
      type: IsarType.bool,
    ),
    r'paymentAccountProvider': PropertySchema(
      id: 11,
      name: r'paymentAccountProvider',
      type: IsarType.string,
    ),
    r'paymentAccountType': PropertySchema(
      id: 12,
      name: r'paymentAccountType',
      type: IsarType.string,
    ),
    r'personalMessage': PropertySchema(
      id: 13,
      name: r'personalMessage',
      type: IsarType.string,
    ),
    r'professions': PropertySchema(
      id: 14,
      name: r'professions',
      type: IsarType.stringList,
    ),
    r'profileId': PropertySchema(
      id: 15,
      name: r'profileId',
      type: IsarType.string,
    ),
    r'qrToken': PropertySchema(id: 16, name: r'qrToken', type: IsarType.string),
    r'restaurantName': PropertySchema(
      id: 17,
      name: r'restaurantName',
      type: IsarType.string,
    ),
    r'totalRatings': PropertySchema(
      id: 18,
      name: r'totalRatings',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 19,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(id: 20, name: r'userId', type: IsarType.string),
  },

  estimateSize: _cachedProfileEstimateSize,
  serialize: _cachedProfileSerialize,
  deserialize: _cachedProfileDeserialize,
  deserializeProp: _cachedProfileDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cachedProfileGetId,
  getLinks: _cachedProfileGetLinks,
  attach: _cachedProfileAttach,
  version: '3.3.2',
);

int _cachedProfileEstimateSize(
  CachedProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.avatarUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.city.length * 3;
  bytesCount += 3 + object.country.length * 3;
  bytesCount += 3 + object.fullName.length * 3;
  {
    final value = object.paymentAccountId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.paymentAccountIdentifier;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.paymentAccountProvider;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.paymentAccountType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.personalMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.professions.length * 3;
  {
    for (var i = 0; i < object.professions.length; i++) {
      final value = object.professions[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.profileId.length * 3;
  bytesCount += 3 + object.qrToken.length * 3;
  bytesCount += 3 + object.restaurantName.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _cachedProfileSerialize(
  CachedProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.avatarUrl);
  writer.writeDouble(offsets[1], object.averageRating);
  writer.writeDateTime(offsets[2], object.cachedAt);
  writer.writeString(offsets[3], object.city);
  writer.writeString(offsets[4], object.country);
  writer.writeDateTime(offsets[5], object.createdAt);
  writer.writeString(offsets[6], object.fullName);
  writer.writeBool(offsets[7], object.isActive);
  writer.writeString(offsets[8], object.paymentAccountId);
  writer.writeString(offsets[9], object.paymentAccountIdentifier);
  writer.writeBool(offsets[10], object.paymentAccountIsActive);
  writer.writeString(offsets[11], object.paymentAccountProvider);
  writer.writeString(offsets[12], object.paymentAccountType);
  writer.writeString(offsets[13], object.personalMessage);
  writer.writeStringList(offsets[14], object.professions);
  writer.writeString(offsets[15], object.profileId);
  writer.writeString(offsets[16], object.qrToken);
  writer.writeString(offsets[17], object.restaurantName);
  writer.writeLong(offsets[18], object.totalRatings);
  writer.writeDateTime(offsets[19], object.updatedAt);
  writer.writeString(offsets[20], object.userId);
}

CachedProfile _cachedProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedProfile();
  object.avatarUrl = reader.readStringOrNull(offsets[0]);
  object.averageRating = reader.readDouble(offsets[1]);
  object.cachedAt = reader.readDateTime(offsets[2]);
  object.city = reader.readString(offsets[3]);
  object.country = reader.readString(offsets[4]);
  object.createdAt = reader.readDateTimeOrNull(offsets[5]);
  object.fullName = reader.readString(offsets[6]);
  object.isActive = reader.readBool(offsets[7]);
  object.isarId = id;
  object.paymentAccountId = reader.readStringOrNull(offsets[8]);
  object.paymentAccountIdentifier = reader.readStringOrNull(offsets[9]);
  object.paymentAccountIsActive = reader.readBool(offsets[10]);
  object.paymentAccountProvider = reader.readStringOrNull(offsets[11]);
  object.paymentAccountType = reader.readStringOrNull(offsets[12]);
  object.personalMessage = reader.readStringOrNull(offsets[13]);
  object.professions = reader.readStringList(offsets[14]) ?? [];
  object.profileId = reader.readString(offsets[15]);
  object.qrToken = reader.readString(offsets[16]);
  object.restaurantName = reader.readString(offsets[17]);
  object.totalRatings = reader.readLong(offsets[18]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[19]);
  object.userId = reader.readString(offsets[20]);
  return object;
}

P _cachedProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringList(offset) ?? []) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedProfileGetId(CachedProfile object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cachedProfileGetLinks(CachedProfile object) {
  return [];
}

void _cachedProfileAttach(
  IsarCollection<dynamic> col,
  Id id,
  CachedProfile object,
) {
  object.isarId = id;
}

extension CachedProfileByIndex on IsarCollection<CachedProfile> {
  Future<CachedProfile?> getByUserId(String userId) {
    return getByIndex(r'userId', [userId]);
  }

  CachedProfile? getByUserIdSync(String userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<CachedProfile?>> getAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<CachedProfile?> getAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<String> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(CachedProfile object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(CachedProfile object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<CachedProfile> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(
    List<CachedProfile> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension CachedProfileQueryWhereSort
    on QueryBuilder<CachedProfile, CachedProfile, QWhere> {
  QueryBuilder<CachedProfile, CachedProfile, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedProfileQueryWhere
    on QueryBuilder<CachedProfile, CachedProfile, QWhereClause> {
  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause>
  isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause>
  isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause> isarIdLessThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause> userIdEqualTo(
    String userId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'userId', value: [userId]),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterWhereClause>
  userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [],
                upper: [userId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [userId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [userId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'userId',
                lower: [],
                upper: [userId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CachedProfileQueryFilter
    on QueryBuilder<CachedProfile, CachedProfile, QFilterCondition> {
  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'avatarUrl'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'avatarUrl'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'avatarUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'avatarUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'avatarUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'avatarUrl', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  avatarUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'avatarUrl', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  averageRatingEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'averageRating',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  averageRatingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'averageRating',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  averageRatingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'averageRating',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  averageRatingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'averageRating',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cachedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cachedAt', value: value),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cachedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cachedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cachedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cachedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition> cityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'city',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'city',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'city',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition> cityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'city',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cityStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'city',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cityEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'city',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'city',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition> cityMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'city',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'city', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'city', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  countryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'country',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  countryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'country',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  countryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'country',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  countryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'country',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  countryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'country',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  countryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'country',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  countryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'country',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  countryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'country',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  countryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'country', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  countryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'country', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'createdAt'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  createdAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  createdAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  fullNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  fullNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  fullNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  fullNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fullName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  fullNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  fullNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  fullNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fullName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  fullNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fullName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  fullNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fullName', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  fullNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fullName', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isActive', value: value),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'paymentAccountId'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'paymentAccountId'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'paymentAccountId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'paymentAccountId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'paymentAccountId', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'paymentAccountId', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'paymentAccountIdentifier'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'paymentAccountIdentifier'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'paymentAccountIdentifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'paymentAccountIdentifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'paymentAccountIdentifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'paymentAccountIdentifier',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'paymentAccountIdentifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'paymentAccountIdentifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'paymentAccountIdentifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'paymentAccountIdentifier',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'paymentAccountIdentifier',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIdentifierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'paymentAccountIdentifier',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountIsActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'paymentAccountIsActive',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'paymentAccountProvider'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'paymentAccountProvider'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'paymentAccountProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'paymentAccountProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'paymentAccountProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'paymentAccountProvider',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'paymentAccountProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'paymentAccountProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'paymentAccountProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'paymentAccountProvider',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'paymentAccountProvider', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountProviderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'paymentAccountProvider',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'paymentAccountType'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'paymentAccountType'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'paymentAccountType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'paymentAccountType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'paymentAccountType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'paymentAccountType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'paymentAccountType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'paymentAccountType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'paymentAccountType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'paymentAccountType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'paymentAccountType', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  paymentAccountTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'paymentAccountType', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'personalMessage'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'personalMessage'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'personalMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'personalMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'personalMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'personalMessage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'personalMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'personalMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'personalMessage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'personalMessage',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'personalMessage', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  personalMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'personalMessage', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'professions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'professions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'professions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'professions',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'professions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'professions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'professions',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'professions',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'professions', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'professions', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'professions', length, true, length, true);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'professions', 0, true, 0, true);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'professions', 0, false, 999999, true);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'professions', 0, true, length, include);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'professions', length, include, 999999, true);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  professionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'professions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  profileIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  profileIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  profileIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  profileIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'profileId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  profileIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  profileIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  profileIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'profileId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  profileIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'profileId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  profileIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'profileId', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  profileIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'profileId', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  qrTokenEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  qrTokenGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  qrTokenLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  qrTokenBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qrToken',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  qrTokenStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  qrTokenEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  qrTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  qrTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'qrToken',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  qrTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'qrToken', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  qrTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'qrToken', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  restaurantNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'restaurantName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  restaurantNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'restaurantName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  restaurantNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'restaurantName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  restaurantNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'restaurantName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  restaurantNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'restaurantName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  restaurantNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'restaurantName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  restaurantNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'restaurantName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  restaurantNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'restaurantName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  restaurantNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'restaurantName', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  restaurantNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'restaurantName', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  totalRatingsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalRatings', value: value),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  totalRatingsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalRatings',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  totalRatingsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalRatings',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  totalRatingsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalRatings',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  updatedAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  userIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'userId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  userIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  userIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'userId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'userId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'userId', value: ''),
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterFilterCondition>
  userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'userId', value: ''),
      );
    });
  }
}

extension CachedProfileQueryObject
    on QueryBuilder<CachedProfile, CachedProfile, QFilterCondition> {}

extension CachedProfileQueryLinks
    on QueryBuilder<CachedProfile, CachedProfile, QFilterCondition> {}

extension CachedProfileQuerySortBy
    on QueryBuilder<CachedProfile, CachedProfile, QSortBy> {
  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByAverageRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageRating', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByAverageRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageRating', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByFullName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByFullNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPaymentAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountId', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPaymentAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountId', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPaymentAccountIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountIdentifier', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPaymentAccountIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountIdentifier', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPaymentAccountIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountIsActive', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPaymentAccountIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountIsActive', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPaymentAccountProvider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountProvider', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPaymentAccountProviderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountProvider', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPaymentAccountType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountType', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPaymentAccountTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountType', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPersonalMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personalMessage', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByPersonalMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personalMessage', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByProfileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByQrToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrToken', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByQrTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrToken', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByRestaurantName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurantName', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByRestaurantNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurantName', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByTotalRatings() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRatings', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByTotalRatingsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRatings', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedProfileQuerySortThenBy
    on QueryBuilder<CachedProfile, CachedProfile, QSortThenBy> {
  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByAverageRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageRating', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByAverageRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageRating', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByFullName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByFullNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPaymentAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountId', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPaymentAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountId', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPaymentAccountIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountIdentifier', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPaymentAccountIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountIdentifier', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPaymentAccountIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountIsActive', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPaymentAccountIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountIsActive', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPaymentAccountProvider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountProvider', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPaymentAccountProviderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountProvider', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPaymentAccountType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountType', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPaymentAccountTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountType', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPersonalMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personalMessage', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByPersonalMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personalMessage', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByProfileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByQrToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrToken', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByQrTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrToken', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByRestaurantName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurantName', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByRestaurantNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurantName', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByTotalRatings() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRatings', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByTotalRatingsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRatings', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension CachedProfileQueryWhereDistinct
    on QueryBuilder<CachedProfile, CachedProfile, QDistinct> {
  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByAvatarUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
  distinctByAverageRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'averageRating');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByCity({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'city', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByCountry({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'country', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByFullName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
  distinctByPaymentAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'paymentAccountId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
  distinctByPaymentAccountIdentifier({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'paymentAccountIdentifier',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
  distinctByPaymentAccountIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentAccountIsActive');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
  distinctByPaymentAccountProvider({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'paymentAccountProvider',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
  distinctByPaymentAccountType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'paymentAccountType',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
  distinctByPersonalMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'personalMessage',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
  distinctByProfessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'professions');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByProfileId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByQrToken({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrToken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
  distinctByRestaurantName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'restaurantName',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct>
  distinctByTotalRatings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalRatings');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<CachedProfile, CachedProfile, QDistinct> distinctByUserId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedProfileQueryProperty
    on QueryBuilder<CachedProfile, CachedProfile, QQueryProperty> {
  QueryBuilder<CachedProfile, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CachedProfile, String?, QQueryOperations> avatarUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarUrl');
    });
  }

  QueryBuilder<CachedProfile, double, QQueryOperations>
  averageRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'averageRating');
    });
  }

  QueryBuilder<CachedProfile, DateTime, QQueryOperations> cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations> cityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'city');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations> countryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'country');
    });
  }

  QueryBuilder<CachedProfile, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations> fullNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullName');
    });
  }

  QueryBuilder<CachedProfile, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<CachedProfile, String?, QQueryOperations>
  paymentAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentAccountId');
    });
  }

  QueryBuilder<CachedProfile, String?, QQueryOperations>
  paymentAccountIdentifierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentAccountIdentifier');
    });
  }

  QueryBuilder<CachedProfile, bool, QQueryOperations>
  paymentAccountIsActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentAccountIsActive');
    });
  }

  QueryBuilder<CachedProfile, String?, QQueryOperations>
  paymentAccountProviderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentAccountProvider');
    });
  }

  QueryBuilder<CachedProfile, String?, QQueryOperations>
  paymentAccountTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentAccountType');
    });
  }

  QueryBuilder<CachedProfile, String?, QQueryOperations>
  personalMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personalMessage');
    });
  }

  QueryBuilder<CachedProfile, List<String>, QQueryOperations>
  professionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'professions');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations> profileIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileId');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations> qrTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrToken');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations>
  restaurantNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restaurantName');
    });
  }

  QueryBuilder<CachedProfile, int, QQueryOperations> totalRatingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalRatings');
    });
  }

  QueryBuilder<CachedProfile, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<CachedProfile, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedTipCollection on Isar {
  IsarCollection<CachedTip> get cachedTips => this.collection();
}

const CachedTipSchema = CollectionSchema(
  name: r'CachedTip',
  id: 5265598074292363317,
  properties: {
    r'amount': PropertySchema(id: 0, name: r'amount', type: IsarType.long),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currency': PropertySchema(
      id: 2,
      name: r'currency',
      type: IsarType.string,
    ),
    r'customerName': PropertySchema(
      id: 3,
      name: r'customerName',
      type: IsarType.string,
    ),
    r'id': PropertySchema(id: 4, name: r'id', type: IsarType.string),
    r'isAnonymous': PropertySchema(
      id: 5,
      name: r'isAnonymous',
      type: IsarType.bool,
    ),
    r'message': PropertySchema(id: 6, name: r'message', type: IsarType.string),
    r'paymentProvider': PropertySchema(
      id: 7,
      name: r'paymentProvider',
      type: IsarType.string,
    ),
    r'rating': PropertySchema(id: 8, name: r'rating', type: IsarType.long),
    r'status': PropertySchema(id: 9, name: r'status', type: IsarType.string),
    r'transactionReference': PropertySchema(
      id: 10,
      name: r'transactionReference',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 11,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'waiterId': PropertySchema(
      id: 12,
      name: r'waiterId',
      type: IsarType.string,
    ),
  },

  estimateSize: _cachedTipEstimateSize,
  serialize: _cachedTipSerialize,
  deserialize: _cachedTipDeserialize,
  deserializeProp: _cachedTipDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'waiterId': IndexSchema(
      id: 5413859458877949780,
      name: r'waiterId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'waiterId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cachedTipGetId,
  getLinks: _cachedTipGetLinks,
  attach: _cachedTipAttach,
  version: '3.3.2',
);

int _cachedTipEstimateSize(
  CachedTip object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.currency.length * 3;
  {
    final value = object.customerName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.message;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.paymentProvider;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.length * 3;
  {
    final value = object.transactionReference;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.waiterId.length * 3;
  return bytesCount;
}

void _cachedTipSerialize(
  CachedTip object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.currency);
  writer.writeString(offsets[3], object.customerName);
  writer.writeString(offsets[4], object.id);
  writer.writeBool(offsets[5], object.isAnonymous);
  writer.writeString(offsets[6], object.message);
  writer.writeString(offsets[7], object.paymentProvider);
  writer.writeLong(offsets[8], object.rating);
  writer.writeString(offsets[9], object.status);
  writer.writeString(offsets[10], object.transactionReference);
  writer.writeDateTime(offsets[11], object.updatedAt);
  writer.writeString(offsets[12], object.waiterId);
}

CachedTip _cachedTipDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedTip();
  object.amount = reader.readLong(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.currency = reader.readString(offsets[2]);
  object.customerName = reader.readStringOrNull(offsets[3]);
  object.id = reader.readString(offsets[4]);
  object.isAnonymous = reader.readBool(offsets[5]);
  object.isarId = id;
  object.message = reader.readStringOrNull(offsets[6]);
  object.paymentProvider = reader.readStringOrNull(offsets[7]);
  object.rating = reader.readLongOrNull(offsets[8]);
  object.status = reader.readString(offsets[9]);
  object.transactionReference = reader.readStringOrNull(offsets[10]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[11]);
  object.waiterId = reader.readString(offsets[12]);
  return object;
}

P _cachedTipDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedTipGetId(CachedTip object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cachedTipGetLinks(CachedTip object) {
  return [];
}

void _cachedTipAttach(IsarCollection<dynamic> col, Id id, CachedTip object) {
  object.isarId = id;
}

extension CachedTipByIndex on IsarCollection<CachedTip> {
  Future<CachedTip?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  CachedTip? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<CachedTip?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<CachedTip?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(CachedTip object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(CachedTip object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<CachedTip> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<CachedTip> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension CachedTipQueryWhereSort
    on QueryBuilder<CachedTip, CachedTip, QWhere> {
  QueryBuilder<CachedTip, CachedTip, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedTipQueryWhere
    on QueryBuilder<CachedTip, CachedTip, QWhereClause> {
  QueryBuilder<CachedTip, CachedTip, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterWhereClause> isarIdNotEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterWhereClause> isarIdGreaterThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterWhereClause> isarIdLessThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'id', value: [id]),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterWhereClause> idNotEqualTo(
    String id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterWhereClause> waiterIdEqualTo(
    String waiterId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'waiterId', value: [waiterId]),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterWhereClause> waiterIdNotEqualTo(
    String waiterId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CachedTipQueryFilter
    on QueryBuilder<CachedTip, CachedTip, QFilterCondition> {
  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> amountEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'amount', value: value),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> amountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'amount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> amountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'amount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> amountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'amount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> createdAtEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> currencyContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> currencyMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'currency',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  customerNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'customerName'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  customerNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'customerName'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> customerNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'customerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  customerNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'customerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  customerNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'customerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> customerNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'customerName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  customerNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'customerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  customerNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'customerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  customerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'customerName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> customerNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'customerName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  customerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'customerName', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  customerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'customerName', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> idContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> idMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'id',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> isAnonymousEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isAnonymous', value: value),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> isarIdEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'message'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'message'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'message',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'message',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'message', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'message', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'paymentProvider'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'paymentProvider'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'paymentProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'paymentProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'paymentProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'paymentProvider',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'paymentProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'paymentProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'paymentProvider',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'paymentProvider',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'paymentProvider', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  paymentProviderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'paymentProvider', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> ratingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'rating'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> ratingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'rating'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> ratingEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rating', value: value),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> ratingGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rating',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> ratingLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rating',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> ratingBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rating',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> statusContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> statusMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'transactionReference'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'transactionReference'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'transactionReference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'transactionReference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'transactionReference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'transactionReference',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'transactionReference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'transactionReference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'transactionReference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'transactionReference',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'transactionReference', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  transactionReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'transactionReference',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'updatedAt'),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> waiterIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> waiterIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> waiterIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> waiterIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'waiterId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> waiterIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> waiterIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> waiterIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> waiterIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'waiterId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition> waiterIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'waiterId', value: ''),
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterFilterCondition>
  waiterIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'waiterId', value: ''),
      );
    });
  }
}

extension CachedTipQueryObject
    on QueryBuilder<CachedTip, CachedTip, QFilterCondition> {}

extension CachedTipQueryLinks
    on QueryBuilder<CachedTip, CachedTip, QFilterCondition> {}

extension CachedTipQuerySortBy on QueryBuilder<CachedTip, CachedTip, QSortBy> {
  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByCustomerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByCustomerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByIsAnonymous() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAnonymous', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByIsAnonymousDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAnonymous', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByPaymentProvider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentProvider', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByPaymentProviderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentProvider', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy>
  sortByTransactionReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionReference', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy>
  sortByTransactionReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionReference', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> sortByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }
}

extension CachedTipQuerySortThenBy
    on QueryBuilder<CachedTip, CachedTip, QSortThenBy> {
  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByCustomerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByCustomerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByIsAnonymous() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAnonymous', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByIsAnonymousDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAnonymous', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByPaymentProvider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentProvider', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByPaymentProviderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentProvider', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy>
  thenByTransactionReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionReference', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy>
  thenByTransactionReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionReference', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QAfterSortBy> thenByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }
}

extension CachedTipQueryWhereDistinct
    on QueryBuilder<CachedTip, CachedTip, QDistinct> {
  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByCurrency({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByCustomerName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctById({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByIsAnonymous() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAnonymous');
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByMessage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByPaymentProvider({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'paymentProvider',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByTransactionReference({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'transactionReference',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<CachedTip, CachedTip, QDistinct> distinctByWaiterId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waiterId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedTipQueryProperty
    on QueryBuilder<CachedTip, CachedTip, QQueryProperty> {
  QueryBuilder<CachedTip, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CachedTip, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<CachedTip, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedTip, String, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<CachedTip, String?, QQueryOperations> customerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerName');
    });
  }

  QueryBuilder<CachedTip, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedTip, bool, QQueryOperations> isAnonymousProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAnonymous');
    });
  }

  QueryBuilder<CachedTip, String?, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<CachedTip, String?, QQueryOperations> paymentProviderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentProvider');
    });
  }

  QueryBuilder<CachedTip, int?, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<CachedTip, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<CachedTip, String?, QQueryOperations>
  transactionReferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactionReference');
    });
  }

  QueryBuilder<CachedTip, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<CachedTip, String, QQueryOperations> waiterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waiterId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedTipStatsCollection on Isar {
  IsarCollection<CachedTipStats> get cachedTipStats => this.collection();
}

const CachedTipStatsSchema = CollectionSchema(
  name: r'CachedTipStats',
  id: -1655406982228569447,
  properties: {
    r'allTimeCount': PropertySchema(
      id: 0,
      name: r'allTimeCount',
      type: IsarType.long,
    ),
    r'allTimeTotal': PropertySchema(
      id: 1,
      name: r'allTimeTotal',
      type: IsarType.long,
    ),
    r'cachedAt': PropertySchema(
      id: 2,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'currency': PropertySchema(
      id: 3,
      name: r'currency',
      type: IsarType.string,
    ),
    r'todayCount': PropertySchema(
      id: 4,
      name: r'todayCount',
      type: IsarType.long,
    ),
    r'todayTotal': PropertySchema(
      id: 5,
      name: r'todayTotal',
      type: IsarType.long,
    ),
    r'waiterId': PropertySchema(
      id: 6,
      name: r'waiterId',
      type: IsarType.string,
    ),
    r'weekCount': PropertySchema(
      id: 7,
      name: r'weekCount',
      type: IsarType.long,
    ),
    r'weekTotal': PropertySchema(
      id: 8,
      name: r'weekTotal',
      type: IsarType.long,
    ),
  },

  estimateSize: _cachedTipStatsEstimateSize,
  serialize: _cachedTipStatsSerialize,
  deserialize: _cachedTipStatsDeserialize,
  deserializeProp: _cachedTipStatsDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'waiterId': IndexSchema(
      id: 5413859458877949780,
      name: r'waiterId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'waiterId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cachedTipStatsGetId,
  getLinks: _cachedTipStatsGetLinks,
  attach: _cachedTipStatsAttach,
  version: '3.3.2',
);

int _cachedTipStatsEstimateSize(
  CachedTipStats object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.currency.length * 3;
  bytesCount += 3 + object.waiterId.length * 3;
  return bytesCount;
}

void _cachedTipStatsSerialize(
  CachedTipStats object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.allTimeCount);
  writer.writeLong(offsets[1], object.allTimeTotal);
  writer.writeDateTime(offsets[2], object.cachedAt);
  writer.writeString(offsets[3], object.currency);
  writer.writeLong(offsets[4], object.todayCount);
  writer.writeLong(offsets[5], object.todayTotal);
  writer.writeString(offsets[6], object.waiterId);
  writer.writeLong(offsets[7], object.weekCount);
  writer.writeLong(offsets[8], object.weekTotal);
}

CachedTipStats _cachedTipStatsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedTipStats();
  object.allTimeCount = reader.readLong(offsets[0]);
  object.allTimeTotal = reader.readLong(offsets[1]);
  object.cachedAt = reader.readDateTime(offsets[2]);
  object.currency = reader.readString(offsets[3]);
  object.isarId = id;
  object.todayCount = reader.readLong(offsets[4]);
  object.todayTotal = reader.readLong(offsets[5]);
  object.waiterId = reader.readString(offsets[6]);
  object.weekCount = reader.readLong(offsets[7]);
  object.weekTotal = reader.readLong(offsets[8]);
  return object;
}

P _cachedTipStatsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedTipStatsGetId(CachedTipStats object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cachedTipStatsGetLinks(CachedTipStats object) {
  return [];
}

void _cachedTipStatsAttach(
  IsarCollection<dynamic> col,
  Id id,
  CachedTipStats object,
) {
  object.isarId = id;
}

extension CachedTipStatsByIndex on IsarCollection<CachedTipStats> {
  Future<CachedTipStats?> getByWaiterId(String waiterId) {
    return getByIndex(r'waiterId', [waiterId]);
  }

  CachedTipStats? getByWaiterIdSync(String waiterId) {
    return getByIndexSync(r'waiterId', [waiterId]);
  }

  Future<bool> deleteByWaiterId(String waiterId) {
    return deleteByIndex(r'waiterId', [waiterId]);
  }

  bool deleteByWaiterIdSync(String waiterId) {
    return deleteByIndexSync(r'waiterId', [waiterId]);
  }

  Future<List<CachedTipStats?>> getAllByWaiterId(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'waiterId', values);
  }

  List<CachedTipStats?> getAllByWaiterIdSync(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'waiterId', values);
  }

  Future<int> deleteAllByWaiterId(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'waiterId', values);
  }

  int deleteAllByWaiterIdSync(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'waiterId', values);
  }

  Future<Id> putByWaiterId(CachedTipStats object) {
    return putByIndex(r'waiterId', object);
  }

  Id putByWaiterIdSync(CachedTipStats object, {bool saveLinks = true}) {
    return putByIndexSync(r'waiterId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByWaiterId(List<CachedTipStats> objects) {
    return putAllByIndex(r'waiterId', objects);
  }

  List<Id> putAllByWaiterIdSync(
    List<CachedTipStats> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'waiterId', objects, saveLinks: saveLinks);
  }
}

extension CachedTipStatsQueryWhereSort
    on QueryBuilder<CachedTipStats, CachedTipStats, QWhere> {
  QueryBuilder<CachedTipStats, CachedTipStats, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedTipStatsQueryWhere
    on QueryBuilder<CachedTipStats, CachedTipStats, QWhereClause> {
  QueryBuilder<CachedTipStats, CachedTipStats, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterWhereClause>
  isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterWhereClause>
  isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterWhereClause>
  isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterWhereClause>
  waiterIdEqualTo(String waiterId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'waiterId', value: [waiterId]),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterWhereClause>
  waiterIdNotEqualTo(String waiterId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CachedTipStatsQueryFilter
    on QueryBuilder<CachedTipStats, CachedTipStats, QFilterCondition> {
  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  allTimeCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'allTimeCount', value: value),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  allTimeCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'allTimeCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  allTimeCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'allTimeCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  allTimeCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'allTimeCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  allTimeTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'allTimeTotal', value: value),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  allTimeTotalGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'allTimeTotal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  allTimeTotalLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'allTimeTotal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  allTimeTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'allTimeTotal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  cachedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cachedAt', value: value),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  cachedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  cachedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  cachedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cachedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  currencyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  currencyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  currencyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'currency',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  todayCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'todayCount', value: value),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  todayCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'todayCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  todayCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'todayCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  todayCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'todayCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  todayTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'todayTotal', value: value),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  todayTotalGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'todayTotal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  todayTotalLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'todayTotal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  todayTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'todayTotal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  waiterIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  waiterIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  waiterIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  waiterIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'waiterId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  waiterIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  waiterIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  waiterIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  waiterIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'waiterId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  waiterIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'waiterId', value: ''),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  waiterIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'waiterId', value: ''),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  weekCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'weekCount', value: value),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  weekCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weekCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  weekCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weekCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  weekCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weekCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  weekTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'weekTotal', value: value),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  weekTotalGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weekTotal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  weekTotalLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weekTotal',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterFilterCondition>
  weekTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weekTotal',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CachedTipStatsQueryObject
    on QueryBuilder<CachedTipStats, CachedTipStats, QFilterCondition> {}

extension CachedTipStatsQueryLinks
    on QueryBuilder<CachedTipStats, CachedTipStats, QFilterCondition> {}

extension CachedTipStatsQuerySortBy
    on QueryBuilder<CachedTipStats, CachedTipStats, QSortBy> {
  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByAllTimeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allTimeCount', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByAllTimeCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allTimeCount', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByAllTimeTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allTimeTotal', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByAllTimeTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allTimeTotal', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByTodayCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayCount', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByTodayCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayCount', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByTodayTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayTotal', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByTodayTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayTotal', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> sortByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> sortByWeekCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekCount', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByWeekCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekCount', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> sortByWeekTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekTotal', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  sortByWeekTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekTotal', Sort.desc);
    });
  }
}

extension CachedTipStatsQuerySortThenBy
    on QueryBuilder<CachedTipStats, CachedTipStats, QSortThenBy> {
  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByAllTimeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allTimeCount', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByAllTimeCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allTimeCount', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByAllTimeTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allTimeTotal', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByAllTimeTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allTimeTotal', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByTodayCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayCount', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByTodayCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayCount', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByTodayTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayTotal', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByTodayTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'todayTotal', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> thenByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> thenByWeekCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekCount', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByWeekCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekCount', Sort.desc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy> thenByWeekTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekTotal', Sort.asc);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QAfterSortBy>
  thenByWeekTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekTotal', Sort.desc);
    });
  }
}

extension CachedTipStatsQueryWhereDistinct
    on QueryBuilder<CachedTipStats, CachedTipStats, QDistinct> {
  QueryBuilder<CachedTipStats, CachedTipStats, QDistinct>
  distinctByAllTimeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allTimeCount');
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QDistinct>
  distinctByAllTimeTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allTimeTotal');
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QDistinct> distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QDistinct> distinctByCurrency({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QDistinct>
  distinctByTodayCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'todayCount');
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QDistinct>
  distinctByTodayTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'todayTotal');
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QDistinct> distinctByWaiterId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waiterId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QDistinct>
  distinctByWeekCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekCount');
    });
  }

  QueryBuilder<CachedTipStats, CachedTipStats, QDistinct>
  distinctByWeekTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekTotal');
    });
  }
}

extension CachedTipStatsQueryProperty
    on QueryBuilder<CachedTipStats, CachedTipStats, QQueryProperty> {
  QueryBuilder<CachedTipStats, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CachedTipStats, int, QQueryOperations> allTimeCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allTimeCount');
    });
  }

  QueryBuilder<CachedTipStats, int, QQueryOperations> allTimeTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allTimeTotal');
    });
  }

  QueryBuilder<CachedTipStats, DateTime, QQueryOperations> cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<CachedTipStats, String, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<CachedTipStats, int, QQueryOperations> todayCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'todayCount');
    });
  }

  QueryBuilder<CachedTipStats, int, QQueryOperations> todayTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'todayTotal');
    });
  }

  QueryBuilder<CachedTipStats, String, QQueryOperations> waiterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waiterId');
    });
  }

  QueryBuilder<CachedTipStats, int, QQueryOperations> weekCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekCount');
    });
  }

  QueryBuilder<CachedTipStats, int, QQueryOperations> weekTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekTotal');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedWalletCollection on Isar {
  IsarCollection<CachedWallet> get cachedWallets => this.collection();
}

const CachedWalletSchema = CollectionSchema(
  name: r'CachedWallet',
  id: 5012407814859582113,
  properties: {
    r'availableBalance': PropertySchema(
      id: 0,
      name: r'availableBalance',
      type: IsarType.long,
    ),
    r'cachedAt': PropertySchema(
      id: 1,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'currency': PropertySchema(
      id: 2,
      name: r'currency',
      type: IsarType.string,
    ),
    r'pendingBalance': PropertySchema(
      id: 3,
      name: r'pendingBalance',
      type: IsarType.long,
    ),
    r'waiterId': PropertySchema(
      id: 4,
      name: r'waiterId',
      type: IsarType.string,
    ),
  },

  estimateSize: _cachedWalletEstimateSize,
  serialize: _cachedWalletSerialize,
  deserialize: _cachedWalletDeserialize,
  deserializeProp: _cachedWalletDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'waiterId': IndexSchema(
      id: 5413859458877949780,
      name: r'waiterId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'waiterId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cachedWalletGetId,
  getLinks: _cachedWalletGetLinks,
  attach: _cachedWalletAttach,
  version: '3.3.2',
);

int _cachedWalletEstimateSize(
  CachedWallet object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.currency.length * 3;
  bytesCount += 3 + object.waiterId.length * 3;
  return bytesCount;
}

void _cachedWalletSerialize(
  CachedWallet object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.availableBalance);
  writer.writeDateTime(offsets[1], object.cachedAt);
  writer.writeString(offsets[2], object.currency);
  writer.writeLong(offsets[3], object.pendingBalance);
  writer.writeString(offsets[4], object.waiterId);
}

CachedWallet _cachedWalletDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedWallet();
  object.availableBalance = reader.readLong(offsets[0]);
  object.cachedAt = reader.readDateTime(offsets[1]);
  object.currency = reader.readString(offsets[2]);
  object.isarId = id;
  object.pendingBalance = reader.readLong(offsets[3]);
  object.waiterId = reader.readString(offsets[4]);
  return object;
}

P _cachedWalletDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedWalletGetId(CachedWallet object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cachedWalletGetLinks(CachedWallet object) {
  return [];
}

void _cachedWalletAttach(
  IsarCollection<dynamic> col,
  Id id,
  CachedWallet object,
) {
  object.isarId = id;
}

extension CachedWalletByIndex on IsarCollection<CachedWallet> {
  Future<CachedWallet?> getByWaiterId(String waiterId) {
    return getByIndex(r'waiterId', [waiterId]);
  }

  CachedWallet? getByWaiterIdSync(String waiterId) {
    return getByIndexSync(r'waiterId', [waiterId]);
  }

  Future<bool> deleteByWaiterId(String waiterId) {
    return deleteByIndex(r'waiterId', [waiterId]);
  }

  bool deleteByWaiterIdSync(String waiterId) {
    return deleteByIndexSync(r'waiterId', [waiterId]);
  }

  Future<List<CachedWallet?>> getAllByWaiterId(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'waiterId', values);
  }

  List<CachedWallet?> getAllByWaiterIdSync(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'waiterId', values);
  }

  Future<int> deleteAllByWaiterId(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'waiterId', values);
  }

  int deleteAllByWaiterIdSync(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'waiterId', values);
  }

  Future<Id> putByWaiterId(CachedWallet object) {
    return putByIndex(r'waiterId', object);
  }

  Id putByWaiterIdSync(CachedWallet object, {bool saveLinks = true}) {
    return putByIndexSync(r'waiterId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByWaiterId(List<CachedWallet> objects) {
    return putAllByIndex(r'waiterId', objects);
  }

  List<Id> putAllByWaiterIdSync(
    List<CachedWallet> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'waiterId', objects, saveLinks: saveLinks);
  }
}

extension CachedWalletQueryWhereSort
    on QueryBuilder<CachedWallet, CachedWallet, QWhere> {
  QueryBuilder<CachedWallet, CachedWallet, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedWalletQueryWhere
    on QueryBuilder<CachedWallet, CachedWallet, QWhereClause> {
  QueryBuilder<CachedWallet, CachedWallet, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterWhereClause> isarIdNotEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterWhereClause> isarIdGreaterThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterWhereClause> isarIdLessThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterWhereClause> waiterIdEqualTo(
    String waiterId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'waiterId', value: [waiterId]),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterWhereClause>
  waiterIdNotEqualTo(String waiterId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CachedWalletQueryFilter
    on QueryBuilder<CachedWallet, CachedWallet, QFilterCondition> {
  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  availableBalanceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'availableBalance', value: value),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  availableBalanceGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'availableBalance',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  availableBalanceLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'availableBalance',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  availableBalanceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'availableBalance',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  cachedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cachedAt', value: value),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  cachedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  cachedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  cachedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cachedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  currencyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  currencyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  currencyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'currency',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition> isarIdEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  pendingBalanceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pendingBalance', value: value),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  pendingBalanceGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pendingBalance',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  pendingBalanceLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pendingBalance',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  pendingBalanceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pendingBalance',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  waiterIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  waiterIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  waiterIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  waiterIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'waiterId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  waiterIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  waiterIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  waiterIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  waiterIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'waiterId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  waiterIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'waiterId', value: ''),
      );
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterFilterCondition>
  waiterIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'waiterId', value: ''),
      );
    });
  }
}

extension CachedWalletQueryObject
    on QueryBuilder<CachedWallet, CachedWallet, QFilterCondition> {}

extension CachedWalletQueryLinks
    on QueryBuilder<CachedWallet, CachedWallet, QFilterCondition> {}

extension CachedWalletQuerySortBy
    on QueryBuilder<CachedWallet, CachedWallet, QSortBy> {
  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy>
  sortByAvailableBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableBalance', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy>
  sortByAvailableBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableBalance', Sort.desc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy>
  sortByPendingBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingBalance', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy>
  sortByPendingBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingBalance', Sort.desc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> sortByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> sortByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }
}

extension CachedWalletQuerySortThenBy
    on QueryBuilder<CachedWallet, CachedWallet, QSortThenBy> {
  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy>
  thenByAvailableBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableBalance', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy>
  thenByAvailableBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableBalance', Sort.desc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy>
  thenByPendingBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingBalance', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy>
  thenByPendingBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingBalance', Sort.desc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> thenByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QAfterSortBy> thenByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }
}

extension CachedWalletQueryWhereDistinct
    on QueryBuilder<CachedWallet, CachedWallet, QDistinct> {
  QueryBuilder<CachedWallet, CachedWallet, QDistinct>
  distinctByAvailableBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'availableBalance');
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QDistinct> distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QDistinct> distinctByCurrency({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QDistinct>
  distinctByPendingBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingBalance');
    });
  }

  QueryBuilder<CachedWallet, CachedWallet, QDistinct> distinctByWaiterId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waiterId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedWalletQueryProperty
    on QueryBuilder<CachedWallet, CachedWallet, QQueryProperty> {
  QueryBuilder<CachedWallet, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CachedWallet, int, QQueryOperations> availableBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'availableBalance');
    });
  }

  QueryBuilder<CachedWallet, DateTime, QQueryOperations> cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<CachedWallet, String, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<CachedWallet, int, QQueryOperations> pendingBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingBalance');
    });
  }

  QueryBuilder<CachedWallet, String, QQueryOperations> waiterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waiterId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedWalletTransactionCollection on Isar {
  IsarCollection<CachedWalletTransaction> get cachedWalletTransactions =>
      this.collection();
}

const CachedWalletTransactionSchema = CollectionSchema(
  name: r'CachedWalletTransaction',
  id: 4730917134193700422,
  properties: {
    r'amount': PropertySchema(id: 0, name: r'amount', type: IsarType.long),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currency': PropertySchema(
      id: 2,
      name: r'currency',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'id': PropertySchema(id: 4, name: r'id', type: IsarType.string),
    r'reference': PropertySchema(
      id: 5,
      name: r'reference',
      type: IsarType.string,
    ),
    r'status': PropertySchema(id: 6, name: r'status', type: IsarType.string),
    r'type': PropertySchema(id: 7, name: r'type', type: IsarType.string),
    r'waiterId': PropertySchema(
      id: 8,
      name: r'waiterId',
      type: IsarType.string,
    ),
  },

  estimateSize: _cachedWalletTransactionEstimateSize,
  serialize: _cachedWalletTransactionSerialize,
  deserialize: _cachedWalletTransactionDeserialize,
  deserializeProp: _cachedWalletTransactionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'waiterId': IndexSchema(
      id: 5413859458877949780,
      name: r'waiterId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'waiterId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cachedWalletTransactionGetId,
  getLinks: _cachedWalletTransactionGetLinks,
  attach: _cachedWalletTransactionAttach,
  version: '3.3.2',
);

int _cachedWalletTransactionEstimateSize(
  CachedWalletTransaction object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.currency.length * 3;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.reference;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.type.length * 3;
  bytesCount += 3 + object.waiterId.length * 3;
  return bytesCount;
}

void _cachedWalletTransactionSerialize(
  CachedWalletTransaction object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.currency);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.id);
  writer.writeString(offsets[5], object.reference);
  writer.writeString(offsets[6], object.status);
  writer.writeString(offsets[7], object.type);
  writer.writeString(offsets[8], object.waiterId);
}

CachedWalletTransaction _cachedWalletTransactionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedWalletTransaction();
  object.amount = reader.readLong(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.currency = reader.readString(offsets[2]);
  object.description = reader.readStringOrNull(offsets[3]);
  object.id = reader.readString(offsets[4]);
  object.isarId = id;
  object.reference = reader.readStringOrNull(offsets[5]);
  object.status = reader.readString(offsets[6]);
  object.type = reader.readString(offsets[7]);
  object.waiterId = reader.readString(offsets[8]);
  return object;
}

P _cachedWalletTransactionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedWalletTransactionGetId(CachedWalletTransaction object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cachedWalletTransactionGetLinks(
  CachedWalletTransaction object,
) {
  return [];
}

void _cachedWalletTransactionAttach(
  IsarCollection<dynamic> col,
  Id id,
  CachedWalletTransaction object,
) {
  object.isarId = id;
}

extension CachedWalletTransactionByIndex
    on IsarCollection<CachedWalletTransaction> {
  Future<CachedWalletTransaction?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  CachedWalletTransaction? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<CachedWalletTransaction?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<CachedWalletTransaction?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(CachedWalletTransaction object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(CachedWalletTransaction object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<CachedWalletTransaction> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(
    List<CachedWalletTransaction> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension CachedWalletTransactionQueryWhereSort
    on QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QWhere> {
  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterWhere>
  anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedWalletTransactionQueryWhere
    on
        QueryBuilder<
          CachedWalletTransaction,
          CachedWalletTransaction,
          QWhereClause
        > {
  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterWhereClause
  >
  isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterWhereClause
  >
  isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterWhereClause
  >
  isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterWhereClause
  >
  isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterWhereClause
  >
  isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterWhereClause
  >
  idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'id', value: [id]),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterWhereClause
  >
  idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterWhereClause
  >
  waiterIdEqualTo(String waiterId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'waiterId', value: [waiterId]),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterWhereClause
  >
  waiterIdNotEqualTo(String waiterId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CachedWalletTransactionQueryFilter
    on
        QueryBuilder<
          CachedWalletTransaction,
          CachedWalletTransaction,
          QFilterCondition
        > {
  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  amountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'amount', value: value),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  amountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'amount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  amountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'amount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  amountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'amount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  currencyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  currencyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  currencyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'currency',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'description'),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'description'),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'description',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'description',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  idEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  idLessThan(String value, {bool include = false, bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  idStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  idEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'id',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'reference'),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'reference'),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'reference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'reference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'reference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'reference',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'reference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'reference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'reference',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'reference',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'reference', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  referenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'reference', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  statusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  statusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  statusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  typeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'type',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  typeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  typeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'type',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  waiterIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  waiterIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  waiterIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  waiterIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'waiterId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  waiterIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  waiterIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  waiterIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  waiterIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'waiterId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  waiterIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'waiterId', value: ''),
      );
    });
  }

  QueryBuilder<
    CachedWalletTransaction,
    CachedWalletTransaction,
    QAfterFilterCondition
  >
  waiterIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'waiterId', value: ''),
      );
    });
  }
}

extension CachedWalletTransactionQueryObject
    on
        QueryBuilder<
          CachedWalletTransaction,
          CachedWalletTransaction,
          QFilterCondition
        > {}

extension CachedWalletTransactionQueryLinks
    on
        QueryBuilder<
          CachedWalletTransaction,
          CachedWalletTransaction,
          QFilterCondition
        > {}

extension CachedWalletTransactionQuerySortBy
    on QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QSortBy> {
  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reference', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reference', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  sortByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }
}

extension CachedWalletTransactionQuerySortThenBy
    on
        QueryBuilder<
          CachedWalletTransaction,
          CachedWalletTransaction,
          QSortThenBy
        > {
  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reference', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reference', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QAfterSortBy>
  thenByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }
}

extension CachedWalletTransactionQueryWhereDistinct
    on
        QueryBuilder<
          CachedWalletTransaction,
          CachedWalletTransaction,
          QDistinct
        > {
  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QDistinct>
  distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QDistinct>
  distinctByCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QDistinct>
  distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QDistinct>
  distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QDistinct>
  distinctByReference({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reference', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QDistinct>
  distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QDistinct>
  distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWalletTransaction, CachedWalletTransaction, QDistinct>
  distinctByWaiterId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waiterId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedWalletTransactionQueryProperty
    on
        QueryBuilder<
          CachedWalletTransaction,
          CachedWalletTransaction,
          QQueryProperty
        > {
  QueryBuilder<CachedWalletTransaction, int, QQueryOperations>
  isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CachedWalletTransaction, int, QQueryOperations>
  amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<CachedWalletTransaction, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedWalletTransaction, String, QQueryOperations>
  currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<CachedWalletTransaction, String?, QQueryOperations>
  descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<CachedWalletTransaction, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedWalletTransaction, String?, QQueryOperations>
  referenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reference');
    });
  }

  QueryBuilder<CachedWalletTransaction, String, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<CachedWalletTransaction, String, QQueryOperations>
  typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<CachedWalletTransaction, String, QQueryOperations>
  waiterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waiterId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedNotificationCollection on Isar {
  IsarCollection<CachedNotification> get cachedNotifications =>
      this.collection();
}

const CachedNotificationSchema = CollectionSchema(
  name: r'CachedNotification',
  id: -6832697827717858657,
  properties: {
    r'body': PropertySchema(id: 0, name: r'body', type: IsarType.string),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dataJson': PropertySchema(
      id: 2,
      name: r'dataJson',
      type: IsarType.string,
    ),
    r'id': PropertySchema(id: 3, name: r'id', type: IsarType.string),
    r'isRead': PropertySchema(id: 4, name: r'isRead', type: IsarType.bool),
    r'title': PropertySchema(id: 5, name: r'title', type: IsarType.string),
    r'type': PropertySchema(id: 6, name: r'type', type: IsarType.string),
  },

  estimateSize: _cachedNotificationEstimateSize,
  serialize: _cachedNotificationSerialize,
  deserialize: _cachedNotificationDeserialize,
  deserializeProp: _cachedNotificationDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cachedNotificationGetId,
  getLinks: _cachedNotificationGetLinks,
  attach: _cachedNotificationAttach,
  version: '3.3.2',
);

int _cachedNotificationEstimateSize(
  CachedNotification object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.body.length * 3;
  {
    final value = object.dataJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _cachedNotificationSerialize(
  CachedNotification object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.body);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.dataJson);
  writer.writeString(offsets[3], object.id);
  writer.writeBool(offsets[4], object.isRead);
  writer.writeString(offsets[5], object.title);
  writer.writeString(offsets[6], object.type);
}

CachedNotification _cachedNotificationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedNotification();
  object.body = reader.readString(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.dataJson = reader.readStringOrNull(offsets[2]);
  object.id = reader.readString(offsets[3]);
  object.isRead = reader.readBool(offsets[4]);
  object.isarId = id;
  object.title = reader.readString(offsets[5]);
  object.type = reader.readString(offsets[6]);
  return object;
}

P _cachedNotificationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedNotificationGetId(CachedNotification object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cachedNotificationGetLinks(
  CachedNotification object,
) {
  return [];
}

void _cachedNotificationAttach(
  IsarCollection<dynamic> col,
  Id id,
  CachedNotification object,
) {
  object.isarId = id;
}

extension CachedNotificationByIndex on IsarCollection<CachedNotification> {
  Future<CachedNotification?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  CachedNotification? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<CachedNotification?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<CachedNotification?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(CachedNotification object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(CachedNotification object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<CachedNotification> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(
    List<CachedNotification> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension CachedNotificationQueryWhereSort
    on QueryBuilder<CachedNotification, CachedNotification, QWhere> {
  QueryBuilder<CachedNotification, CachedNotification, QAfterWhere>
  anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedNotificationQueryWhere
    on QueryBuilder<CachedNotification, CachedNotification, QWhereClause> {
  QueryBuilder<CachedNotification, CachedNotification, QAfterWhereClause>
  isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterWhereClause>
  isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterWhereClause>
  isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterWhereClause>
  isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterWhereClause>
  isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterWhereClause>
  idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'id', value: [id]),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterWhereClause>
  idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CachedNotificationQueryFilter
    on QueryBuilder<CachedNotification, CachedNotification, QFilterCondition> {
  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  bodyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'body',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  bodyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'body',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  bodyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'body',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  bodyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'body',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  bodyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'body',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  bodyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'body',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  bodyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'body',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  bodyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'body',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  bodyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'body', value: ''),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  bodyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'body', value: ''),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'dataJson'),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'dataJson'),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'dataJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dataJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dataJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dataJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'dataJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'dataJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'dataJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'dataJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dataJson', value: ''),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  dataJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'dataJson', value: ''),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  idEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  idLessThan(String value, {bool include = false, bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  idStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  idEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'id',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  isReadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isRead', value: value),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  typeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'type',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  typeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  typeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'type',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterFilterCondition>
  typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'type', value: ''),
      );
    });
  }
}

extension CachedNotificationQueryObject
    on QueryBuilder<CachedNotification, CachedNotification, QFilterCondition> {}

extension CachedNotificationQueryLinks
    on QueryBuilder<CachedNotification, CachedNotification, QFilterCondition> {}

extension CachedNotificationQuerySortBy
    on QueryBuilder<CachedNotification, CachedNotification, QSortBy> {
  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByDataJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByDataJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CachedNotificationQuerySortThenBy
    on QueryBuilder<CachedNotification, CachedNotification, QSortThenBy> {
  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByBody() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByBodyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'body', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByDataJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByDataJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataJson', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QAfterSortBy>
  thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension CachedNotificationQueryWhereDistinct
    on QueryBuilder<CachedNotification, CachedNotification, QDistinct> {
  QueryBuilder<CachedNotification, CachedNotification, QDistinct>
  distinctByBody({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'body', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QDistinct>
  distinctByDataJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QDistinct> distinctById({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QDistinct>
  distinctByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRead');
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QDistinct>
  distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedNotification, CachedNotification, QDistinct>
  distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension CachedNotificationQueryProperty
    on QueryBuilder<CachedNotification, CachedNotification, QQueryProperty> {
  QueryBuilder<CachedNotification, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CachedNotification, String, QQueryOperations> bodyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'body');
    });
  }

  QueryBuilder<CachedNotification, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedNotification, String?, QQueryOperations>
  dataJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataJson');
    });
  }

  QueryBuilder<CachedNotification, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedNotification, bool, QQueryOperations> isReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRead');
    });
  }

  QueryBuilder<CachedNotification, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<CachedNotification, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedQrCodeCollection on Isar {
  IsarCollection<CachedQrCode> get cachedQrCodes => this.collection();
}

const CachedQrCodeSchema = CollectionSchema(
  name: r'CachedQrCode',
  id: -995655008021623801,
  properties: {
    r'cachedAt': PropertySchema(
      id: 0,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'qrToken': PropertySchema(id: 1, name: r'qrToken', type: IsarType.string),
    r'url': PropertySchema(id: 2, name: r'url', type: IsarType.string),
    r'waiterId': PropertySchema(
      id: 3,
      name: r'waiterId',
      type: IsarType.string,
    ),
  },

  estimateSize: _cachedQrCodeEstimateSize,
  serialize: _cachedQrCodeSerialize,
  deserialize: _cachedQrCodeDeserialize,
  deserializeProp: _cachedQrCodeDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'waiterId': IndexSchema(
      id: 5413859458877949780,
      name: r'waiterId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'waiterId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cachedQrCodeGetId,
  getLinks: _cachedQrCodeGetLinks,
  attach: _cachedQrCodeAttach,
  version: '3.3.2',
);

int _cachedQrCodeEstimateSize(
  CachedQrCode object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.qrToken.length * 3;
  bytesCount += 3 + object.url.length * 3;
  bytesCount += 3 + object.waiterId.length * 3;
  return bytesCount;
}

void _cachedQrCodeSerialize(
  CachedQrCode object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.cachedAt);
  writer.writeString(offsets[1], object.qrToken);
  writer.writeString(offsets[2], object.url);
  writer.writeString(offsets[3], object.waiterId);
}

CachedQrCode _cachedQrCodeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedQrCode();
  object.cachedAt = reader.readDateTime(offsets[0]);
  object.isarId = id;
  object.qrToken = reader.readString(offsets[1]);
  object.url = reader.readString(offsets[2]);
  object.waiterId = reader.readString(offsets[3]);
  return object;
}

P _cachedQrCodeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedQrCodeGetId(CachedQrCode object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cachedQrCodeGetLinks(CachedQrCode object) {
  return [];
}

void _cachedQrCodeAttach(
  IsarCollection<dynamic> col,
  Id id,
  CachedQrCode object,
) {
  object.isarId = id;
}

extension CachedQrCodeByIndex on IsarCollection<CachedQrCode> {
  Future<CachedQrCode?> getByWaiterId(String waiterId) {
    return getByIndex(r'waiterId', [waiterId]);
  }

  CachedQrCode? getByWaiterIdSync(String waiterId) {
    return getByIndexSync(r'waiterId', [waiterId]);
  }

  Future<bool> deleteByWaiterId(String waiterId) {
    return deleteByIndex(r'waiterId', [waiterId]);
  }

  bool deleteByWaiterIdSync(String waiterId) {
    return deleteByIndexSync(r'waiterId', [waiterId]);
  }

  Future<List<CachedQrCode?>> getAllByWaiterId(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'waiterId', values);
  }

  List<CachedQrCode?> getAllByWaiterIdSync(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'waiterId', values);
  }

  Future<int> deleteAllByWaiterId(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'waiterId', values);
  }

  int deleteAllByWaiterIdSync(List<String> waiterIdValues) {
    final values = waiterIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'waiterId', values);
  }

  Future<Id> putByWaiterId(CachedQrCode object) {
    return putByIndex(r'waiterId', object);
  }

  Id putByWaiterIdSync(CachedQrCode object, {bool saveLinks = true}) {
    return putByIndexSync(r'waiterId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByWaiterId(List<CachedQrCode> objects) {
    return putAllByIndex(r'waiterId', objects);
  }

  List<Id> putAllByWaiterIdSync(
    List<CachedQrCode> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'waiterId', objects, saveLinks: saveLinks);
  }
}

extension CachedQrCodeQueryWhereSort
    on QueryBuilder<CachedQrCode, CachedQrCode, QWhere> {
  QueryBuilder<CachedQrCode, CachedQrCode, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedQrCodeQueryWhere
    on QueryBuilder<CachedQrCode, CachedQrCode, QWhereClause> {
  QueryBuilder<CachedQrCode, CachedQrCode, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterWhereClause> isarIdNotEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterWhereClause> isarIdGreaterThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterWhereClause> isarIdLessThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterWhereClause> waiterIdEqualTo(
    String waiterId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'waiterId', value: [waiterId]),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterWhereClause>
  waiterIdNotEqualTo(String waiterId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CachedQrCodeQueryFilter
    on QueryBuilder<CachedQrCode, CachedQrCode, QFilterCondition> {
  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  cachedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cachedAt', value: value),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  cachedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  cachedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  cachedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cachedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition> isarIdEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  qrTokenEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  qrTokenGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  qrTokenLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  qrTokenBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qrToken',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  qrTokenStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  qrTokenEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  qrTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'qrToken',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  qrTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'qrToken',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  qrTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'qrToken', value: ''),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  qrTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'qrToken', value: ''),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'url',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition> urlContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'url',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition> urlMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'url',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'url', value: ''),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'url', value: ''),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  waiterIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  waiterIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  waiterIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  waiterIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'waiterId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  waiterIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  waiterIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  waiterIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  waiterIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'waiterId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  waiterIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'waiterId', value: ''),
      );
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterFilterCondition>
  waiterIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'waiterId', value: ''),
      );
    });
  }
}

extension CachedQrCodeQueryObject
    on QueryBuilder<CachedQrCode, CachedQrCode, QFilterCondition> {}

extension CachedQrCodeQueryLinks
    on QueryBuilder<CachedQrCode, CachedQrCode, QFilterCondition> {}

extension CachedQrCodeQuerySortBy
    on QueryBuilder<CachedQrCode, CachedQrCode, QSortBy> {
  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> sortByQrToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrToken', Sort.asc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> sortByQrTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrToken', Sort.desc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> sortByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> sortByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }
}

extension CachedQrCodeQuerySortThenBy
    on QueryBuilder<CachedQrCode, CachedQrCode, QSortThenBy> {
  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> thenByQrToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrToken', Sort.asc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> thenByQrTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrToken', Sort.desc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> thenByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QAfterSortBy> thenByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }
}

extension CachedQrCodeQueryWhereDistinct
    on QueryBuilder<CachedQrCode, CachedQrCode, QDistinct> {
  QueryBuilder<CachedQrCode, CachedQrCode, QDistinct> distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QDistinct> distinctByQrToken({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrToken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QDistinct> distinctByUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedQrCode, CachedQrCode, QDistinct> distinctByWaiterId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waiterId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedQrCodeQueryProperty
    on QueryBuilder<CachedQrCode, CachedQrCode, QQueryProperty> {
  QueryBuilder<CachedQrCode, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CachedQrCode, DateTime, QQueryOperations> cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<CachedQrCode, String, QQueryOperations> qrTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrToken');
    });
  }

  QueryBuilder<CachedQrCode, String, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }

  QueryBuilder<CachedQrCode, String, QQueryOperations> waiterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waiterId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedCampaignCollection on Isar {
  IsarCollection<CachedCampaign> get cachedCampaigns => this.collection();
}

const CachedCampaignSchema = CollectionSchema(
  name: r'CachedCampaign',
  id: -5899067644255496046,
  properties: {
    r'cachedAt': PropertySchema(
      id: 0,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currency': PropertySchema(
      id: 3,
      name: r'currency',
      type: IsarType.string,
    ),
    r'currentAmount': PropertySchema(
      id: 4,
      name: r'currentAmount',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 5,
      name: r'description',
      type: IsarType.string,
    ),
    r'emoji': PropertySchema(id: 6, name: r'emoji', type: IsarType.string),
    r'endDate': PropertySchema(
      id: 7,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'id': PropertySchema(id: 8, name: r'id', type: IsarType.string),
    r'isActive': PropertySchema(id: 9, name: r'isActive', type: IsarType.bool),
    r'startDate': PropertySchema(
      id: 10,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'targetAmount': PropertySchema(
      id: 11,
      name: r'targetAmount',
      type: IsarType.long,
    ),
    r'tipsCount': PropertySchema(
      id: 12,
      name: r'tipsCount',
      type: IsarType.long,
    ),
    r'title': PropertySchema(id: 13, name: r'title', type: IsarType.string),
    r'updatedAt': PropertySchema(
      id: 14,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'waiterId': PropertySchema(
      id: 15,
      name: r'waiterId',
      type: IsarType.string,
    ),
  },

  estimateSize: _cachedCampaignEstimateSize,
  serialize: _cachedCampaignSerialize,
  deserialize: _cachedCampaignDeserialize,
  deserializeProp: _cachedCampaignDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'waiterId': IndexSchema(
      id: 5413859458877949780,
      name: r'waiterId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'waiterId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cachedCampaignGetId,
  getLinks: _cachedCampaignGetLinks,
  attach: _cachedCampaignAttach,
  version: '3.3.2',
);

int _cachedCampaignEstimateSize(
  CachedCampaign object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.currency.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.emoji.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.waiterId.length * 3;
  return bytesCount;
}

void _cachedCampaignSerialize(
  CachedCampaign object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.cachedAt);
  writer.writeString(offsets[1], object.category);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.currency);
  writer.writeLong(offsets[4], object.currentAmount);
  writer.writeString(offsets[5], object.description);
  writer.writeString(offsets[6], object.emoji);
  writer.writeDateTime(offsets[7], object.endDate);
  writer.writeString(offsets[8], object.id);
  writer.writeBool(offsets[9], object.isActive);
  writer.writeDateTime(offsets[10], object.startDate);
  writer.writeLong(offsets[11], object.targetAmount);
  writer.writeLong(offsets[12], object.tipsCount);
  writer.writeString(offsets[13], object.title);
  writer.writeDateTime(offsets[14], object.updatedAt);
  writer.writeString(offsets[15], object.waiterId);
}

CachedCampaign _cachedCampaignDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedCampaign();
  object.cachedAt = reader.readDateTime(offsets[0]);
  object.category = reader.readString(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.currency = reader.readString(offsets[3]);
  object.currentAmount = reader.readLong(offsets[4]);
  object.description = reader.readString(offsets[5]);
  object.emoji = reader.readString(offsets[6]);
  object.endDate = reader.readDateTimeOrNull(offsets[7]);
  object.id = reader.readString(offsets[8]);
  object.isActive = reader.readBool(offsets[9]);
  object.isarId = id;
  object.startDate = reader.readDateTime(offsets[10]);
  object.targetAmount = reader.readLongOrNull(offsets[11]);
  object.tipsCount = reader.readLong(offsets[12]);
  object.title = reader.readString(offsets[13]);
  object.updatedAt = reader.readDateTime(offsets[14]);
  object.waiterId = reader.readString(offsets[15]);
  return object;
}

P _cachedCampaignDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readDateTime(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedCampaignGetId(CachedCampaign object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cachedCampaignGetLinks(CachedCampaign object) {
  return [];
}

void _cachedCampaignAttach(
  IsarCollection<dynamic> col,
  Id id,
  CachedCampaign object,
) {
  object.isarId = id;
}

extension CachedCampaignByIndex on IsarCollection<CachedCampaign> {
  Future<CachedCampaign?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  CachedCampaign? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<CachedCampaign?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<CachedCampaign?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(CachedCampaign object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(CachedCampaign object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<CachedCampaign> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(
    List<CachedCampaign> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension CachedCampaignQueryWhereSort
    on QueryBuilder<CachedCampaign, CachedCampaign, QWhere> {
  QueryBuilder<CachedCampaign, CachedCampaign, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedCampaignQueryWhere
    on QueryBuilder<CachedCampaign, CachedCampaign, QWhereClause> {
  QueryBuilder<CachedCampaign, CachedCampaign, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterWhereClause>
  isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterWhereClause>
  isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterWhereClause>
  isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterWhereClause> idEqualTo(
    String id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'id', value: [id]),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterWhereClause> idNotEqualTo(
    String id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterWhereClause>
  waiterIdEqualTo(String waiterId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'waiterId', value: [waiterId]),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterWhereClause>
  waiterIdNotEqualTo(String waiterId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [waiterId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'waiterId',
                lower: [],
                upper: [waiterId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CachedCampaignQueryFilter
    on QueryBuilder<CachedCampaign, CachedCampaign, QFilterCondition> {
  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  cachedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cachedAt', value: value),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  cachedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  cachedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cachedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  cachedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cachedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  categoryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'category',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  categoryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  categoryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'category',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currencyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currencyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currencyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'currency',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currentAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currentAmount', value: value),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currentAmountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currentAmount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currentAmountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currentAmount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  currentAmountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currentAmount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  descriptionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'description',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  descriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'description',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  emojiEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'emoji',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  emojiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'emoji',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  emojiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'emoji',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  emojiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'emoji',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  emojiStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'emoji',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  emojiEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'emoji',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  emojiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'emoji',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  emojiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'emoji',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  emojiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'emoji', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  emojiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'emoji', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  endDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'endDate'),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  endDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'endDate'),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  endDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endDate', value: value),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  endDateGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  endDateLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  endDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  idLessThan(String value, {bool include = false, bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  idStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  idEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition> idMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'id',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isActive', value: value),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  startDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startDate', value: value),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  startDateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  startDateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  targetAmountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'targetAmount'),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  targetAmountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'targetAmount'),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  targetAmountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'targetAmount', value: value),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  targetAmountGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'targetAmount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  targetAmountLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'targetAmount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  targetAmountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'targetAmount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  tipsCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tipsCount', value: value),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  tipsCountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tipsCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  tipsCountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tipsCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  tipsCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tipsCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  titleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'title',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  titleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  titleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'title',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'title',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'title', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  waiterIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  waiterIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  waiterIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  waiterIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'waiterId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  waiterIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  waiterIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  waiterIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'waiterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  waiterIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'waiterId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  waiterIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'waiterId', value: ''),
      );
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterFilterCondition>
  waiterIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'waiterId', value: ''),
      );
    });
  }
}

extension CachedCampaignQueryObject
    on QueryBuilder<CachedCampaign, CachedCampaign, QFilterCondition> {}

extension CachedCampaignQueryLinks
    on QueryBuilder<CachedCampaign, CachedCampaign, QFilterCondition> {}

extension CachedCampaignQuerySortBy
    on QueryBuilder<CachedCampaign, CachedCampaign, QSortBy> {
  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByCurrentAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentAmount', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByCurrentAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentAmount', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByTargetAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByTipsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipsCount', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByTipsCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipsCount', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> sortByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  sortByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }
}

extension CachedCampaignQuerySortThenBy
    on QueryBuilder<CachedCampaign, CachedCampaign, QSortThenBy> {
  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByCurrentAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentAmount', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByCurrentAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentAmount', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emoji', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByTargetAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetAmount', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByTipsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipsCount', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByTipsCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipsCount', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy> thenByWaiterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.asc);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QAfterSortBy>
  thenByWaiterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waiterId', Sort.desc);
    });
  }
}

extension CachedCampaignQueryWhereDistinct
    on QueryBuilder<CachedCampaign, CachedCampaign, QDistinct> {
  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct> distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct> distinctByCategory({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct> distinctByCurrency({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct>
  distinctByCurrentAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentAmount');
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct>
  distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct> distinctByEmoji({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emoji', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct> distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct> distinctById({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct>
  distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct>
  distinctByTargetAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetAmount');
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct>
  distinctByTipsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipsCount');
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct> distinctByTitle({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<CachedCampaign, CachedCampaign, QDistinct> distinctByWaiterId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waiterId', caseSensitive: caseSensitive);
    });
  }
}

extension CachedCampaignQueryProperty
    on QueryBuilder<CachedCampaign, CachedCampaign, QQueryProperty> {
  QueryBuilder<CachedCampaign, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CachedCampaign, DateTime, QQueryOperations> cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<CachedCampaign, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<CachedCampaign, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedCampaign, String, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<CachedCampaign, int, QQueryOperations> currentAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentAmount');
    });
  }

  QueryBuilder<CachedCampaign, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<CachedCampaign, String, QQueryOperations> emojiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emoji');
    });
  }

  QueryBuilder<CachedCampaign, DateTime?, QQueryOperations> endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<CachedCampaign, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedCampaign, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<CachedCampaign, DateTime, QQueryOperations> startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<CachedCampaign, int?, QQueryOperations> targetAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetAmount');
    });
  }

  QueryBuilder<CachedCampaign, int, QQueryOperations> tipsCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipsCount');
    });
  }

  QueryBuilder<CachedCampaign, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<CachedCampaign, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<CachedCampaign, String, QQueryOperations> waiterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waiterId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedWithdrawalCollection on Isar {
  IsarCollection<CachedWithdrawal> get cachedWithdrawals => this.collection();
}

const CachedWithdrawalSchema = CollectionSchema(
  name: r'CachedWithdrawal',
  id: 4899395751707619416,
  properties: {
    r'amount': PropertySchema(id: 0, name: r'amount', type: IsarType.long),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currency': PropertySchema(
      id: 2,
      name: r'currency',
      type: IsarType.string,
    ),
    r'failureReason': PropertySchema(
      id: 3,
      name: r'failureReason',
      type: IsarType.string,
    ),
    r'id': PropertySchema(id: 4, name: r'id', type: IsarType.string),
    r'paymentAccountId': PropertySchema(
      id: 5,
      name: r'paymentAccountId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(id: 6, name: r'status', type: IsarType.string),
  },

  estimateSize: _cachedWithdrawalEstimateSize,
  serialize: _cachedWithdrawalSerialize,
  deserialize: _cachedWithdrawalDeserialize,
  deserializeProp: _cachedWithdrawalDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _cachedWithdrawalGetId,
  getLinks: _cachedWithdrawalGetLinks,
  attach: _cachedWithdrawalAttach,
  version: '3.3.2',
);

int _cachedWithdrawalEstimateSize(
  CachedWithdrawal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.currency.length * 3;
  {
    final value = object.failureReason;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.paymentAccountId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _cachedWithdrawalSerialize(
  CachedWithdrawal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.currency);
  writer.writeString(offsets[3], object.failureReason);
  writer.writeString(offsets[4], object.id);
  writer.writeString(offsets[5], object.paymentAccountId);
  writer.writeString(offsets[6], object.status);
}

CachedWithdrawal _cachedWithdrawalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedWithdrawal();
  object.amount = reader.readLong(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.currency = reader.readString(offsets[2]);
  object.failureReason = reader.readStringOrNull(offsets[3]);
  object.id = reader.readString(offsets[4]);
  object.isarId = id;
  object.paymentAccountId = reader.readStringOrNull(offsets[5]);
  object.status = reader.readString(offsets[6]);
  return object;
}

P _cachedWithdrawalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedWithdrawalGetId(CachedWithdrawal object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cachedWithdrawalGetLinks(CachedWithdrawal object) {
  return [];
}

void _cachedWithdrawalAttach(
  IsarCollection<dynamic> col,
  Id id,
  CachedWithdrawal object,
) {
  object.isarId = id;
}

extension CachedWithdrawalByIndex on IsarCollection<CachedWithdrawal> {
  Future<CachedWithdrawal?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  CachedWithdrawal? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<CachedWithdrawal?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<CachedWithdrawal?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(CachedWithdrawal object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(CachedWithdrawal object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<CachedWithdrawal> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(
    List<CachedWithdrawal> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension CachedWithdrawalQueryWhereSort
    on QueryBuilder<CachedWithdrawal, CachedWithdrawal, QWhere> {
  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedWithdrawalQueryWhere
    on QueryBuilder<CachedWithdrawal, CachedWithdrawal, QWhereClause> {
  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterWhereClause>
  isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterWhereClause>
  isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterWhereClause>
  isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterWhereClause>
  isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterWhereClause>
  isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterWhereClause> idEqualTo(
    String id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'id', value: [id]),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterWhereClause>
  idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension CachedWithdrawalQueryFilter
    on QueryBuilder<CachedWithdrawal, CachedWithdrawal, QFilterCondition> {
  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  amountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'amount', value: value),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  amountGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'amount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  amountLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'amount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  amountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'amount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  currencyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'currency',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  currencyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  currencyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'currency',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'currency',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'currency', value: ''),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'failureReason'),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'failureReason'),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'failureReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'failureReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'failureReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'failureReason',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'failureReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'failureReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'failureReason',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'failureReason',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'failureReason', value: ''),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  failureReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'failureReason', value: ''),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  idEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  idLessThan(String value, {bool include = false, bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  idStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  idEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'id',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'id',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'id', value: ''),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'paymentAccountId'),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'paymentAccountId'),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'paymentAccountId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'paymentAccountId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'paymentAccountId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'paymentAccountId', value: ''),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  paymentAccountIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'paymentAccountId', value: ''),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  statusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  statusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  statusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'status',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'status',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: ''),
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterFilterCondition>
  statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'status', value: ''),
      );
    });
  }
}

extension CachedWithdrawalQueryObject
    on QueryBuilder<CachedWithdrawal, CachedWithdrawal, QFilterCondition> {}

extension CachedWithdrawalQueryLinks
    on QueryBuilder<CachedWithdrawal, CachedWithdrawal, QFilterCondition> {}

extension CachedWithdrawalQuerySortBy
    on QueryBuilder<CachedWithdrawal, CachedWithdrawal, QSortBy> {
  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByFailureReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureReason', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByFailureReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureReason', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByPaymentAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountId', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByPaymentAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountId', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension CachedWithdrawalQuerySortThenBy
    on QueryBuilder<CachedWithdrawal, CachedWithdrawal, QSortThenBy> {
  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByFailureReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureReason', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByFailureReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'failureReason', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByPaymentAccountId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountId', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByPaymentAccountIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentAccountId', Sort.desc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension CachedWithdrawalQueryWhereDistinct
    on QueryBuilder<CachedWithdrawal, CachedWithdrawal, QDistinct> {
  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QDistinct>
  distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QDistinct>
  distinctByCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QDistinct>
  distinctByFailureReason({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'failureReason',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QDistinct> distinctById({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QDistinct>
  distinctByPaymentAccountId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'paymentAccountId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CachedWithdrawal, CachedWithdrawal, QDistinct> distinctByStatus({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }
}

extension CachedWithdrawalQueryProperty
    on QueryBuilder<CachedWithdrawal, CachedWithdrawal, QQueryProperty> {
  QueryBuilder<CachedWithdrawal, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CachedWithdrawal, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<CachedWithdrawal, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CachedWithdrawal, String, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<CachedWithdrawal, String?, QQueryOperations>
  failureReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'failureReason');
    });
  }

  QueryBuilder<CachedWithdrawal, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedWithdrawal, String?, QQueryOperations>
  paymentAccountIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentAccountId');
    });
  }

  QueryBuilder<CachedWithdrawal, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
