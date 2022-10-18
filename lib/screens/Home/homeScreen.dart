import 'package:flickr_image/components/drawer.dart';
import 'package:flickr_image/screens/Home/searchImage.dart';
import 'package:flickr_image/cubit/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flickr'),
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state == ThemeMode.dark ? Icons.nights_stay : Icons.wb_sunny,
                ),
                iconSize: 26,
                color: Colors.black,
                onPressed: () {
                  context
                      .read<ThemeCubit>()
                      .toggleTheme(state == ThemeMode.dark ? false : true);
                },
              );
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SearchImage(),
    );
  }
}
