void main() {
  final list = DoublyLinkedList<String>();

  list.addFirst('A');
  list.addFirst('B');
  list.addLast('C');
  list.add('D');

  print('2nd element: ${list[1]}');

  print('peek first: ${list.peekFirst()}');
  print('peek last: ${list.peekLast()}');

  print('elements before remove: $list');

  print('remove first: ${list.removeFirst()}');
  print('elements after removeFirst: $list');

  print('remove: ${list.remove(list._head!.next!)}');
  print('elements after remove: $list');
}

class _Node<T> {
  T? element;
  _Node<T>? prev;
  _Node<T>? next;

  _Node(this.element, this.prev, this.next);

  @override
  String toString() {
    return 'Node($element, $prev, $next)';
  }
}

class DoublyLinkedList<T> {
  _Node<T>? _head;
  _Node<T>? _tail;
  int _size = 0;

  int get size => _size;

  bool get isEmpty => size == 0;

  void clear() {
    if (isEmpty) return;

    _Node<T>? trav = _head;

    while (trav != null) {
      _Node<T>? next = trav.next;

      trav.prev = null;
      trav.next = null;
      trav.element = null;

      trav = next;
    }

    _head = _tail = trav = null;
    _size = 0;
  }

  void add(T value) {
    addLast(value);
  }

  void addFirst(T value) {
    final newNode = _Node(value, null, null);

    if (isEmpty) {
      _head = _tail = newNode;
    } else {
      newNode.next = _head;
      _head!.prev = newNode;
      _head = newNode;
    }

    _size++;
  }

  void addLast(T value) {
    final newNode = _Node(value, null, null);

    if (isEmpty) {
      _head = _tail = newNode;
    } else {
      _tail!.next = newNode;
      newNode.prev = _tail;
      _tail = newNode;
    }

    _size++;
  }

  T? peekFirst() => _head?.element;

  T? peekLast() => _tail?.element;

  T? operator [](int index) {
    if (index < 0 || index >= _size) {
      throw Exception('Invalid index: $index');
    }

    int i;
    _Node<T>? trav;

    if (index < size / 2) {
      trav = _head;

      for (i = 0; i != index; i++) {
        trav = trav?.next;
      }
    } else {
      trav = _tail;

      for (i = size - 1; i != index; i--) {
        trav = trav?.prev;
      }
    }

    return trav?.element;
  }

  T? removeFirst() {
    if (isEmpty) return null;

    final T? element = _head?.element;
    _head = _head?.next;
    _size--;

    if (isEmpty) {
      _tail = null;
    }

    _head?.prev = null;

    return element;
  }

  T? removeLast() {
    if (isEmpty) return null;

    final element = _tail?.element;
    _tail = _tail?.prev;
    --_size;

    if (isEmpty)
      _head = null;
    else
      _tail?.next = null;

    return element;
  }

  T? remove(_Node<T> node) {
    if (node.prev == null) removeFirst();
    if (node.next == null) removeLast();

    node.next?.prev = node.prev;
    node.prev?.next = node.next;

    T? element = node.element;

    node.element = null;
    node.next = node.prev = null;

    --_size;

    return element;
  }

  T? removeAt(int index) {
    if (index < 0 || index >= _size) {
      throw Exception('Invalid index: $index');
    }

    int i;
    _Node<T>? trav;

    if (index < size / 2) {
      trav = _head;

      for (i = 0; i != index; i++) {
        trav = trav?.next;
      }
    } else {
      trav = _tail;

      for (i = size - 1; i != index; i--) {
        trav = trav?.prev;
      }
    }

    if (trav != null) {
      return remove(trav);
    }

    return null;
  }

  @override
  String toString() {
    final buffer = StringBuffer();

    if (isEmpty) return '[]';

    buffer.write('[');
    _Node<T>? tempHead = _head;

    while (tempHead != null) {
      final comma = tempHead.next == null ? '' : ', ';

      buffer.write('${tempHead.element}$comma');
      tempHead = tempHead.next;
    }

    buffer.write(']');

    return buffer.toString();
  }
}
