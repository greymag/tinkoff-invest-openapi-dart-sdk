const _defaultTradeStatusKey = 'tradeStatus';

enum TradeStatus {
  normalTrading,
  notAvailableForTrading,
}

class TradeStatusConverter {
  static const _data = {
    'NormalTrading': TradeStatus.normalTrading,
    'NotAvailableForTrading': TradeStatus.notAvailableForTrading,
  };

  const TradeStatusConverter();

  TradeStatus convert(String value) => _data[value]!;

  TradeStatus fromJson(Map<String, dynamic> data,
          [String key = _defaultTradeStatusKey]) =>
      convert(data[key] as String);
}

TradeStatus tradeStatusFromJson(Map<String, dynamic> data,
        [String key = _defaultTradeStatusKey]) =>
    const TradeStatusConverter().fromJson(data, key);

extension TradeStatusFromJsonExtension on Map<String, dynamic> {
  TradeStatus requireTradeStatus([String key = _defaultTradeStatusKey]) =>
      const TradeStatusConverter().fromJson(this, key);
}

extension TradeStatusExtension on TradeStatus {
  String get name => toString().split('.').last;
}
