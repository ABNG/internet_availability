import '../presentation/cubit/internet_availability_cubit.dart';

class InternetAvailabilityConfig {
  static bool prevStateInternetAvailable = true;
  static InternetAvailabilityCubit internetAvailabilityCubit =
      InternetAvailabilityCubit();
  static String? prevRoute;

  static bool? showNoInternetPage() {
    return internetAvailabilityCubit.state.maybeWhen(
      none: () {
        if (prevStateInternetAvailable) {
          prevStateInternetAvailable = false;
          return true;
        }
        return null;
      },
      orElse: () {
        if (!prevStateInternetAvailable) {
          prevStateInternetAvailable = true;
          return false;
        }
        return null;
      },
    );
  }
}
