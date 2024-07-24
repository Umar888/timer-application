
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_application/widgets/home/screens/home_page.dart';
import 'package:timer_application/widgets/home/screens/home_screen.dart';
import 'widgets/home/bloc/home_bloc.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(title: "Timer Application"))
    );
  }
}
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey=GlobalKey<ScaffoldMessengerState>();


