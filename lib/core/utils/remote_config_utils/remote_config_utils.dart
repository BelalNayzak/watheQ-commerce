import 'package:firebase_remote_config/firebase_remote_config.dart';
import '../debugging_utils/debugging_helper.dart';

class RemoteConfigUtils {
  RemoteConfigUtils._();
  static final RemoteConfigUtils _instance = RemoteConfigUtils._();
  static RemoteConfigUtils get instance => _instance;


  bool showAds = true;


  Future<void> getConfigs() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    showAds = remoteConfig.getBool('show_ads');
    debugPrinter('show adds: $showAds');
  }
}