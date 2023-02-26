import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final countStateProvider = StateProvider<int>((ref) => 0);

class ListenPage extends ConsumerWidget {
  const ListenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countStateProvider);
    // Providerを購読する
    ref.listen<int>(
      countStateProvider, // 購読対象のProviderを指定
      (previous, next) {
        // 変更前と変更後の値が受け取れる
        // 行いたい処理を書く
        print('古い値: ${previous}');
        print('新しい値: ${next}');
        Fluttertoast.showToast(
          fontSize: 20.0,
          backgroundColor: Colors.green,
          textColor: Colors.black54,
          msg: '新しい値: ${next}',
          toastLength: Toast.LENGTH_LONG,
        );
      },
      // `onError` で何らかのエラーハンドリングが可能（任意）
      onError: (error, stackTrace) => debugPrint('$error'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('ref.listen ${count.toString()}'),
      ),
      // 数値をSharedPreferencesに保存するロジック
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countStateProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
