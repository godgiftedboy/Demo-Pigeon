import 'dart:developer';

import 'package:demo_pigeon/src/messages.g.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ExampleHostApi api = ExampleHostApi();
  int a = 0;

  /// Calls host method `add` with provided arguments.
  Future<int> add(int a, int b) async {
    try {
      return await api.add(a, b);
    } catch (e) {
      // handle error.
      return 0;
    }
  }

  /// Sends message through host api using `MessageData` class
  /// and api `sendMessage` method.
  Future<bool> sendMessage(String messageText) {
    final MessageData message = MessageData(
      code: Code.one,
      data: <String, String>{'header': 'this is a header'},
      description: 'uri text',
    );
    try {
      return api.sendMessage(message);
    } catch (e) {
      // handle error.
      return Future<bool>(() => true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                final sum = await add(1, 2);
                log(sum.toString());
                setState(() {
                  a = sum;
                });
              },
              child: const Text("Add")),
          Center(
            child: Text('Sum: $a'),
          ),
        ],
      ),
    );
  }
}
