class Stack<T> {
  final _list = <T>[];

  int get size => _list.length;

  bool get isEmpty => size == 0;

  void push(T value) {
    _list.add(value);
  }

  T? pop() {
    if (isEmpty) return null;

    return _list.removeLast();
  }

  T? peek() {
    if (isEmpty) return null;

    return _list.last;
  }
}
