import 'package:flutter/material.dart';
import 'package:base_lib/all.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'all_com.dart';

class Model {
  final int id;
  final Color color;

  Model(this.id, this.color);
}

class ContainerListState extends StateNotifier<List<Model>> {
  ContainerListState() : super(const []);

  static final provider = StateNotifierProvider<ContainerListState, List<Model>>((ref) {
    return ContainerListState();
  });

  void setAllColor(Color color) {
    state = state.map((model) => Model(model.id, color)).toList();
  }

  void setModelColor(Model model, Color color) {
    final id = model.id;
    state = state.map((model) {
      return model.id == id ? Model(id, color) : model;
    }).toList();
  }

  void addItem() {
    // TODO: Replace state.length with your unique ID
    state = [...state, Model(state.length, Colors.lightBlue)];
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelList = ref.watch(ContainerListState.provider);
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView of Containers'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ref.read(ContainerListState.provider.notifier).addItem();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: modelList.length,
        itemBuilder: (_, index) {
          return ContainerWithButton(model: modelList[index], ref: ref);
        },
      ),
      floatingActionButton: RedButton(),
    );
  }
}

class ContainerWithButton extends StatelessWidget {
  const ContainerWithButton({
    Key? key,
    required this.ref,
    required this.model,
  }) : super(key: key);

  final WidgetRef ref;
  final Model model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: model.color,
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
        onPressed: () {
          //context.read(ContainerListState.provider.notifier).setModelColor(model, Colors.purple);
          ref.read(ContainerListState.provider.notifier).setModelColor(model, Colors.purple);
        },
        child: Text('Button'),
      ),
    );
  }
}

class RedButton extends ConsumerWidget {
  const RedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Bonus: Red button will be notified on changes
    final state = ref.watch(ContainerListState.provider);

    return FloatingActionButton.extended(
      onPressed: () {
        ref.read(ContainerListState.provider.notifier).setAllColor(Colors.orange);
      },
      backgroundColor: Colors.red,
      label: Text('Set all color'),
    );
  }
}