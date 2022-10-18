import 'package:flickr_image/routes/routes.dart';
import 'package:flickr_image/screens/Home/homeScreen.dart';
import 'package:flickr_image/cubit/theme/theme_cubit.dart';
import 'package:flickr_image/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flickr App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            onGenerateRoute: Routes.onGenerateRoute,
            initialRoute: '/',
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', ''),
            ],
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
