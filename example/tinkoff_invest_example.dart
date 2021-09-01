// ignore_for_file: avoid_print
import 'package:tinkoff_invest/tinkoff_invest.dart';

Future<void> main() async {
  const token = 'your_token';

  // Работаем в режиме песочницы.
  const sandboxMode = true;
  // Можно включить режим дебага, чтобы все запросы распечатывались в консоль
  const debug = false;

  // Создаем экземпляр API
  final api = TinkoffInvestApi(token, sandboxMode: sandboxMode, debug: debug);

  // ! Только для режима песочницы !
  // Настраиваем Sandbox аккаунт
  await api.sandbox.register(); // создаем профиль
  await api.sandbox.currenciesBalance(Currency.USD, 1000); // $1000 на счет
  // --

  // Запросим текущий баланс валют
  final res = await api.portfolio.currencies();
  if (res.isValue) {
    final response = res.asValue!.value;
    final data = response.payload;

    print('Currencies: ${data.currencies}');
    // Currencies: [
    //   CurrencyPosition(currency: Currency.EUR, balance: 0.0, blocked: null),
    //   CurrencyPosition(currency: Currency.RUB, balance: 0.0, blocked: null),
    //   CurrencyPosition(currency: Currency.USD, balance: 1000.0, blocked: null)
    // ]
  } else {
    print('Load currencies failed: ${res.asError!.error}');
  }

  // Запросим текущий портфель
  final portfolioBeforeRes = await api.portfolio.load();
  if (portfolioBeforeRes.isValue) {
    final portfolioBefore = portfolioBeforeRes.asValue!.value.payload;
    print('Current portfolio: ${portfolioBefore.positions}');
    // Current portfolio: [
    //   PortfolioPosition(
    //     figi: BBG0013HGFT4,
    //     ticker: USD000UTSTOM,
    //     isin: null,
    //     instrumentType: InstrumentType.currency,
    //     balance: 1000.0,
    //     blocked: 0.0,
    //     expectedYield: null,
    //     lots: 1,
    //     averagePositionPrice: null,
    //     averagePositionPriceNoNkd: null,
    //     name: Доллар США
    //   )
    // ]
  } else {
    print('Load portfolio failed: ${portfolioBeforeRes.asError!.error}');
  }

  // Находим инструмент: Акции Apple
  String figi;
  final searchRes = await api.market.searchByTicker('AAPL');
  if (searchRes.isValue) {
    final searchData = searchRes.asValue!.value.payload;
    if (searchData.total > 0) {
      final instrument = searchData.instruments.first;
      print('Found instrument: $instrument');
      // Found instrument: MarketInstrument(
      //   figi: BBG000B9XRY4,
      //   ticker: AAPL,
      //   isin: US0378331005,
      //   minPriceIncrement: 0.01,
      //   faceValue: null,
      //   lot: 1,
      //   minQuantity: null,
      //   currency: Currency.USD,
      //   name: Apple,
      //   type: InstrumentType.stock
      // )

      figi = instrument.figi;
    } else {
      print('Nothing found');
      return;
    }
  } else {
    print('Search failed: ${searchRes.asError!.error}');
    return;
  }

  // Покупаем Акции Apple
  final orderRes = await api.orders.limitOrder(figi, OperationType.buy, 100, 1);
  if (orderRes.isValue) {
    final placedOrder = orderRes.asValue!.value.payload;
    print('Order placed: $placedOrder');
    // Order placed: PlacedLimitOrder(
    //   orderId: 42b991c7-071a-408c-aae7-76a510d9637f,
    //   operation: OperationType.buy,
    //   status: OrderStatus.fill,
    //   rejectReason: null,
    //   message: null,
    //   requestedLots: 1,
    //   executedLots: 1,
    //   commission: null
    // )
  } else {
    print('Place limit order failed: ${orderRes.asError!.error}');
  }

  // В песочнице сделка проходит моментально
  // Получаем текущий портфель
  final portfolioAfterRes = await api.portfolio.load();
  if (portfolioAfterRes.isValue) {
    final portfolioAfter = portfolioAfterRes.asValue!.value.payload;
    print('Portfolio after purchase: ${portfolioAfter.positions}');
    // Portfolio after purchase: [
    //   PortfolioPosition(
    //     figi: BBG000B9XRY4,
    //     ticker: AAPL,
    //     isin: US0378331005,
    //     instrumentType: InstrumentType.stock,
    //     balance: 1.0,
    //     blocked: 0.0,
    //     expectedYield: null,
    //     lots: 1,
    //     averagePositionPrice: null,
    //     averagePositionPriceNoNkd: null,
    //     name: Apple
    //   ),
    //   PortfolioPosition(
    //     figi: BBG0013HGFT4,
    //     ticker: USD000UTSTOM,
    //     isin: null,
    //     instrumentType: InstrumentType.currency,
    //     balance: 900.0,
    //     blocked: 0.0,
    //     expectedYield: null,
    //     lots: 0,
    //     averagePositionPrice: null,
    //     averagePositionPriceNoNkd: null,
    //     name: Доллар США
    //   )
    // ]
  } else {
    print('Load portfolio failed: ${portfolioAfterRes.asError!.error}');
  }

  // Подпишемся на события
  api.streaming.onError((event) {
    print('Error: ${event.payload}');
  });

  api.streaming.candle.subscribe(
    figi,
    StreamingCandleInterval.fiveMin,
    (event) {
      print('Candle: ${event.payload}');
      // Candle: StreamingCandle(
      //   figi: BBG000B9XRY4,
      //   interval: StreamingCandleInterval.fiveMin,
      //   o: 133.73,
      //   c: 133.73,
      //   h: 133.73,
      //   l: 133.7,
      //   v: 3674,
      //   time: 2021-04-22 19:05:00.000
      // )
    },
  );
}
