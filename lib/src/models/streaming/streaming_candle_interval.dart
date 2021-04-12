const _defaultCandleIntervalKey = 'interval';

/// Интервалы свечи.
///
/// Используются для streaming протокола.
/// Для данных из REST протокола есть очень похожий
/// [CandleResolution], но у него немного отличается
/// набор значений.
enum StreamingCandleInterval {
  /// 1 minute
  oneMin,

  /// 2 minutes
  twoMin,

  /// 3 minutes
  threeMin,

  /// 5 minutes
  fiveMin,

  /// 10 minutes
  tenMin,

  /// 15 minutes
  fifteenMin,

  /// 30 minutes
  thirtyMin,

  /// 1 hour
  hour,

  /// 2 hours
  twoHour,

  /// 4 hours
  fourHour,

  /// 1 day
  day,

  /// 7 days
  week,

  /// 1 month
  month,
}

class StreamingCandleIntervalConverter {
  static const _data = {
    '1min': StreamingCandleInterval.oneMin,
    '2min': StreamingCandleInterval.twoMin,
    '3min': StreamingCandleInterval.threeMin,
    '5min': StreamingCandleInterval.fiveMin,
    '10min': StreamingCandleInterval.tenMin,
    '15min': StreamingCandleInterval.fifteenMin,
    '30min': StreamingCandleInterval.thirtyMin,
    'hour': StreamingCandleInterval.hour,
    '2hour': StreamingCandleInterval.twoHour,
    '4hour': StreamingCandleInterval.fourHour,
    'day': StreamingCandleInterval.day,
    'week': StreamingCandleInterval.week,
    'month': StreamingCandleInterval.month,
  };

  const StreamingCandleIntervalConverter();

  StreamingCandleInterval convert(String value) => _data[value]!;

  StreamingCandleInterval fromJson(Map<String, dynamic> data,
          [String key = _defaultCandleIntervalKey]) =>
      convert(data[key] as String);

  String toJson(StreamingCandleInterval value) =>
      _data.keys.firstWhere((e) => _data[e] == value);
}

StreamingCandleInterval candleIntervalFromJson(Map<String, dynamic> data,
        [String key = _defaultCandleIntervalKey]) =>
    const StreamingCandleIntervalConverter().fromJson(data, key);

extension CandleIntervalFromJsonExtension on Map<String, dynamic> {
  StreamingCandleInterval requireCandleInterval(
          [String key = _defaultCandleIntervalKey]) =>
      const StreamingCandleIntervalConverter().fromJson(this, key);
}

extension CandleIntervalExtension on StreamingCandleInterval {
  String toJson() => const StreamingCandleIntervalConverter().toJson(this);
}
