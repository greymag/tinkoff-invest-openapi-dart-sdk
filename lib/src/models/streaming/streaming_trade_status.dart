const _defaultTradeStatusKey = 'trade_status';

/// Статус торгов.
///
/// Используются для streaming протокола.
enum StreamingTradeStatus {
  /// Торги приостановлены.
  breakInTrading,

  /// Торги идут.
  normalTrading,

  /// Торги не идут.
  notAvailableForTrading,

  /// Торги в аукционе закрытия.
  closingAuction,

  /// Торги в периоде закрытия.
  closingPeriod,

  /// Торги в дискретном аукционе.
  discreteAuction,

  /// Торги в аукционе открытия.
  openingPeriod,

  /// Торги по цене аукциона закрытия.
  tradingAtClosingAuctionPrice,
}

class StreamingTradeStatusConverter {
  static const _data = {
    'break_in_trading': StreamingTradeStatus.breakInTrading,
    'normal_trading': StreamingTradeStatus.normalTrading,
    'not_available_for_trading': StreamingTradeStatus.notAvailableForTrading,
    'closing_auction': StreamingTradeStatus.closingAuction,
    'closing_period': StreamingTradeStatus.closingPeriod,
    'discrete_auction': StreamingTradeStatus.discreteAuction,
    'opening_period': StreamingTradeStatus.openingPeriod,
    'trading_at_closing_auction_price':
        StreamingTradeStatus.tradingAtClosingAuctionPrice,
  };

  const StreamingTradeStatusConverter();

  StreamingTradeStatus convert(String value) => _data[value]!;

  StreamingTradeStatus fromJson(Map<String, dynamic> data,
          [String key = _defaultTradeStatusKey]) =>
      convert(data[key] as String);

  String toJson(StreamingTradeStatus value) =>
      _data.keys.firstWhere((e) => _data[e] == value);
}

StreamingTradeStatus streamingTradeStatusFromJson(Map<String, dynamic> data,
        [String key = _defaultTradeStatusKey]) =>
    const StreamingTradeStatusConverter().fromJson(data, key);

extension StreamingTradeStatusFromJsonExtension on Map<String, dynamic> {
  StreamingTradeStatus requireStreamingTradeStatus(
          [String key = _defaultTradeStatusKey]) =>
      const StreamingTradeStatusConverter().fromJson(this, key);
}

extension StreamingTradeStatusExtension on StreamingTradeStatus {
  String get name => toString().split('.').last;

  String toJson() => const StreamingTradeStatusConverter().toJson(this);
}
