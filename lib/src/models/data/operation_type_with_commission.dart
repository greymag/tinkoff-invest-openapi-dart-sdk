enum OperationTypeWithCommission {
  buy,
  buyCard,
  sell,
  brokerCommission,
  exchangeCommission,
  serviceCommission,
  marginCommission,
  otherCommission,
  payIn,
  payOut,
  tax,
  taxLucre,
  taxDividend,
  taxCoupon,
  taxBack,
  repayment,
  partRepayment,
  coupon,
  dividend,
  securityIn,
  securityOut
}

const _defaultOperationTypeKey = 'operationType';

class OperationTypeWithCommissionConverter {
  static const _data = <String, OperationTypeWithCommission>{
    'Buy': OperationTypeWithCommission.buy,
    'BuyCard': OperationTypeWithCommission.buyCard,
    'Sell': OperationTypeWithCommission.sell,
    'BrokerCommission': OperationTypeWithCommission.brokerCommission,
    'ExchangeCommission': OperationTypeWithCommission.exchangeCommission,
    'ServiceCommission': OperationTypeWithCommission.serviceCommission,
    'MarginCommission': OperationTypeWithCommission.marginCommission,
    'OtherCommission': OperationTypeWithCommission.otherCommission,
    'PayIn': OperationTypeWithCommission.payIn,
    'PayOut': OperationTypeWithCommission.payOut,
    'Tax': OperationTypeWithCommission.tax,
    'TaxLucre': OperationTypeWithCommission.taxLucre,
    'TaxDividend': OperationTypeWithCommission.taxDividend,
    'TaxCoupon': OperationTypeWithCommission.taxCoupon,
    'TaxBack': OperationTypeWithCommission.taxBack,
    'Repayment': OperationTypeWithCommission.repayment,
    'PartRepayment': OperationTypeWithCommission.partRepayment,
    'Coupon': OperationTypeWithCommission.coupon,
    'Dividend': OperationTypeWithCommission.dividend,
    'SecurityIn': OperationTypeWithCommission.securityIn,
    'SecurityOut': OperationTypeWithCommission.securityOut
  };

  const OperationTypeWithCommissionConverter();

  OperationTypeWithCommission convert(String value) => _data[value]!;

  OperationTypeWithCommission fromJson(Map<String, dynamic> data,
          [String key = _defaultOperationTypeKey]) =>
      convert(data[key] as String);
}

OperationTypeWithCommission operationTypeWithCommissionFromJson(
        Map<String, dynamic> data,
        [String key = _defaultOperationTypeKey]) =>
    const OperationTypeWithCommissionConverter().fromJson(data, key);

extension OperationTypeWithCommissionFromJsonExtension on Map<String, dynamic> {
  OperationTypeWithCommission requireOperationTypeWithCommission(
          [String key = _defaultOperationTypeKey]) =>
      const OperationTypeWithCommissionConverter().fromJson(this, key);

  OperationTypeWithCommission? optionalOperationTypeWithCommission(
          [String key = _defaultOperationTypeKey]) =>
      this[key] != null
          ? const OperationTypeWithCommissionConverter().fromJson(this, key)
          : null;
}
