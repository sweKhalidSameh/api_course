import 'package:api_course/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:api_course/constants/constants_strings.dart';
import 'package:api_course/constants/my_colors.dart';
import 'package:api_course/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  final phoneNumber;
  OtpScreen({super.key, this.phoneNumber});

  late String otpCode;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Verify your phone number", style: TextStyles.font24BlackBold),
        SizedBox(height: 30),
        RichText(
          text: TextSpan(
            text: 'Enter your 6 digit code numbers sent to you at ',
            style: TextStyles.font18BlackNormal.copyWith(height: 1.4),
            children: <TextSpan>[
              TextSpan(
                text: '$phoneNumber',
                style: TextStyles.font18BlueNormal,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPinCodeFields() {
    return MaterialPinField(
      mainAxisSize: MainAxisSize.max,
      length: 6,
      autoFocus: true,
      keyboardType: TextInputType.number,
      onCompleted: (code) {
        otpCode = code;
        print('PIN: $code');
      },
      onChanged: (value) => print('Changed: $value'),
      theme: MaterialPinTheme(
        cursorColor: Colors.black,
        shape: MaterialPinShape.outlined,
        fillColor: Colors.white,
        focusedFillColor: MyColors.lightBlue,
        focusedBorderColor: MyColors.blue,
        filledFillColor: Colors.white,
        borderWidth: 1.5,
        filledBorderColor: MyColors.blue,
        borderRadius: BorderRadius.circular(12),
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }

  Widget _buildVerifyBotton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(110, 50),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(6),
          ),
        ),
        onPressed: () {
          showProgressIndecator(context);

          _login(context);
        },
        child: Text(
          'Verify',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void showProgressIndecator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
      barrierColor: Colors.white.withValues(alpha: 0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Widget _buildPhoneNumberVerifiedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndecator(context);
        }
        if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(mapsScreen);
        }
        if (state is ErrorOccurred) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 88),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroTexts(),
              SizedBox(height: 88),
              _buildPinCodeFields(),
              SizedBox(height: 60),
              _buildVerifyBotton(context),
              _buildPhoneNumberVerifiedBloc(),
            ],
          ),
        ),
      ),
    );
  }
}
