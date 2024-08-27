import 'package:go_router/go_router.dart';
import 'package:spread/pages/main_screen.dart';
import 'package:spread/router/route_names.dart';

//router class
class RouterClass {
  final router = GoRouter(initialLocation: "/", routes: [
    GoRoute(
      path: "/",
      name: RouterNames.home,
      builder: (context, state) {
        return const MainScreen();
      },
    )
  ]);
}
