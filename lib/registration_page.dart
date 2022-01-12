import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatelessWidget {
 const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counters',
      home: RegistrationPage(storage: CounterStorage(), title: 'Counters'),
    );
  }
}

class CounterStorage{
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return File ('$path/counter/txt');
  }

  Future<int> readCounter() async{
    try {
      final file = await _localFile;

      //Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // if encountering is error
      return 0;
    }
  }
  Future<File> writeCounter(int counter) async{
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$counter');
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key,required this.storage, required this.title}) : super(key: key);
  final CounterStorage storage;
  final String title;

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int _counter = 0;
  int _counter2 =0;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  void _loadCounter() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter2 = (prefs.getInt('counter2') ?? 0);
    });
  }

  @override
  void _incrementCounter2() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter2 = (prefs.getInt('counter2') ?? 0)+1;
      prefs.setInt('counter2', _counter2);
    });
  }

      Future<File> _inCrementCounter(){
    setState(() {
      _counter++;
    });
    //Write the variable as a string to the file
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counters',
          style: GoogleFonts.sansitaSwashed()
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add to cart $_counter product${_counter==1?'':'s'}.',
                    style: const TextStyle(color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial'),
                    ),
                const SizedBox(height: 20,),
                FloatingActionButton(
                  onPressed: _inCrementCounter,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 50,),
                const Text('You are making a money transfer in the amount of:',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF008080),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial'
                ),
                ),
                Text('$_counter2',
                  style: const TextStyle(color: Color(0xFF008080),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial'
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                 width: 154,
                 height: 42,
                  child: ElevatedButton(
                   onPressed: _incrementCounter2,
                    child: const Text('Добавить',
                    style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF008080),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36.0),
                    ),
                    ),
                ),
            ),
         ]
        ),
          ),
       ),
      ),
    );
  }
}
