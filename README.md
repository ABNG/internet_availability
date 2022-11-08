# Internet Availability

A Flutter package which check the internet availability and push a new page on top of the current route if internet is not available. Once the internet is available that page will automatically pop to previous route.
>*Note: The package will only work with [go_router](https://pub.dev/packages/go_router)*
## Features
[![example.gif](https://i.postimg.cc/1zsmPdnQ/example.gif)](https://postimg.cc/fVqnfBf2)

# Getting started

```bash
flutter pub add internet_availability
```
```bash
flutter pub get
```

# Usage

* In your `routes` list add one more route

```dart
GoRoute(
      path: NoInternetPage.routeName,
      builder: (context, state) => const NoInternetPage(),
    ),
```
The route should not be a nested route. You can provide any value to `path` property and even your own Widget to `builder` property.
* add `redirect` and `refreshListenable` property of GoRouter and paste below code

```dart
redirect: (context, state) {
    switch (InternetAvailabilityConfig.showNoInternetPage()) {
      case true:
        InternetAvailabilityConfig.prevRoute = state.subloc;
        return NoInternetPage.routeName; //page route path
      case false:
        return InternetAvailabilityConfig.prevRoute;
      default:
        return null;
    }
  },
refreshListenable: RefreshStream(
      InternetAvailabilityConfig.internetAvailabilityCubit.stream),
```

> Note: For `go_router` version lower than 5.0 use `GoRouterRefreshStream` and `redirect` will only take `state` as an argument.

```dart
refreshListenable: GoRouterRefreshStream(
      InternetAvailabilityConfig.internetAvailabilityCubit.stream),
```

# Additional Information

check the [example](https://pub.dev/packages/internet_availability/example) repository of the project for complete code.