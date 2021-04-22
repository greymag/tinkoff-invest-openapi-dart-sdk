# tinkoff_invest

[![pub package](https://img.shields.io/pub/v/tinkoff_invest)](https://pub.dev/packages/tinkoff_invest)
![Dart](https://github.com/greymag/tinkoff-invest-openapi-dart-sdk/actions/workflows/dart.yml/badge.svg?branch=master)

Данный проект представляет собой инструментарий на языке Dart для работы с [OpenAPI Тинькофф Инвестиции](https://github.com/TinkoffCreditSystems/invest-openapi), который можно использовать для создания торговых роботов.

## Начало работы

Чтобы использовать плагин, добавьте `tinkoff_invest` как [зависимость в ваш файл pubspec.yaml](https://flutter.dev/platform-plugins/).

### Где взять токен аутентификации?

В разделе инвестиций вашего [личного кабинета tinkoff](https://www.tinkoff.ru/invest/). Далее:

* Перейдите в настройки.
* Проверьте, что функция “Подтверждение сделок кодом” отключена.
* Выпустите токен для торговли на бирже и режима “песочницы” (sandbox).
* Скопируйте токен и сохраните, токен отображается только один раз, просмотреть его позже не получится, тем не менее вы можете выпускать неограниченное количество токенов.

## Документация

Документацию непосредственно по OpenAPI можно найти по [ссылке](https://api-invest.tinkoff.ru/openapi/docs/).

### Быстрый старт

Для взаимодействия с OpenAPI нужно создать экземпляр `TinkoffInvestApi`:

```dart
const token = 'your_token';
final api = TinkoffInvestApi(token);

// Запрос текущего портфеля
final portfolioRes = await api.portfolio.load();
if (portfolioRes.isValue) {
  final portfolio = portfolioRes.asValue!.value.payload;
  print('Portfolio: ${portfolio.positions}');
} else {
  print('Load portfolio failed: ${portfolioRes.asError!.error}');
}
```

Каждый запрос к api возвращает [`Result`](https://pub.dev/documentation/async/latest/pkg.async/Result-class.html),
который представляет собой результат - успешный или ошибку.
Был ли результат успешным, можно проверить с помощью свойства `res.isValue`.
Если был - то обращайтесь к полученному ответу с помощью `res.asValue!.value`.
Если же результат представляет собой ошибку, то вы можете получить объект
ошибки при помощи `res.asError!.error`. Это может быть экземпляр `ErrorResponse`,
но не обязательно.

Пример использования SDK (в том числе в режиме песочницы) находится в директории [`example`](./example).