import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 数値を表示するプロバイダー
final countStateProvider = StateProvider<int>((ref) => 0);
// SharedPreferencesは、非同期処理が必要なので、FutureProviderを使用する
// SharedPreferencesから保存されたデータを表示する
final countFutureProvider = FutureProvider<int?>((ref) async {
  final pref = await SharedPreferences.getInstance();
  return pref.getInt('counter');
});

class TemplatePage extends ConsumerWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SharedPreferencesを呼び出す
    final future = ref.watch(countFutureProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                final success = await prefs.remove('counter');
              },
              icon: const Icon(Icons.delete))
        ],
        title: const Text('FutureProvider'),
      ),
      // 数値をSharedPreferencesに保存するロジック
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final counter = ref.read(countStateProvider.notifier).state++;
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final set = prefs.setInt('counter', counter);
          final int? sum = prefs.getInt('counter');
          print(sum); // 保存された値をログに表示
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        // FutureProviderのデータを取得する
        child: future.when(
          error: (err, _) => Text(err.toString()), //エラー時
          loading: () => const CircularProgressIndicator(), //読み込み時
          data: (data) => Text(data.toString()), // 保存された値を表示
        ),
      ),
    );
  }
}
