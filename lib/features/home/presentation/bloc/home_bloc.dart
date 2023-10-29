import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:watheq_ecommerce/features/home/domain/use_cases/get_all_products_use_case.dart';

import '../../../../main.dart';
import '../../data/model/all_products_response_model.dart';
import '../../data/model/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

HomeBloc get homeBloc => HomeBloc.get(navigatorKey.currentContext!);

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static HomeBloc get(context) => BlocProvider.of(context);

  List<Product> _allProducts = [];
  List<Product> subList = [];
  String selectedCatName = '';

  final GetAllProductsUseCase getAllProductsUseCase;

  HomeBloc({required this.getAllProductsUseCase}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is ClickCatEvent) {
        selectedCatName = event.cat;
        if (event.cat == 'All') {
          subList = _allProducts;
          emit(ClickCatState(products: subList));
          emit(GetAllProductsSuccessState(products: subList));
        } else {
          subList = _allProducts.where((element) => element.category == event.cat).toList();
          emit(ClickCatState(products: subList));
          emit(GetAllProductsSuccessState(products: subList));
        }
      } else if (event is NotificatinsFabButtonClickEvent) {
        emit(NotificatinsFabButtonClickedState());
      } else if (event is CategoryTabClickEvent) {
        emit(CategoryTabClickedState(tabName: event.tabName));
      } else if (event is GetAllProductsEvent) {
        emit(GetAllProductsLoadingState());
        final eitherProductsOrFailure = await getAllProductsUseCase.call();
        eitherProductsOrFailure.fold(
          (failure) {
            emit(GetAllProductsErrorState(msg: failure.message ?? 'error'));
          },
          (data) {
            _allProducts = data;
            subList = _allProducts;
            emit(GetAllProductsSuccessState(products: subList));
          },
        );
      }
    });
  }
}