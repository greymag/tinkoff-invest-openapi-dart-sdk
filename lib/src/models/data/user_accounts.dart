import 'from_json.dart';
import 'user_account.dart';

class UserAccounts {
  final List<UserAccount> accounts;

  UserAccounts(this.accounts);

  factory UserAccounts.fromJson(Map<String, dynamic> map) {
    return UserAccounts(
      map.requireList('accounts', (d) => UserAccount.fromJson(d)),
    );
  }

  @override
  String toString() => 'UserAccounts(accounts: $accounts)';
}
