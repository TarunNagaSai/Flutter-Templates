import 'package:animations/core/theme.dart';
import 'package:animations/src/home/home.dart';
import 'package:animations/src/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Theme data variables
  final materialLightTheme = MaterialTheme(TextTheme()).light();
  final materialDarkTheme = MaterialTheme(TextTheme()).dark();
  late final MaterialBasedCupertinoThemeData cupertinoDarkTheme;
  late final MaterialBasedCupertinoThemeData cupertinoLightTheme;

  @override
  void initState() {
    const darkDefaultCupertinoTheme = CupertinoThemeData(
      brightness: Brightness.dark,
    );

    cupertinoDarkTheme = MaterialBasedCupertinoThemeData(
      materialTheme: materialDarkTheme.copyWith(
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: Brightness.dark,
          barBackgroundColor: darkDefaultCupertinoTheme.barBackgroundColor,
          textTheme: CupertinoTextThemeData(
            primaryColor: Colors.white,
            navActionTextStyle: darkDefaultCupertinoTheme
                .textTheme
                .navActionTextStyle
                .copyWith(color: const Color(0xF0F9F9F9)),
            navLargeTitleTextStyle: darkDefaultCupertinoTheme
                .textTheme
                .navLargeTitleTextStyle
                .copyWith(color: const Color(0xF0F9F9F9)),
          ),
        ),
      ),
    );

    cupertinoLightTheme = MaterialBasedCupertinoThemeData(
      materialTheme: materialLightTheme,
    );

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final themeMode = ref.watch(themeModeProvider);

        return PlatformProvider(
          settings: PlatformSettingsData(
            iosUsesMaterialWidgets: true,
            iosUseZeroPaddingForAppbarPlatformIcon: true,
          ),
          builder: (context) => PlatformTheme(
            themeMode: themeMode,
            materialLightTheme: materialLightTheme,
            materialDarkTheme: materialDarkTheme,
            cupertinoLightTheme: cupertinoLightTheme,
            cupertinoDarkTheme: cupertinoDarkTheme,
            matchCupertinoSystemChromeBrightness: true,

            builder: (context) => const PlatformApp(
              title: 'Flutter UI',
              localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              home: Home(),
            ),
          ),
          // ),
        );
      },
    );
  }
}
