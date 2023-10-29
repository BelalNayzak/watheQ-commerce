import 'package:bloc/bloc.dart';
import 'package:watheq_ecommerce/core/utils/debugging_utils/debugging_helper.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    // debugPrint('onCreate -- ${bloc.runtimeType}');
    debugPrinter('<||> -- 🐛 --onCreate -- <||> ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // debugPrint('onChange -- ${bloc.runtimeType}, $change');
    debugPrinter('<||> -- 🐛 --onChange -- <||> ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // debugPrint('onError -- ${bloc.runtimeType}, $error');
    debugPrinter('<||> -- 🐛 --onError -- <||> ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    // debugPrint('onClose -- ${bloc.runtimeType}');
    debugPrinter('<||> -- 🐛 --onClose -- <||> ${bloc.runtimeType}');
  }
}