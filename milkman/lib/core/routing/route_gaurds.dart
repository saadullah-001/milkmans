import 'package:milkman/app/di/di.dart';
import 'package:milkman/features/auth/presentation/cubits/session_cubit.dart';

class RouteGuards {
  static bool get isLoggedIn {
    final sessionCubit = getIt<SessionCubit>();
    return sessionCubit.state.isAuthenticated;
  }

  static String? requireAuth(String intendedPath) {
    if (!isLoggedIn) return '/login';
    return null;
  }
}
