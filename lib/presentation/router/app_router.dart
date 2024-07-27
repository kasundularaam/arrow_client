import 'package:arrow_client/presentation/screens/address/address_page.dart';
import 'package:arrow_client/presentation/screens/stream/stream_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AddressRoute.page, path: "/"),
        AutoRoute(page: StreamRoute.page, path: "/stream"),
      ];
}
