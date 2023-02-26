import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 文字列のリストを返したいので、<List<String>>を定義する.
class MyNotifier extends StateNotifier<List<String>> {
  // 最初の状態を取得したいときに、空のリストを返す.
  // 基本的にsuperを使用して初期状態を定義している.
  MyNotifier() : super([]);

  // 古い状態を置き換える必要がある.
  // 値が追加されると古い状態に置き換わる.
  void addString(String toAdd) {
    // スプレッド演算子で状態を分散させ、次に文字列を追加する.
    state = [...state, toAdd];
  }
}

// 外部ファイルで、StateNotifierを呼び出せるプロバイダーを定義する.
final myNotifier = StateNotifierProvider((ref) => MyNotifier());

class MyNotifierPage extends ConsumerWidget {
  const MyNotifierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 乱数を生成する.
    Random random = new Random();
    // List型なのでキャストする.
    // プロバイダーが状態が変化するのを監視している.
    final listOfString = ref.watch(myNotifier) as List;

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifireProvider'),
      ),
      // ボタンをクリックするたびに乱数を生成する.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // StateNotifierProviderを使ってメソッドにアクセスする.
          // 0~100までの数値を生成する.
          ref.read(myNotifier.notifier).addString('string '
              '${random.nextInt(100)}');
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            // map((e)) => Text(e)).toList();と同じことをしている.
            ...listOfString.map(
              (e) => Text(e),
            ),
          ],
        )),
      ),
    );
  }
}
