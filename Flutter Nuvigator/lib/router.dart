import 'package:flutter/widgets.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/routes/favorites_route.dart';
import 'package:proj/routes/home_route.dart';
import 'package:proj/routes/login_route.dart';
import 'package:proj/routes/package_details_route.dart';
import 'package:proj/routes/payment_route.dart';
import 'package:proj/routes/producer_details_route.dart';
import 'package:proj/routes/profile_route.dart';
import 'package:proj/routes/sign_up_route.dart';

class MyRouter extends NuRouter {
  @override
  String get initialRoute => 'home';

  @override
  List<NuRoute> get registerRoutes => [
        HomeRoute(),
        LoginRoute(),
        SignUpRoute(),
        FavoritesRoute(),
        PaymentRoute(),
        ProfileRoute(),
        ProducerDetailsRoute(),
        PackageDetailsRoute()
      ];
}

// Render
Widget build(BuildContext context) {
  return Nuvigator(
    router: MyRouter(),
  );
}
