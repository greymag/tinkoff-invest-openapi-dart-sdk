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
