import 'di_imports.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Firebase Singletons
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // Auth Data Layer
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<FirebaseAuth>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  // Auth Presentation Layer
  getIt.registerSingleton<SessionCubit>(SessionCubit(getIt<AuthRepository>()));

  getIt.registerSingleton<AuthBloc>(AuthBloc(getIt<AuthRepository>()));

  // Core
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
