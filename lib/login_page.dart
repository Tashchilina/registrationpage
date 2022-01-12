import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login',
      home: LoginPageScreen(title: 'Login'),
    );
  }
}

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  int _controller = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller = (prefs.getInt('controller') ?? 0);
    });
  }

  @override
  void _incrementCounter() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller = (prefs.getInt('controller') ?? 0)+1;
      prefs.setInt('controller', _controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    const borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        borderSide: BorderSide(
            color: const Color(0xFFbbbbbb), width: 2,));
        return Scaffold(
          appBar: AppBar(
            title: const Text('Registration page'),
          ),
          body: Center(
            child: SizedBox(width: 224,
             child: TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
              filled: true,
              fillColor: Color (0xFFeceff1),
              enabledBorder: borderStyle,
              focusedBorder: borderStyle,
              labelText: 'Login',
              ),
              onSubmitted: (String value) async {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Thanks!'),
                    content: Text(
                        'You typed "$value", which has length ${value.characters.length}.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
