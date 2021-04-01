const _defaultCandleResolutionKey = 'interval';

/// Интервалы свечи.
///
/// В описании каждого значения указывается
/// интервал свечи и допустимый промежуток запроса.
enum CandleResolution {
  /// 1 minute, 1 day
  oneMin,

  /// 2 minutes, 1 day
  twoMin,

  /// 3 minutes, 1 day
  threeMin,

  /// 5 minutes, 1 day
  fiveMin,

  /// 10 minutes, 1 day
  tenMin,

  /// 15 minutes, 1 day
  fifteenMin,

  /// 30 minutes, 1 day
  thirtyMin,

  /// 1 hour, 7 days
  hour,

  /// 1 day, 1 year
  day,

  /// 7 days, 2 years
  week,

  /// 1 month, 10 years
  month,
}

class CandleResolutionConverter {
  static const _data = {
    '1min': CandleResolution.oneMin,
    '2min': CandleResolution.twoMin,
    '3min': CandleResolution.threeMin,
    '5min': CandleResolution.fiveMin,
    '10min': CandleResolution.tenMin,
    '15min': CandleResolution.fifteenMin,
    '30min': CandleResolution.thirtyMin,
    'hour': CandleResolution.hour,
    'day': CandleResolution.day,
    'week': CandleResolution.week,
    'month': CandleResolution.month,
  };

  const CandleResolutionConverter();

  CandleResolution convert(String value) => _data[value]!;

  CandleResolution fromJson(Map<String, dynamic> data,
          [String key = _defaultCandleResolutionKey]) =>
      convert(data[key] as String);

  String toJson(CandleResolution value) =>
      _data.keys.firstWhere((e) => _data[e] == value);
}

CandleResolution candleResolutionFromJson(Map<String, dynamic> data,
        [String key = _defaultCandleResolutionKey]) =>
    const CandleResolutionConverter().fromJson(data, key);

extension CandleResolutionFromJsonExtension on Map<String, dynamic> {
  CandleResolution requireCandleResolution(
          [String key = _defaultCandleResolutionKey]) =>
      const CandleResolutionConverter().fromJson(this, key);
}

extension CandleResolutionExtension on CandleResolution {
  String toJson() => const CandleResolutionConverter().toJson(this);
}
