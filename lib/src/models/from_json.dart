List<T> listFromJson<T>(Map<String, dynamic> data, String key,
        T Function(Map<String, dynamic> data) itemFromJson) =>
    (data[key] as List).cast<Map<String, dynamic>>().map(itemFromJson).toList();

double doubleFromJson(Map<String, dynamic> data, String key) =>
    (data[key] as num).toDouble();

double? doubleOrNullFromJson(Map<String, dynamic> data, String key) =>
    (data[key] as num?)?.toDouble();

int intFromJson(Map<String, dynamic> data, String key) =>
    (data[key] as num).toInt();

int? intOrNullFromJson(Map<String, dynamic> data, String key) =>
    (data[key] as num?)?.toInt();

DateTime dateTimeFromJson(Map<String, dynamic> data, String key) =>
    DateTime.parse(data[key] as String).toLocal();

extension FromJsonExtension on Map<String, dynamic> {
  bool requireBool(String key) => this[key] as bool;

  double requireDouble(String key) => doubleFromJson(this, key);

  double? optionalDouble(String key) => doubleOrNullFromJson(this, key);

  int requireInt(String key) => intFromJson(this, key);

  int? optionalInt(String key) => intOrNullFromJson(this, key);

  DateTime requireDateTime(String key) => dateTimeFromJson(this, key);

  List<T> requireList<T>(
          String key, T Function(Map<String, dynamic> data) itemFromJson) =>
      listFromJson(this, key, itemFromJson);

  List<T>? optionalList<T>(
          String key, T Function(Map<String, dynamic> data) itemFromJson) =>
      this[key] != null ? listFromJson(this, key, itemFromJson) : null;

  T? optional<T>(String key, T Function(Map<String, dynamic> data) fromJson) =>
      this[key] != null ? fromJson(this[key] as Map<String, dynamic>) : null;
}
