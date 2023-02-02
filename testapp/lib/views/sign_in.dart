import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/services/auth/auth_exceptions.dart';

import 'package:testapp/services/auth/auth_services.dart';
import 'package:testapp/views/main_view.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // AuthService.firebase().initialize();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white10,
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage(
              'assets/background.jpg',
            ),
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.transparent, Colors.white],
                      stops: [0.0, 0.35])),
            ),
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: const BackButton(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Image(
                        image: AssetImage('assets/background.jpg'),
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Welcome Back',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Text(
                            'SignIn to your account',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          // suffixIcon: ,
                        ),
                      ),
                      const SizedBox(height: 15),
                      MaterialButton(
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () async {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            try {
                              await AuthService.firebase()
                                  .logIn(email: email, password: password);
                              final user = AuthService.firebase().currentUser;
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const MyHomePage();
                              }));
                            } on UserNotFoundAuthException {
                            } on WrongPasswordAuthException {
                            } on GenericAuthException {}
                          },
                          child: Container(
                            height: 48,
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      const SizedBox(height: 30),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                              text: 'Sign Up',
                              style: const TextStyle(
                                color: Colors.purple,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {}),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          Expanded(
                              child: Divider(
                            height: 1.5,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            height: 1.5,
                          )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                  'assets/icons/facebook.svg')),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  SvgPicture.asset('assets/icons/twitter.svg')),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  SvgPicture.asset('assets/icons/google.svg')),
                          IconButton(
                              onPressed: () {},
                              icon: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? SvgPicture.asset('assets/icons/apple.svg')
                                  : SvgPicture.asset('assets/icons/apple.svg')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                            text: 'Skip',
                            style: const TextStyle(color: Colors.black54),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
