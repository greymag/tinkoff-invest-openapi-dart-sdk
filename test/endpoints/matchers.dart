import 'package:test/test.dart';
import 'package:tinkoff_invest/src/models/data/data.dart';
import 'package:tinkoff_invest/src/models/response/error_response.dart';

class ErrorResponseMatcher extends Matcher {
  final String trackingId;
  final String status;
  final String message;
  final String code;

  ErrorResponseMatcher(
      {required this.trackingId,
      required this.message,
      required this.code,
      this.status = 'Error'});

  @override
  Description describe(Description description) {
    return description.add(
        'ErrorResponse:<ErrorResponse(trackingId: $trackingId, '
        'status: $status, payload: ErrorData(code: $code, message: $message))>');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! ErrorResponse) return false;

    return item.trackingId == trackingId &&
        item.status == status &&
        item.payload.code == code &&
        item.payload.message == message;
  }

  @override
  Description describeMismatch(Object? item, Description mismatchDescription,
      Map matchState, bool verbose) {
    if (item is! ErrorResponse) {
      return mismatchDescription.add("is not an instance of 'ErrorResponse'");
    }

    final mismatch = <String>[
      if (item.trackingId != trackingId) 'trackingId',
      if (item.status != status) 'status',
      if (item.payload.code != code) 'payload.code',
      if (item.payload.message != message) 'payload.message',
    ];

    return mismatchDescription.add("Has mismatched ${mismatch.join(', ')}");
  }
}

class CurrencyPositionMatcher extends Matcher {
  final Currency currency;
  final double balance;
  final double? blocked;

  CurrencyPositionMatcher(this.currency, this.balance, [this.blocked]);

  @override
  Description describe(Description description) {
    return description
        .add('CurrencyPosition:<CurrencyPosition(currency: $currency, '
            'balance: $balance, blocked: $blocked)>');
  }

  @override
  bool matches(Object? item, Map matchState) {
    if (item is! CurrencyPosition) return false;

    return item.currency == currency &&
        item.balance == balance &&
        item.blocked == blocked;
  }

  @override
  Description describeMismatch(Object? item, Description mismatchDescription,
      Map matchState, bool verbose) {
    if (item is! CurrencyPosition) {
      return mismatchDescription
          .add("is not an instance of 'CurrencyPosition'");
    }

    final mismatch = <String>[
      if (item.currency != currency) 'currency',
      if (item.balance != balance) 'balance',
      if (item.blocked != blocked) 'blocked',
    ];

    return mismatchDescription.add("Has mismatched ${mismatch.join(', ')}");
  }
}
