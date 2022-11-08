part of 'internet_availability_cubit.dart';

@freezed
class InternetAvailabilityState with _$InternetAvailabilityState {
  const factory InternetAvailabilityState.none() = None;
  const factory InternetAvailabilityState.mobile() = Mobile;
  const factory InternetAvailabilityState.wifi() = Wifi;
}
