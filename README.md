# iOS OAuth с помощью библиотеки AppAuth

Разработан в качестве материала к статье: [https://habr.com/ru/company/kts/blog/681998/](https://habr.com/ru/company/kts/blog/681998/)

Функционал:
- логин
- логаут
- обновление токена (пример, не работает на сервисе github)

**Важно**: это не production-ready приложение, пример разработан исключительно для демонстрации работы с библиотекой AppAuth. Разбиение на слои, архитекрурные сущности проведено условно. Пример необходимо адаптировать к приложению индивидуально.

Чтобы протестировать приложение:
- [зарегистрируйте](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app) OAuth-приложение в github
- заполните поля CLIENT_ID, CLIENT_SECRET, CALLBACK_URL внутри [AuthConfiguration](https://github.com/elenakacharmina/ios-oauth-example/blob/01948e505e9ef1d7e986d62dac120db71330897f/ios-oauth-example/Data/OAuth/AuthConfiguration.swift#L6) в соотвествии с параметрами зарегистрированного приложения
