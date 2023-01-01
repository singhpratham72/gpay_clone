import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpay_clone/constants/colors.dart';
import 'package:gpay_clone/constants/textstyles.dart';
import 'package:gpay_clone/cubit/payment_cubit/payment_cubit.dart';
import 'package:gpay_clone/screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<PaymentCubit>(create: (_) => PaymentCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GPay Clone',
        theme: ThemeData(
            textTheme: TextTheme(bodyText2: TextStyles.bodyText),
            iconTheme: const IconThemeData(color: Colors.white),
            colorScheme: const ColorScheme.light(
                primary: ApplicationColors.primaryColor),
            primaryColor: ApplicationColors.primaryColor,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: ApplicationColors.primaryColor,
            fontFamily: GoogleFonts.inter().fontFamily),
        home: const LandingScreen(),
      ),
    );
  }
}
