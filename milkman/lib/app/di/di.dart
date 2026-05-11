import 'di_imports.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Firebase Singletons
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  //core
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // TODO (next steps):
  // - AuthRepository + AuthBloc
  // - SessionCubit (auth state stream)
  // - RouteGuards use session
}
