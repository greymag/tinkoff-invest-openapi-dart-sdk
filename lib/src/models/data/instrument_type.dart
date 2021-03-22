enum InstrumentType { stock, currency, bond, etf }

class InstrumentTypeConverter {
  static const _data = <String, InstrumentType>{
    'Stock': InstrumentType.stock,
    'Currency': InstrumentType.currency,
    'Bond': InstrumentType.bond,
    'Etf': InstrumentType.etf,
  };

  const InstrumentTypeConverter();

  InstrumentType convert(String value) => _data[value]!;
}
