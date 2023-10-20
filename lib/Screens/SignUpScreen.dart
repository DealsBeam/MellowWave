import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();
  int count = 0;

  var enteredemail = '';
  var enteredpassword = '';

  void submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      if (count == 2) {
        final usercredential = await firebase.signInWithEmailAndPassword(
            email: enteredemail, password: enteredpassword);
        print(usercredential);
      } else {
        final usercredential = await firebase.createUserWithEmailAndPassword(
            email: enteredemail, password: enteredpassword);
        print(usercredential);
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Authenication Failed.")));
    }
  }

  Widget? content;
  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      content = Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              width: double.infinity,
              child: Image.asset('assets/images/back2.jpg'),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                color: Color(0xFF48426D),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome to MellowWave',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFFEFC28D),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Relax and enjoy Lofi beats\neffortlessly.',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFFEFC28D),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 45),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        count = 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Color(0xFF292541),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: GoogleFonts.montserrat(
                          color: Color(0xFFEFC28D),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            count = 2;
                          });
                        },
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (count == 1) {
      content = Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              width: double.infinity,
              child: Image.asset('assets/images/back2.jpg'),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
                width: double.infinity,
                height: 500,
                decoration: const BoxDecoration(
                  color: Color(0xFF48426D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Create a new account',
                      style: GoogleFonts.montserrat(
                          color: Color(0xFFEFC28D),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 200,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Color(0xFFEFC28D)),
                              decoration: InputDecoration(
                                labelText: 'Email address',
                                hintText: 'Enter your email',
                                labelStyle: TextStyle(color: Color(0xFFEFC28D)),
                                hintStyle: TextStyle(color: Color(0xFFEFC28D)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                enteredemail = newValue!;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              style: TextStyle(color: Color(0xFFEFC28D)),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                labelStyle: TextStyle(color: Color(0xFFEFC28D)),
                                hintStyle: TextStyle(color: Color(0xFFEFC28D)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'please enter a password with more than 6 letters';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                enteredpassword = newValue!;
                              },
                            ),
                          ],
                        ),
                      )),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Color(0xFF292541),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFEFC28D)),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              count = 2;
                            });
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      );
    } else if (count == 2) {
      content = Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              width: double.infinity,
              child: Image.asset('assets/images/back2.jpg'),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
                width: double.infinity,
                height: 500,
                decoration: const BoxDecoration(
                  color: Color(0xFF48426D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome back',
                      style: GoogleFonts.montserrat(
                          color: Color(0xFFEFC28D),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 200,
                      width: 300,
                      child: SingleChildScrollView(
                          child: Form(
                        key: _form,
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Color(0xFFEFC28D)),
                              decoration: InputDecoration(
                                labelText: 'Email address',
                                hintText: 'Enter your email',
                                labelStyle: TextStyle(color: Color(0xFFEFC28D)),
                                hintStyle: TextStyle(color: Color(0xFFEFC28D)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                enteredemail = newValue!;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              style: TextStyle(color: Color(0xFFEFC28D)),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                labelStyle: TextStyle(color: Color(0xFFEFC28D)),
                                hintStyle: TextStyle(color: Color(0xFFEFC28D)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'please enter a password with more than 6 letters';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                enteredpassword = newValue!;
                              },
                            ),
                          ],
                        ),
                      )),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Color(0xFF292541),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          'Sign in',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: GoogleFonts.montserrat(
                            color: Color(0xFFEFC28D),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              count = 1;
                            });
                          },
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      );
    }

    return Scaffold(body: content);
  }
}
