part of http_client;

/// Shorthand for `Map<String, dynamic>`.
/// Default type for map-like objects received from API calls.
typedef JsonMap = Map<String, dynamic>;

/// Shorthand for `List<dynamic>`.
/// Default type for list-like objects received from API calls.
typedef JsonList = List<dynamic>;

/// Shorthand for `Set<dynamic>`.
/// Default type for set-like objects received from API calls.
typedef JsonSet = Set<dynamic>;

/// Shorthand for `dynamic Function(T)`.
typedef ToJson<T> = dynamic Function(T object);

/// Shorthand for `T Function(dynamic)`.
typedef FromJson<T> = T Function(dynamic json);

/// Shorthand for `Map<String, dynamic> Function(T)`.
typedef ToJsonMap<T> = JsonMap Function(T object);

/// Shorthand for `T Function(Map<String, dynamic>)`.
typedef FromJsonMap<T> = T Function(JsonMap map);

/// Shorthand for `List<dynamic> Function(T)`.
typedef ToJsonList<T> = JsonList Function(T object);

/// Shorthand for `T Function(List<dynamic>)`.
typedef FromJsonList<T> = T Function(JsonList list);

/// Shorthand for `Set<dynamic> Function(T)`.
typedef ToJsonSet<T> = JsonSet Function(T object);

/// Shorthand for `T Function(Set<dynamic>)`.
typedef FromJsonSet<T> = T Function(JsonSet set);

/// Check if the type parameter is a json primitive
/// (Null, int, double, num, bool, String, List<dynamic>, Set<dynamic> or Map<String, dynamic)
bool _isJsonPrimitive<Type>() {
  return Type == dynamic ||
      Type == Null ||
      Type == int ||
      Type == double ||
      Type == num ||
      Type == bool ||
      Type == String ||
      _isSubtype<Type, JsonList>() ||
      _isSubtype<Type, JsonSet>() ||
      _isSubtype<Type, JsonMap>();
}

/// Checks if a type is a subttype of another.
/// Used for cases when the request body is Map<String, Object?> and must be compared to Map<String, dynamic>.
///
/// Solution from:
/// https://stackoverflow.com/questions/69106346/how-to-check-if-a-type-is-a-subtype-of-another-in-dart
bool _isSubtype<SubType, Type>() => <SubType>[] is List<Type>;

/// Checks if a type is nullable.
///
/// Solution from:
/// https://stackoverflow.com/questions/66240962/how-do-i-check-whether-a-generic-type-is-nullable-in-dart-nnbd
// bool _isNullable<Type>() => null is Type;
