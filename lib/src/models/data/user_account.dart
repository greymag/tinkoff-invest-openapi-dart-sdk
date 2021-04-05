import 'broker_account_type.dart';

class UserAccount {
  final BrokerAccountType brokerAccountType;
  final String brokerAccountId;

  UserAccount(this.brokerAccountType, this.brokerAccountId);

  factory UserAccount.fromJson(Map<String, dynamic> map) {
    return UserAccount(
      map.requireBrokerAccountType(),
      map['brokerAccountId'] as String,
    );
  }

  @override
  String toString() => 'UserAccount(brokerAccountType: $brokerAccountType, '
      'brokerAccountId: $brokerAccountId)';
}
