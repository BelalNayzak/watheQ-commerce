import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:watheq_ecommerce/features/wallet/domain/usecases/add_new_wallet_use_case.dart';
import 'package:watheq_ecommerce/features/wallet/domain/usecases/get_all_wallets_data_use_case.dart';
import 'package:watheq_ecommerce/features/wallet/domain/usecases/get_wallet_data_use_case.dart';

import '../../../../core/utils/caching_utils/cache_helper.dart';
import '../../../../main.dart';
import '../../../home/domain/use_cases/get_all_products_use_case.dart';
import '../../data/model/wallet.dart';
import '../../domain/usecases/delete_wallet_data_use_case.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

WalletBloc get walletBloc => WalletBloc.get(navigatorKey.currentContext!);

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  static WalletBloc get(context) => BlocProvider.of(context);

  final GetWalletDataUseCase getWalletDataUseCase;
  final AddNewWalletUseCase addNewWalletUseCase;
  final DeleteWalletDataUseCase deleteWalletDataUseCase;
  final GetAllWalletsDataUseCase getAllWalletsUseCase;

  WalletBloc({
    required this.getWalletDataUseCase,
    required this.addNewWalletUseCase,
    required this.deleteWalletDataUseCase,
    required this.getAllWalletsUseCase,
  }) : super(WalletInitial()) {
    on<WalletEvent>((event, emit) async {
      if (event is GetAllWalletsEvent) {
        final eitherListOfWalletOrFailure = await getAllWalletsUseCase.call();
        eitherListOfWalletOrFailure.fold(
          (failure) {
            emit(GetAllWalletsErrorState(msg: failure.message ?? 'error'));
          },
          (data) {
            emit(GetAllWalletsSuccessState(wallets: data));
          },
        );
      } else if (event is GetWalletDataByIdEvent) {
        final eitherWalletOrFailure = await getWalletDataUseCase.call(walletId: event.id);
        eitherWalletOrFailure.fold(
          (failure) {
            emit(GetWalletDataByIdErrorState(msg: failure.message ?? 'error'));
          },
          (data) {
            emit(GetWalletDataByIdSuccessState(wallet: data));
          },
        );
      } else if (event is DeleteWalletDataByIdEvent) {
        final eitherUnitOrFailure = await deleteWalletDataUseCase.call(walletId: event.id);
        eitherUnitOrFailure.fold(
          (failure) {
            emit(DeleteWalletDataByIdErrorState(msg: failure.message ?? 'error'));
          },
          (data) {
            emit(DeleteWalletDataByIdSuccessState());
          },
        );
      } else if (event is AddNewWalletEvent) {
        final eitherUnitOrFailure = await addNewWalletUseCase.call(wallet: event.wallet);
        eitherUnitOrFailure.fold(
          (failure) {
            emit(AddNewWalletErrorState(msg: failure.message ?? 'error'));
          },
          (data) {
            emit(AddNewWalletSuccessState());
          },
        );
      }
    });
  }
}