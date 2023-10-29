import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';
import 'package:watheq_ecommerce/core/utils/debugging_utils/debugging_helper.dart';
import 'package:watheq_ecommerce/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:watheq_ecommerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:watheq_ecommerce/features/main_nav/presentation/bloc/main_nav_bloc.dart';
import 'package:watheq_ecommerce/features/onboarding/presentation/bloc/onboarding_bloc.dart';

import 'core/constants/assets_refs.dart';
import 'core/constants/font_sizes.dart';
import 'core/navigator/router.dart';
import 'core/di/injection.dart' as di;
import 'core/constants/colors.dart';
import 'core/constants/data.dart';
import 'core/utils/observer_utils/bloc_observer_utils.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/wallet/presentation/bloc/wallet_bloc.dart';
import 'features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'features/product_details/presentation/bloc/product_details_bloc.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// TODO: DOCS & README
// TODO: by pass the cache mechanism of remote config "using firebase's real time remote config"
// TODO: test on ios for possible issues
// TODO: moree fancy animations
// TODO: pagination
// TODO: state of "Oops went wrong" when go back to home screen
// TODO: scroll in home screen
// TODO: add a profishional shimmer loading indicator instead of the current one

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // WARNING! some FCM configuration functions requires to be plain and out of any class scope to work properly
  // ---
  _requestPermissions();
  _getFcmToken();
  _configureForegroundMessageHandler();
  _configureOpenedMessageHandler();
  _configureLocalNotification();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

  debugPrinter('fcm token: $fcmtoken');

  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  showAds = remoteConfig.getBool('show_ads');

  // WARNING! AS PER FIREBASE REMOTE CONFIG DOCUMENTATION...
  // firebase remote config has an internal caching system that may cache the remote config up to 12 hours.
  // Besides that, it could behave differently on debug rather than production
  // ---
  debugPrinter('last fetch status: ${remoteConfig.lastFetchStatus}');
  debugPrinter('last fetch time: ${remoteConfig.lastFetchTime}');
  debugPrinter('show ads: $showAds');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: colorPrimary));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => di.sl<OnboardingBloc>()),
        BlocProvider(create: (BuildContext context) => di.sl<MainNavBloc>()),
        BlocProvider(
            create: (BuildContext context) => di.sl<HomeBloc>()..add(GetAllProductsEvent())),
        BlocProvider(create: (BuildContext context) => di.sl<ProductDetailsBloc>()),
        BlocProvider(create: (BuildContext context) => di.sl<CartBloc>()),
        BlocProvider(create: (BuildContext context) => di.sl<WalletBloc>()),
        BlocProvider(
            create: (BuildContext context) => di.sl<CheckoutBloc>()..add(GetAllVisasEvent())),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            builder: BotToastInit(),
            navigatorKey: navigatorKey,
            title: appName,
            theme: ThemeData(
              snackBarTheme: const SnackBarThemeData(
                contentTextStyle: TextStyle(color: colorWhite),
              ),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                titleTextStyle: TextStyle(
                  color: colorWhite,
                  fontSize: FontSizes.medium,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w700,
                ),
                iconTheme: const IconThemeData(color: colorWhite),
                actionsIconTheme: const IconThemeData(color: colorWhite),
                backgroundColor: colorPrimary,
                centerTitle: true,
              ),
              scaffoldBackgroundColor: colorWhite,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: colorPrimary,
                unselectedItemColor: colorGrey,
              ),
              brightness: Brightness.light,
              fontFamily: font_sofia,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: colorAccent,
                primary: colorPrimary,
                brightness: Brightness.light,
              ),
            ),
            darkTheme: ThemeData(
              snackBarTheme: const SnackBarThemeData(
                contentTextStyle: TextStyle(color: colorWhite),
              ),
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.light,
                titleTextStyle: TextStyle(
                  color: colorGrey.shade200,
                  fontSize: FontSizes.medium,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w700,
                ),
                iconTheme: IconThemeData(color: colorGrey.shade200),
                actionsIconTheme: IconThemeData(color: colorGrey.shade200),
                backgroundColor: colorPrimaryDarkMode,
                centerTitle: true,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: colorWhite,
                unselectedItemColor: colorGrey,
              ),
              brightness: Brightness.dark,
              scaffoldBackgroundColor: colorBlack,
              fontFamily: font_sofia,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                secondary: colorAccentDarkMode,
                primary: colorPrimaryDarkMode,
                brightness: Brightness.dark,
              ),
            ),
            debugShowCheckedModeBanner: false,
            color: colorPrimary,
            routes: Routing.appRoutes(context),
            initialRoute: OnboardingScreen.id,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

/// ========================== fcm configurations =============================
/// ===========================================================================

// WARNING! some FCM configuration functions requires to be plain and out of any class scope to work properly
// ---
final FirebaseMessaging _fcm = FirebaseMessaging.instance;

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print("Background message received!");

  // Parse the message if needed
  // final Map<String, dynamic> data = message.data;

  // Display a notification
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    channelDescription: 'your_channel_description',
    importance: Importance.max,
    priority: Priority.max,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await _flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? 'Background notification',
    message.notification?.body ?? '',
    platformChannelSpecifics,
  );

  // Perform other tasks if needed, such as saving to local storage, making network requests, etc.
}

void _requestPermissions() {
  _fcm.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
}

void _getFcmToken() async {
  String? fcmToken = await _fcm.getToken();
  debugPrinterFullText("FCM Token: $fcmToken");
  fcmtoken = fcmToken!;
}

void _configureForegroundMessageHandler() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground message received!");
    _showNotificationDialog(message);
  });
}

void _configureOpenedMessageHandler() {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Notification tapped while app in background or terminated!");
    _showNotificationDialog(message);
  });
}

void _showNotificationDialog(RemoteMessage message) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(message.notification?.title ?? "Notification"),
      content: Text(message.notification?.body ?? "Notification Content"),
    ),
  );
}

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _configureLocalNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/app_logo');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

/// ======