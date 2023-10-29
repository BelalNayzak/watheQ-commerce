import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../main.dart';
import '../../data/model/visa.dart';
import '../../domain/usecases/get_all_visas_data_use_case.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

CheckoutBloc get checkoutBloc => CheckoutBloc.get(navigatorKey.currentContext!);

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  static CheckoutBloc get(context) => BlocProvider.of(context);

  final GetAllVisasDataUseCase getAllWalletsUseCase;

  CheckoutBloc({required this.getAllWalletsUseCase}) : super(CheckoutInitial()) {
    on<CheckoutEvent>((event, emit) async {
      if (event is GetAllVisasEvent) {
        Either eitherVisaOrFail = await getAllWalletsUseCase.call();
        eitherVisaOrFail.fold(
          (l) => GetAllVisasState(visas: const []),
          (r) => emit(GetAllVisasState(visas: r)),
        );
      }
    });
  }
}