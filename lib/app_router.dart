import 'package:api_course/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:api_course/constants/constants_strings.dart';
import 'package:api_course/presentation/screens/login_screen.dart';
import 'package:api_course/presentation/screens/maps_screen.dart';
import 'package:api_course/presentation/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: phoneAuthCubit!, child: LoginScreen()),
        );
      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
      case mapsScreen:
        return MaterialPageRoute(builder: (_) => MapsScreen());
    }
  }
}
