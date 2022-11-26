import 'package:flutter/material.dart';
import 'package:internet_availability/service/internet_availability_config.dart';

class NoInternetPage extends StatelessWidget {
  static const String routeName = '/no_internet';
  final bool enableBackGesture;
  const NoInternetPage({Key? key, this.enableBackGesture = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(enableBackGesture);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/no_internet.jpg',
                  width: 320, height: 320, package: 'internet_availability'),
            ),
            const SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text('internet availability checking...'),
                  ),
                );
                await InternetAvailabilityConfig.internetAvailabilityCubit
                    .checkInternetAvailability();
                InternetAvailabilityConfig.internetAvailabilityCubit.state
                    .whenOrNull(none: () {
                  messenger.hideCurrentSnackBar();
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text('No internet available'),
                    ),
                  );
                });
              },
              icon: const Icon(
                Icons.refresh,
                size: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
