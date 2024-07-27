import 'package:arrow_client/application/address/address_cubit.dart';
import 'package:arrow_client/injection.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'router/app_router.dart';

class App extends StatelessWidget {
  final _router = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddressCubit>(),
      child: MaterialApp.router(
        title: "Arrow Client",
        debugShowCheckedModeBanner: false,
        theme: FlexThemeData.light(scheme: FlexScheme.wasabi),
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.wasabi),
        themeMode: ThemeMode.system,
        routerConfig: _router.config(),
      ),
    );
  }
}
