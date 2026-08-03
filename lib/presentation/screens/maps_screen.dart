import 'package:api_course/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:api_course/constants/constants_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: BlocProvider<PhoneAuthCubit>(
            create: (context) => phoneAuthCubit,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(110, 50),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(6),
                ),
              ),
              onPressed: () async {
                await phoneAuthCubit.logOut();
                Navigator.of(context).pushReplacementNamed(loginScreen);
              },
              child: Text(
                'LoginOut',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
