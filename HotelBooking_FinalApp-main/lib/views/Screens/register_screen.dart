import 'package:booking_app/Widgets/register_btn.dart';
import 'package:booking_app/Widgets/text_form_field.dart';
import 'package:booking_app/presentation/components/declarations/constants/constants.dart';
import 'package:booking_app/views/Register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_app/presentation/components/loader.dart';
import 'package:booking_app/presentation/components/spacers.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

late FocusNode usernameFocus;
late FocusNode passwordFocus;
late FocusNode loginBtnFocus;
late TextEditingController userName;
late TextEditingController password;

class _RegisterScreenState extends State<RegisterScreen> {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
            icon: const Icon(Icons.arrow_forward),
            color: Colors.black,
          )
        ],
      ),
      // backgroundColor: Colors.transparent,
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            clearTextData();
            Navigator.of(context).pushNamed('/');
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading) {
            return LoadingWidget(child: buildInitialInput());
          } else {
            return buildInitialInput();
          }
        },
      ),
    );
  }

  Widget buildInitialInput() => SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 90, 10, 70),
            child: Column(
              children: [
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 35),
                ),
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
                RegisterBtn(
                  focusNode: loginBtnFocus,
                  userName: userName,
                  password: password,
                  btnClicked: () {
                    BlocProvider.of<RegisterBloc>(context)
                        .add(RegisterUser(userName.text, password.text));
                  },
                ),
                // RichText(
                //     text: TextSpan(children: [
                //   TextSpan(
                //     text: 'Need an account?',
                //     style: TextStyle(color: Colors.black),
                //   ),
                //   WidgetSpan(
                //       child: SizedBox(
                //     width: 8,
                //   )),
                //   TextSpan(
                //       text: "Register here",
                //       style: TextStyle(color: Colors.black),
                //       recognizer: TapGestureRecognizer()
                //         ..onTap = () {
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) =>MyHomePage() ));
                //         }),
                // ]))
              ],
            ),
          ),
        ),
      );

  clearTextData() {
    userName.clear();
    password.clear();
  }
}
