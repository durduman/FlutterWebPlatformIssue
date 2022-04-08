import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => const MaterialApp(home: MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> order = [
    1,
    2,
  ];

  void _reverseOrder() {
    setState(() {
      order = order.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Stack(
          children: order
              .map<Widget>((o) => Positioned(
                    key: Key(o.toString() + o.toString()),
                    /*
                    key is used
                    */
                    left: o * 100,
                    top: o * 100,
                    width: o * 250,
                    height: o * 250,
                    child: Stack(
                      children: [
                        child(o),
                        Center(child: Text(o.toString())),
                      ],
                    ),
                  ))
              .toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: _reverseOrder,
        tooltip: 'Reverse order of widgets',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget child(int id) {
  return createIFrame(
    'sample.pdf',
    id.toString(),
  );

  // // Works without issues with non platform widgets
  // return Container(
  //   color: Color.fromARGB(255, 100 * id, 100 * id, 100 * id),
  // );
}

Widget createIFrame(
  String url,
  String id,
) {
  ui.platformViewRegistry.registerViewFactory(
    id,
    (int viewId) => html.IFrameElement()..src = url,
  );
  return HtmlElementView(viewType: id);
}
