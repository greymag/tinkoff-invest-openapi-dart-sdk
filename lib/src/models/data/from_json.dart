List<T> listFromJson<T>(Map<String, dynamic> data, String key,
        T Function(Map<String, dynamic> data) itemFromJson) =>
    (data[key] as List).cast<Map<String, dynamic>>().map(itemFromJson).toList();

double doubleFromJson(Map<String, dynamic> data, String key) =>
    (data[key] as num).toDouble();

double? doubleOrNullFromJson(Map<String, dynamic> data, String key) =>
    (data[key] as num?)?.toDouble();
