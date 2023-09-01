import 'package:booking_app/Widgets/login_btn.dart';
import 'package:booking_app/Widgets/social_signin.dart';
import 'package:booking_app/Widgets/text_data_widget.dart';
import 'package:booking_app/Widgets/text_form_field.dart';
import 'package:booking_app/presentation/components/declarations/constants/constants.dart';
import 'package:booking_app/views/Login/bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app/presentation/components/declarations/Images/images.dart';
import 'package:booking_app/presentation/components/image_builder.dart';
import 'package:booking_app/presentation/components/loader.dart';
import 'package:booking_app/presentation/components/spacers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FocusNode usernameFocus;
  late FocusNode passwordFocus;
  late FocusNode loginBtnFocus;
  late TextEditingController userName;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    loginBtnFocus = FocusNode();
    userName = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    loginBtnFocus.dispose();
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            buildErrorLayout();
          } else if (state is AuthLoaded) {
            clearTextData();
            Navigator.of(context).pushNamed('/dashboardScreen');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return LoadingWidget(child: buildInitialInput());
          } else {
            return buildInitialInput();
          }
        },
      ),
    );
  }

  Widget buildInitialInput() => SingleChildScrollView(
        child: Column(
          children: [
            ImageBuilder(imagePath: loginImages[1]),
            const TextData(message: "User"),
            HeightSpacer(myHeight: kSpacing),
            InputField(
              focusNode: usernameFocus,
              textController: userName,
              label: "Username",
              icons: const Icon(Icons.person, color: Colors.blue),
            ),
            HeightSpacer(myHeight: kSpacing),
            InputField(
              focusNode: passwordFocus,
              textController: password,
              label: "Password",
              icons: const Icon(Icons.lock, color: Colors.blue),
            ),
            HeightSpacer(myHeight: kSpacing),
            LoginBtn(
              focusNode: loginBtnFocus,
              userName: userName,
              password: password,
              btnClicked: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(Login(userName.text, password.text));
              },
            ),
            HeightSpacer(myHeight: kSpacing),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                text: 'Need an account?',
                style: TextStyle(color: Colors.black),
              ),
              const WidgetSpan(
                  child: SizedBox(
                width: 8,
              )),
              TextSpan(
                  text: "Register here",
                  style: const TextStyle(color: Colors.black),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed('/register');
                    }),
            ]))
          ],
        ),
      );

  ScaffoldFeatureController buildErrorLayout() =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Credential!'),
        ),
      );

  clearTextData() {
    userName.clear();
    password.clear();
  }
}
