import 'package:flutter/material.dart';
import 'package:myroutine/config/config.dart';
import 'package:myroutine/config/routes/routes.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyRoutineApp extends ConsumerWidget {
  const MyRoutineApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(routesProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: routeConfig,
    );
  }
}
