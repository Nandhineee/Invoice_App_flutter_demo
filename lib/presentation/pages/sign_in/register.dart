import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class Registerpage extends ConsumerStatefulWidget {
  const Registerpage({super.key});

  @override
  ConsumerState <Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends ConsumerState<Registerpage> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    // Initially password is obscure
    _passwordVisible = false;
  }


//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: RegistrationPage(),
//     );
//   }
// }
//
// class RegistrationPage extends StatelessWidget {




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

        child: ListView(
          children: <Widget>[

            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,

                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
          TextFormField(
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
            ),

            const SizedBox(height: 30),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.green, borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {}, // Add your onPressed code here!
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 200),
                  child: TextButton(
                    onPressed: () {

                        // ref
                        //     .read(userDataProvider.notifier)
                        //     .authUser(password, name, email);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const TestApp()),
                        // );

                    },
                    child: const Text(
                      'Already Have an Account? Sign in',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),

                  ),


                ),


              ],
            )

          ],
        ),
      ),
    );
  }
}
