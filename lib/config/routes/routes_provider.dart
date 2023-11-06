import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myroutine/config/routes/routes.dart';

final routesProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigationKey,
    routes: appRoutes,
    initialLocation: RouteLocation.home,
  );
});
