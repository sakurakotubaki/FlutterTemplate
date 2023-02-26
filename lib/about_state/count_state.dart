import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countStateProvider = StateProvider<int>((ref) => 0);

class StatePage extends ConsumerWidget {
  const StatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countStateProvider);
    // Providerを購読する
    ref.listen<int>(
      countStateProvider, // 購読対象のProviderを指定
      (previous, next) {
        // 変更前と変更後の値が受け取れる
        // 行いたい処理を書きましょう👍
        // ここでは例として、Counterの数値が偶数になったときにダイアログを表示します。
        if (next.isEven) {
          return; // 偶数なら何もしない。
        }
        showDialog<void>(
          context: context,
          builder: (context) {
            return const AlertDialog(
              // ダイアログを表示
              title: Text('Current number is Odd !'),
            );
          },
        );
      },
      // `onError` で何らかのエラーハンドリングが可能（任意）
      onError: (error, stackTrace) => debugPrint('$error'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('StateProvider ${count.toString()}'),
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
