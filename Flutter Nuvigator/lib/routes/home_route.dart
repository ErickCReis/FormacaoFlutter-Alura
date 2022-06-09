import 'package:flutter/widgets.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/screens/home_screen.dart';

class HomeRoute extends NuRoute {
  @override
  String get path => 'home';

  @override
  ScreenType get screenType => materialScreenType;

  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return HomeScreen(
      onProducerDetailClick: (parameters) => nuvigator.open(
        'producer-details',
        parameters: parameters,
      ),
    );
  }
}
