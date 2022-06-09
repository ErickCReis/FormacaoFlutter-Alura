import 'package:flutter/widgets.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/screens/singup_screen.dart';

class SignUpRoute extends NuRoute {
  @override
  String get path => 'sign-up';

  @override
  ScreenType get screenType => materialScreenType;

  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return SignUpScreen(
      onLoginClick: () => nuvigator.open('login'),
    );
  }
}
