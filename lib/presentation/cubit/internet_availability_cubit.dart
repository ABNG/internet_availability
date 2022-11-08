import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'internet_availability_cubit.freezed.dart';
part 'internet_availability_state.dart';

class InternetAvailabilityCubit extends Cubit<InternetAvailabilityState> {
  late final StreamSubscription _internetAvailabilitySubscription;
  InternetAvailabilityCubit() : super(const InternetAvailabilityState.wifi()) {
    checkInternetAvailability();
    _internetAvailabilitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          switch (result) {
            case ConnectivityResult.wifi:
              emit(const InternetAvailabilityState.wifi());
              break;
            case ConnectivityResult.mobile:
              emit(const InternetAvailabilityState.mobile());
              break;
            default:
              emit(const InternetAvailabilityState.none());
              break;
          }
          debugPrint(state.toString());
        },
      );
    });
  }

  Future<void> checkInternetAvailability() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(const InternetAvailabilityState.none());
      debugPrint(state.toString());
    }
  }

  @override
  Future<void> close() {
    _internetAvailabilitySubscription.cancel();
    return super.close();
  }
}
