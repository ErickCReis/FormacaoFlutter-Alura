import 'package:flutter/widgets.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/screens/profile_screen.dart';

class ProfileRoute extends NuRoute {
  @override
  String get path => 'profile';

  @override
  ScreenType get screenType => materialScreenType;

  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    final name = settings.rawParameters['name'];
    return ProfileScreen(
      onClose: () => nuvigator.pop('Parâmetro recebido: $name'),
    );
  }
}
