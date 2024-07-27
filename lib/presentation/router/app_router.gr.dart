// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddressRoute.name: (routeData) {
      final args = routeData.argsAs<AddressRouteArgs>(
          orElse: () => const AddressRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddressPage(key: args.key),
      );
    },
    StreamRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StreamPage(),
      );
    },
  };
}

/// generated route for
/// [AddressPage]
class AddressRoute extends PageRouteInfo<AddressRouteArgs> {
  AddressRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AddressRoute.name,
          args: AddressRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AddressRoute';

  static const PageInfo<AddressRouteArgs> page =
      PageInfo<AddressRouteArgs>(name);
}

class AddressRouteArgs {
  const AddressRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AddressRouteArgs{key: $key}';
  }
}

/// generated route for
/// [StreamPage]
class StreamRoute extends PageRouteInfo<void> {
  const StreamRoute({List<PageRouteInfo>? children})
      : super(
          StreamRoute.name,
          initialChildren: children,
        );

  static const String name = 'StreamRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
