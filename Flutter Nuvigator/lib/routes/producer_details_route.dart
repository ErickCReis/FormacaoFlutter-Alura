import 'package:flutter/widgets.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/screens/producer_details_screen.dart';

class ProducerDetailsRoute extends NuRoute {
  @override
  String get path => 'producer-details';

  @override
  ScreenType get screenType => materialScreenType;

  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return ProducerDetailsScreen(
      producer: settings.rawParameters['producer'],
      onPackageDetailClick: (parameters) => nuvigator.open(
        'package-details',
        parameters: parameters,
      ),
    );
  }
}
