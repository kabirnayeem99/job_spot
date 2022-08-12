import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_spot/common/config/app.dart';
import 'package:job_spot/common/config/routes.dart';
import 'package:job_spot/ui/auth/forget_password/bloc/forget_password_bloc.dart';
import 'package:job_spot/ui/auth/log_in/bloc/log_in_bloc.dart';
import 'package:job_spot/ui/home/bloc/home_bloc.dart';
import 'package:job_spot/ui/splash/bloc/splash_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LogInBloc>(create: (context) => LogInBloc()),
        BlocProvider<ForgetPasswordBloc>(
            create: (context) => ForgetPasswordBloc()),
        BlocProvider<SplashBloc>(create: (context) => SplashBloc()),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.dmSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: kDebugMode,
        onGenerateRoute: App.router.generator,
      ),
    );
  }
}
