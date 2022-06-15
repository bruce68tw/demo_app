import 'package:flutter/material.dart';
//import 'package:flutter_artisan/models/countering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'photo_yes.dart';

class MyNotifier extends StateNotifier<Photo2Vo> {
  MyNotifier() : super(Photo2Vo(counter:0));

  //void increment() => state++;
  void increment() => state = state.copyWith(state.counter+1);
}

class Photo2Vo {
  //PhotoVo({this.image1, this.image2});
  Photo2Vo({required this.counter});
  //Image? image1;
  //Image? image2;
  int counter;

  Photo2Vo copyWith(int counter){
    return Photo2Vo(
      counter: counter);
  }  
}

/*
class StateNotifierProviderAppSample extends StatelessWidget {
  const StateNotifierProviderAppSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StateNotifierProviderHome(),
    );
  }
}
*/

  final myProvider = StateNotifierProvider<MyNotifier, Photo2Vo>((ref) => MyNotifier());

class StateNotifierProviderHome extends ConsumerWidget {
  StateNotifierProviderHome({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final counter = ref.watch(_provider);
    final vo = ref.watch(myProvider);
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: Text(
            '${vo.counter}',
            style: const TextStyle(
              fontSize: 60,
              color: Colors.red,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        tooltip: 'Press to Increment',
        onPressed: () {
          ref.read(myProvider.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}