import 'package:test/test.dart';
import 'package:tinkoff_invest/src/endpoints/ti_user_endpoint.dart';
import 'package:tinkoff_invest/src/models/data/broker_account_type.dart';
import 'package:tinkoff_invest/src/models/response/user_accounts_response.dart';

import 'dio_mock.dart';
import 'matchers.dart';

void main() {
  group('load()', () {
    test('should return OperationsResponse on success with emty list',
        () async {
      const response =
          '{"trackingId":"a075df5d357b192a","payload":{"accounts":[{"brokerAccountType":"Tinkoff","brokerAccountId":"SB1326498"}]},"status":"Ok"}';
      final endpoint = TIUserEndpoint(dioForSuccess(response));

      final res = await endpoint.accounts();

      expect(res.isValue, true);
      expect(res.asValue!.value, isA<UserAccountsResponse>());

      final data = res.asValue!.value;
      expect(data.trackingId, 'a075df5d357b192a');
      expect(data.status, 'Ok');
      expect(data.payload.accounts.length, 1);

      expect(
          data.payload.accounts[0],
          UserAccountMatcher(
            brokerAccountType: BrokerAccountType.tinkoff,
            brokerAccountId: 'SB1326498',
          ));
    });

    // TODO: test fail
  });
}
