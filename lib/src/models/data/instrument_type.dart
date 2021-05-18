enum InstrumentType { stock, currency, bond, etf }

extension InstrumentTypeExtension on InstrumentType {
  String get name => toString().split('.').last;
}

const _defaultInstrumentTypeKey = 'instrumentType';

class InstrumentTypeConverter {
  static const _data = <String, InstrumentType>{
    'Stock': InstrumentType.stock,
    'Currency': InstrumentType.currency,
    'Bond': InstrumentType.bond,
    'Etf': InstrumentType.etf,
  };

  const InstrumentTypeConverter();

  InstrumentType convert(String value) => _data[value]!;

  InstrumentType fromJson(Map<String, dynamic> data,
          [String key = _defaultInstrumentTypeKey]) =>
      convert(data[key] as String);
}

extension InstrumentTypeFromJsonExtension on Map<String, dynamic> {
  InstrumentType requireInstrumentType(
          [String key = _defaultInstrumentTypeKey]) =>
      const InstrumentTypeConverter().fromJson(this, key);

  InstrumentType? optionalInstrumentType(
          [String key = _defaultInstrumentTypeKey]) =>
      this[key] != null
          ? const InstrumentTypeConverter().fromJson(this, key)
          : null;
}
