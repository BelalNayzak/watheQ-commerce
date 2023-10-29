import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:watheq_ecommerce/core/internet_connection/network_status.dart';
import 'package:watheq_ecommerce/features/checkout/data/repository/checkout_repo_impl.dart';
import 'package:watheq_ecommerce/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:watheq_ecommerce/features/wallet/data/repository/wallet_repository_impl.dart';
import 'package:watheq_ecommerce/features/wallet/domain/usecases/get_all_wallets_data_use_case.dart';
import 'package:watheq_ecommerce/features/home/data/datasources/home_remote_datasource.dart';
import 'package:watheq_ecommerce/features/home/data/repository/home_repo_impl.dart';
import 'package:watheq_ecommerce/features/home/domain/repository/home_repository.dart';
import 'package:watheq_ecommerce/features/product_details/presentation/bloc/product_details_bloc.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/checkout/domain/repository/checkout_repository.dart';
import '../../features/checkout/domain/usecases/get_all_visas_data_use_case.dart';
import '../../features/wallet/data/datasources/cache_datasource.dart';
import '../../features/wallet/domain/repository/wallet_repository.dart';
import '../../features/wallet/domain/usecases/add_new_wallet_use_case.dart';
import '../../features/wallet/domain/usecases/delete_wallet_data_use_case.dart';
import '../../features/wallet/domain/usecases/get_wallet_data_use_case.dart';
import '../../features/wallet/presentation/bloc/wallet_bloc.dart';
import '../../features/home/domain/use_cases/get_all_products_use_case.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/main_nav/presentation/bloc/main_nav_bloc.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';
import '../utils/caching_utils/cache_helper.dart';
import '../utils/network_utils/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///* onboarding

  sl.registerFactory<OnboardingBloc>(() => OnboardingBloc());

  ///* main nav

  sl.registerFactory<MainNavBloc>(() => MainNavBloc());

  ///* home

  sl.registerFactory<HomeBloc>(() => HomeBloc(getAllProductsUseCase: sl()));

  sl.registerLazySingleton<GetAllProductsUseCase>(() => GetAllProductsUseCase(homeRepo: sl()));

  sl.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(remoteDatasource: sl(), networkStatus: sl()));

  sl.registerLazySingleton<HomeRemoteDatasource>(() => HomeRemoteDatasourceImpl(dioHelper: sl()));

  sl.registerLazySingleton<DioHelper>(() => DioImpl());

  sl.registerLazySingleton<NetworkStatus>(() => NetworkStatusImpl(internetChecker: sl()));

  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());

  ///* product details

  sl.registerFactory<ProductDetailsBloc>(() => ProductDetailsBloc());

  ///* cart

  sl.registerFactory<CartBloc>(() => CartBloc());

  ///* wallet

  sl.registerFactory<WalletBloc>(
    () => WalletBloc(
      getWalletDataUseCase: sl(),
      addNewWalletUseCase: sl(),
      deleteWalletDataUseCase: sl(),
      getAllWalletsUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<GetWalletDataUseCase>(() => GetWalletDataUseCase(walletRepo: sl()));

  sl.registerLazySingleton<AddNewWalletUseCase>(() => AddNewWalletUseCase(walletRepo: sl()));

  sl.registerLazySingleton<DeleteWalletDataUseCase>(
      () => DeleteWalletDataUseCase(walletRepo: sl()));

  sl.registerLazySingleton<GetAllWalletsDataUseCase>(
      () => GetAllWalletsDataUseCase(walletRepo: sl()));

  sl.registerLazySingleton<WalletRepo>(() => WalletRepoImpl(cacheDataSource: sl()));

  sl.registerLazySingleton<WalletRepoImpl>(() => WalletRepoImpl(cacheDataSource: sl()));

  sl.registerLazySingleton<CacheDataSource>(() => CacheDataSourceImpl(cacheSecure: sl()));

  sl.registerLazySingleton<CacheHelper>(() => CacheSecureImpl(secureStorage: sl()));

  ///* checkout

  sl.registerFactory<CheckoutBloc>(() => CheckoutBloc(getAllWalletsUseCase: sl()));

  sl.registerLazySingleton<GetAllVisasDataUseCase>(
      () => GetAllVisasDataUseCase(checkoutRepo: sl()));

  sl.registerLazySingleton<CheckoutRepo>(() => CheckoutRepoImpl(cacheDataSource: sl()));

  ///* caching

  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => secureStorage);
}