class RouteGuards {
  // TEMP: replace with Session/Auth state (AuthBloc/SessionCubit) in next step
  static bool get isLoggedIn => false;

  static String? requireAuth(String intendedPath) {
    if (!isLoggedIn) return '/login';
    return null;
  }
}
