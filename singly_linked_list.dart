class _Node<T> {
  T? value;
  _Node<T>? next;

  _Node(this.value, this.next);

  @override
  String toString() {
    return 'Node($value, $next)';
  }
}

class SinglyLinkedList<T> {
  _Node<T>? _head;
  _Node<T>? _tail;
  int _size = 0;

  int get size => _size;

  bool get isEmpty => _size == 0;

  T? first() => isEmpty ? null : _head!.value;

  T? last() => isEmpty ? null : _tail!.value;

  void addFirst(T value) {
    _head = _Node<T>(value, _head);

    if (_size == 0) {
      _tail = _head;
    }

    _size++;
  }

  void addLast(T value) {
    final newNode = _Node<T>(value, null);

    if (isEmpty) {
      _head = newNode;
    } else {
      _tail!.next = newNode;
    }

    _tail = newNode;
    _size++;
  }

  T? removeFirst() {
    if (isEmpty) return null;

    final first = _head!.value;

    _head = _head!.next;
    _size--;

    if (_size == 0) {
      _tail = null;
    }

    return first;
  }

  @override
  String toString() {
    final buffer = StringBuffer();

    if (isEmpty) return '[]';

    buffer.write('[');
    _Node<T>? tempHead = _head;

    while (tempHead != null) {
      final comma = tempHead.next == null ? '' : ', ';

      buffer.write('${tempHead.value}$comma');
      tempHead = tempHead.next;
    }

    buffer.write(']');

    return buffer.toString();
  }
}
