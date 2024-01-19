import 'package:flutter/material.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp( {super.key} );
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Flutter Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const  HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  const HomePage( {super.key} );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           const Text(
              'Welcome to Flutter!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
           const SizedBox(height: 20),
            const FlutterLogo(size: 100),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality here
              },
              child: const Text('Press Me'),
            ),
          ],
        ),
      ),
    );
  }
}
