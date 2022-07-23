import 'package:chatopea/modules/social_app/home/home_screen.dart';
import 'package:chatopea/on_boarding_screen.dart';
import 'package:chatopea/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/constants.dart';
import 'cubit/appCubit.dart';
import 'cubit/appStates.dart';
import 'cubit/cubit.dart';
import 'firebase_options.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();



  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      bool? isDark = CacheHelper.getData(
        key: 'isDark',
      );
      Widget? widget;
      // bool? onBoarding = CacheHelper.getData(
      //   key: 'onBoarding',
      // );


      uId = CacheHelper.getData(key: 'uId');
      if (uId != null)
      {
        widget = SocialHomeLayout();
      }else{
        widget = SocialHomeScreen();
      }
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}



class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
            ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
