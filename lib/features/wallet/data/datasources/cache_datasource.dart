import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/caching_utils/cache_helper.dart';
import '../../../../core/utils/debugging_utils/debugging_helper.dart';
import '../model/wallet.dart';

abstract class CacheDataSource {
  Future<Either<Failure, Unit>> addNewWalletData({required Wallet wallet});
  Future<Either<Failure, Wallet>> getWalletDataById({required int walletId});
  Future<Either<Failure, Unit>> deleteWalletDataById({required int walletId});
  Future<Either<Failure, List<Wallet>>> getAllWalletsData();
}

class CacheDataSourceImpl implements CacheDataSource {
  final CacheHelper cacheSecure;

  CacheDataSourceImpl({required this.cacheSecure});

  @override
  Future<Either<Failure, Unit>> addNewWalletData({required Wallet wallet}) async {
    return _basicErrorHandling<Unit>(
      onSuccess: () async {
        await cacheSecure.put('${wallet.id} id', wallet.id);
        await cacheSecure.put('${wallet.id} ccv', wallet.ccv);
        await cacheSecure.put('${wallet.id} pin', wallet.pin);
        await cacheSecure.put('${wallet.id} date1', wallet.date1);
        await cacheSecure.put('${wallet.id} date2', wallet.date2);
        await cacheSecure.put('${wallet.id} cardNumber', wallet.cardNumber);
        return unit;
      },
      onCacheError: (exception) async {
        return CacheFailure(error: 'Cache Error', code: 500, message: 'Cache Error');
      },
    );
  }

  @override
  Future<Either<Failure, Wallet>> getWalletDataById({required int walletId}) async {
    return _basicErrorHandling<Wallet>(
      onSuccess: () async {
        final id = await cacheSecure.get('$walletId id');
        final ccv = await cacheSecure.get('$walletId ccv');
        final pin = await cacheSecure.get('$walletId pin');
        final date1 = await cacheSecure.get('$walletId date1');
        final date2 = await cacheSecure.get('$walletId date2');
        final cardNumber = await cacheSecure.get('$walletId cardNumber');

        return Wallet(
            id: id, ccv: ccv, pin: pin, date1: date1, date2: date2, cardNumber: cardNumber);
      },
      onCacheError: (exception) async {
        return CacheFailure(error: 'Cache Error', code: 500, message: 'Cache Error');
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteWalletDataById({required int walletId}) async {
    return _basicErrorHandling<Unit>(
      onSuccess: () async {
        await cacheSecure.delete('$walletId id');
        await cacheSecure.delete('$walletId ccv');
        await cacheSecure.delete('$walletId pin');
        await cacheSecure.delete('$walletId date1');
        await cacheSecure.delete('$walletId date2');
        await cacheSecure.delete('$walletId cardNumber');
        return unit;
      },
      onCacheError: (exception) async {
        return CacheFailure(error: 'Cache Error', code: 500, message: 'Cache Error');
      },
    );
  }

  @override
  Future<Either<Failure, List<Wallet>>> getAllWalletsData() async {
    return _basicErrorHandling<List<Wallet>>(
      onSuccess: () async {
        final List<Wallet> wallets = [];
        final Map<String, dynamic> all = await cacheSecure.getAll() ?? {};
        Map<String, dynamic> walletMap = {};

        int j = 0; // 6 is the num of wallet fields
        for (int i = 0; i < 6; i++) {
          for (j; j < all.entries.length; j++) {
            walletMap.addEntries(
              [
                MapEntry(
                  (all.entries.elementAt(j).key).toString().replaceFirst('${i} ', ''),
                  all.entries.elementAt(j).value,
                )
              ],
            );
          }
          wallets.add(Wallet.fromJson(walletMap));
        }

        return wallets;
      },
      onCacheError: (exception) async {
        return CacheFailure(error: 'Cache Error', code: 500, message: 'Cache Error');
      },
    );
  }
}

// Note: extension for handling local requests errors with its callbacks
extension on CacheDataSource {
  Future<Either<Failure, T>> _basicErrorHandling<T>({
    required Future<T> Function() onSuccess,
    Future<Failure> Function(CacheException exception)? onCacheError,
    Future<Failure> Function(dynamic exception)? onOtherError,
  }) async {
    try {
      final f = await onSuccess();
      return Right(f);
    } on CacheException catch (e, s) {
      // recordError(e, s);
      debugPrinter(e.toString());
      if (onCacheError != null) {
        final f = await onCacheError(e);
        return Left(f);
      }
      return Left(CacheFailure());
    } catch (e, s) {
      // recordError(e, s);
      debugPrinter(s.toString());
      if (onOtherError != null) {
        final f = await onOtherError(e);
        return Left(f);
      }
      return Left(UnexpectedFailure());
    }
  }
}