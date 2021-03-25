enum OperationStatus { done, decline, progress }

const _defaultStatusKey = 'status';

class OperationStatusConverter {
  static const _data = <String, OperationStatus>{
    'Done': OperationStatus.done,
    'Decline': OperationStatus.decline,
    'Progress': OperationStatus.progress,
  };

  const OperationStatusConverter();

  OperationStatus convert(String value) => _data[value]!;

  OperationStatus fromJson(Map<String, dynamic> data,
          [String key = _defaultStatusKey]) =>
      convert(data[key] as String);
}

OperationStatus statusFromJson(Map<String, dynamic> data,
        [String key = _defaultStatusKey]) =>
    const OperationStatusConverter().fromJson(data, key);

extension OperationStatusFromJsonExtension on Map<String, dynamic> {
  OperationStatus requireOperationStatus([String key = _defaultStatusKey]) =>
      const OperationStatusConverter().fromJson(this, key);
}
