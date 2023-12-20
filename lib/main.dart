import 'package:api/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RickAndMortyApp(appRouter:AppRouter(),));
}

class RickAndMortyApp extends StatelessWidget {


   final AppRouter appRouter ;
   const  RickAndMortyApp({Key? key, required this.appRouter}):super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,

    );
  }


}


