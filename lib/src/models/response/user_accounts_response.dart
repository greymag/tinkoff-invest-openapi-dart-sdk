import 'package:tinkoff_invest/src/models/data/data.dart';

import 'response.dart';

class UserAccountsResponse extends StdResponse<UserAccounts> {
  UserAccountsResponse(String trackingId, String status, UserAccounts payload)
      : super(trackingId, status, payload);

  factory UserAccountsResponse.fromJson(Map<String, dynamic> data) =>
      UserAccountsResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        UserAccounts.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'UserAccountsResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
