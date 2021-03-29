import 'package:tinkoff_invest/src/models/data/sandbox_account.dart';

import 'response.dart';

class SandboxRegisterResponse extends StdResponse<SandboxAccount> {
  SandboxRegisterResponse(
      String trackingId, String status, SandboxAccount payload)
      : super(trackingId, status, payload);

  factory SandboxRegisterResponse.fromJson(Map<String, dynamic> data) =>
      SandboxRegisterResponse(
        data['trackingId'] as String,
        data['status'] as String? ?? 'Ok',
        SandboxAccount.fromJson(data['payload'] as Map<String, dynamic>),
      );

  @override
  String toString() => 'SandboxRegisterResponse(trackingId: $trackingId, '
      'status: $status, payload: $payload)';
}
