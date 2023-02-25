import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.indigoAccent, // AppBarの色.
        foregroundColor: Colors.grey, // AppBarのフォントの色.
        centerTitle: true, // AppBarのAndroidのタイトルを中央寄せにする.
      )),
      home: const TemplatePage(),
    );
  }
}

class TemplatePage extends ConsumerWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template'),
      ),
    );
  }
}
