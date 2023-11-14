import 'package:first_app/bloc/internet_bloc/internet_bloc.dart';
import 'package:first_app/components/drawer.dart';
import 'package:first_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

bool isDark = false;

ThemeData _lightTheme =
    ThemeData(primarySwatch: Colors.amber, brightness: Brightness.light);

ThemeData _darkTheme =
    ThemeData(primarySwatch: Colors.grey, brightness: Brightness.dark);

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDark ? _darkTheme : _lightTheme,
        title: 'Flutter App',
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: '/',
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English, no country code
        ],
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flickr'),
            actions: [
              IconButton(
                icon: Icon(
                  isDark ? Icons.nights_stay : Icons.wb_sunny,
                ),
                iconSize: 26,
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    isDark = !isDark;
                  });
                },
              ),
            ],
          ),
          drawer: const MyDrawer(),
          body: const Home(),
        ),
      ),
    );
  }
}