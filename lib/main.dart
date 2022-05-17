import 'package:breaking_bad/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( BreakingBadApp(appRouter: AppRouter(),));
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // دي بظبط بيها ال routes اللي عندي بعمل هنا class بيظبط ال routes  عندي
      onGenerateRoute:appRouter.generateRoute ,
    );
  }
}
