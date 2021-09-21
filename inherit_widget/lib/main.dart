import 'package:flutter/material.dart';

class Counter {
  int _count;
  int get count => _count;

  Counter(this._count);

  void increment() {
    _count++;
  }

  void decrement() {
    _count--;
  }
}

class CounterWidget extends StatefulWidget {
  Counter counter;

  CounterWidget(this.counter);

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return CounterInheritedWidget(
        counter: widget.counter,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text("CounterApp")),
            body: CounterMessage(),
            floatingActionButton: FloatingActionButton(
              onPressed: () => increment(),
              child: const Icon(Icons.add),
            ),
          ),
        ));
  }

  void increment() {
    setState(() {
      widget.counter.increment();
    });
  }

  void decrement() {
    setState(() {
      widget.counter.decrement();
    });
  }
}

class CounterMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(CounterInheritedWidget.of(context, listen: true)!
            .counter
            .count
            .toString()));
  }
}

class CounterInheritedWidget extends InheritedWidget {
  const CounterInheritedWidget({
    Key? key,
    required this.counter,
    required Widget child,
  }) : super(key: key, child: child);

  final Counter counter;

  static CounterInheritedWidget? of(
    BuildContext context, {
    required bool listen,
  }) {
    return listen
        ? context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()
        : context
            .getElementForInheritedWidgetOfExactType<CounterInheritedWidget>()
            ?.widget as CounterInheritedWidget;
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget old) =>
      counter.count != old.counter.count;
}

void main() {
  runApp(CounterWidget(Counter(0)));
}
