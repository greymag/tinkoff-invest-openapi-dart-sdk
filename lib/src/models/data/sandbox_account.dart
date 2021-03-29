import 'broker_account_type.dart';

class SandboxAccount {
  final BrokerAccountType brokerAccountType;
  final String brokerAccountId;

  SandboxAccount(this.brokerAccountType, this.brokerAccountId);

  factory SandboxAccount.fromJson(Map<String, dynamic> map) {
    return SandboxAccount(
      map.requireBrokerAccountType(),
      map['brokerAccountId'] as String,
    );
  }

  @override
  String toString() => 'SandboxAccount(brokerAccountType: $brokerAccountType, '
      'brokerAccountId: $brokerAccountId)';
}
