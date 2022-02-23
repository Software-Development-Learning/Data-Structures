class Queue<T> {
  final _list = <T>[];

  int get size => _list.length;

  bool get isEmpty => size == 0;

  void enqueue(T value) {
    _list.add(value);
  }

  void dequeue() {
    if (isEmpty) return;

    _list.removeAt(0);
  }

  T? peek() {
    if (isEmpty) return null;

    return _list.first;
  }
}
