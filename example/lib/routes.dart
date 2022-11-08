import 'package:go_router/go_router.dart';
import 'package:internet_availability/internet_availability.dart';

import 'main.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Page1(),
    ),
    GoRoute(
      path: '/page2',
      builder: (context, state) => const Page2(),
    ),
    GoRoute(
      path: NoInternetPage.routeName,
      builder: (context, state) => const NoInternetPage(),
    ),
  ],
  redirect: (context, state) {
    bool? showNoInternet = InternetAvailabilityConfig.showNoInternetPage();
    switch (showNoInternet) {
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
