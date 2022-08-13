import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/config/app.dart';
import 'common/config/routes.dart';

void main() async => runApp(const JobSpotApp());

class JobSpotApp extends StatefulWidget {
  const JobSpotApp({Key? key}) : super(key: key);

  @override
  State<JobSpotApp> createState() => _JobSpotAppState();
}

class _JobSpotAppState extends State<JobSpotApp> {
  _JobSpotAppState() {
    final router = FluroRouter.appRouter;
    Routes.configureRoutes(router);
    App.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: kDebugMode,
      onGenerateRoute: App.router.generator,
    );
  }
}
