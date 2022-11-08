import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_availability/internet_availability.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Page1(),
    ),
    GoRoute(
      path: NoInternetPage.routeName,
      builder: (context, state) => const NoInternetPage(),
    ),
  ],
  redirect: (context, state) {
    switch (InternetAvailabilityConfig.showNoInternetPage()) {
      case true:
        InternetAvailabilityConfig.prevRoute = state.subloc;
        return NoInternetPage.routeName;
      case false:
        return InternetAvailabilityConfig.prevRoute;
      default:
        return null;
    }
  },
  refreshListenable: RefreshStream(
      InternetAvailabilityConfig.internetAvailabilityCubit.stream),
);

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}

class Page1 extends StatelessWidget {
  static const String routeName = '/';
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('Page 1'),
    ));
  }
}
