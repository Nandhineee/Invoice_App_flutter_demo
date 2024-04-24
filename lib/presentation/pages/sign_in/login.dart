
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/domain/models/user.dart';
import 'package:invoice/presentation/providers/invoice_provider.dart';
import 'package:invoice/presentation/providers/user_provider.dart';
import 'package:invoice/presentation/pages/invoice_app.dart';
import 'package:lottie/lottie.dart';

import '../../providers/item_price_provider.dart';
import '../home.dart';



class Login extends ConsumerStatefulWidget {
  const Login({Key? key }) : super(key: key,);

  @override
  ConsumerState <Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue.shade900, Colors.white60],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child:  SizedBox(

                    width: 200,
                    height: 150,

                    child: Image.asset('assets/images/login_Image.png', fit: BoxFit.fill),

                  ),


                ),

              ),
              const SizedBox(height: 120),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!_validateEmail(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 3) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 50, // Reduced from 50 to 40
                  width: 70, // Reduced from 250 to 200
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900, borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shadowColor: Colors.white,
                    ),
                    onPressed: () async {
                      // Show Lottie animation
                      showDialog(
                        context: context,
                        barrierDismissible: false, // Prevent dismiss by tapping outside dialog
                        barrierColor: Colors.transparent, // Make dialog barrier transparent
                        builder: (BuildContext context) {
                          return Theme(
                            data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),
                            child: Dialog(
                              backgroundColor: Colors.transparent, // Set Dialog background color to transparent
                              elevation: 0, // Remove shadow if needed
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        color: Colors.transparent, // Ensure container background is also transparent
                                        child: Lottie.asset('assets/animations/loading.json', fit: BoxFit.contain),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );

                      if (_formKey.currentState!.validate()) {
                        final String email = _emailController.text;
                        final String password = _passwordController.text;

                        await ref
                            .read(authUserDetailsProvider.notifier)
                            .authUserDetails(email, password);


                        Navigator.pop(context); // Close the Lottie animation dialog

                        if (ref.read(authUserDetailsProvider.notifier).getAuthUserDetails() is User) {
                          await ref.read(invoiceDetailsProvider.notifier).getInvoice();
                          await ref.read(itemPriceProvider.notifier).storeItem();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid credentials')),
                          );
                        }
                      } else {
                        Navigator.pop(context); // Close the Lottie animation dialog if validation fails
                      }
                    },

                    child: const Text(
                      'Login',
                      style: TextStyle( color: Colors.white, fontSize: 20), // Reduced fontSize from 25 to 20
                    ),
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 10, bottom: 200),
              //   child: TextButton(
              //     onPressed: (){},
              //
              //     child: Text(
              //       ' Register',
              //       style: TextStyle(color: Colors.black, fontSize: 15),
              //     ),
              //   ),
              //
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
