import 'package:flutter/widgets.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/models/package_model.dart';
import 'package:proj/models/producer_model.dart';
import 'package:proj/screens/package_details_screen.dart';

class PackageDetailsArgs {
  final Package package;
  final Producer producer;

  PackageDetailsArgs({this.package, this.producer});

  static PackageDetailsArgs fromJson(Map<String, dynamic> json) {
    return PackageDetailsArgs(
      package: json['package'],
      producer: json['producer'],
    );
  }

  @override
  String toString() {
    return 'PackageDetailsArgs{package: $package, producer: $producer}';
  }
}

class PackageDetailsRoute
    extends NuRoute<NuRouter, PackageDetailsArgs, String> {
  @override
  String get path => 'package-details';

  @override
  ScreenType get screenType => materialScreenType;

  @override
  ParamsParser<PackageDetailsArgs> get paramsParser =>
      PackageDetailsArgs.fromJson;

  @override
  Widget build(
    BuildContext context,
    NuRouteSettings<PackageDetailsArgs> settings,
  ) {
    return PackageDetailsScreen(
      package: settings.args.package,
      producer: settings.args.producer,
    );
  }
}
