void main() {
  final myList = LinkedList<String>();

  myList.push('A');
  myList.push('B');
  myList.push('C');

  myList.append('D');

  final node = myList.nodeAt(2);

  myList.insertAfter(node!, 'E');

  for (var value in myList) {
    print(value);
  }
}

class Node<E> {
  Node({required this.value, this.next});

  E value;
  Node<E>? next;

  @override
  String toString() {
    if (next == null) return '$value';
    return '$value -> ${next.toString()}';
  }
}

class LinkedList<E> extends Iterable<E> {
  Node<E>? _head;
  Node<E>? _tail;

  bool get isEmpty => _head == null;

  void push(E value) {
    _head = Node(value: value, next: _head);
    _tail ??= _head;
  }

  void append(E value) {
    if (isEmpty) {
      push(value);
      return;
    }

    _tail!.next = Node(value: value);
    _tail = _tail!.next;
  }

  Node<E> insertAfter(Node<E> node, E value) {
    if (_tail == node) {
      append(value);
      return _tail!;
    }

    node.next = Node(value: value, next: node.next);
    return node.next!;
  }

  Node<E>? nodeAt(int index) {
    var currentNode = _head;
    var currentIndex = 0;

    while (currentNode != null && currentIndex < index) {
      currentNode = currentNode.next;
      currentIndex += 1;
    }
    return currentNode;
  }

  E? pop() {
    final value = _head?.value;
    _head = _head?.next;

    if (isEmpty) {
      _tail = null;
    }

    return value;
  }

  E? removeLast() {
    if (_head?.next == null) return pop();

    var current = _head;
    while (current!.next != _tail) {
      current = current.next;
    }

    final value = _tail?.value;
    _tail = current;
    _tail?.next = null;

    return value;
  }

  E? removeAfter(Node<E> node) {
    final value = node.next?.value;

    if (node.next == _tail) {
      _tail = node;
    }
    node.next = node.next?.next;
    return value;
  }

  @override
  String toString() {
    if (isEmpty) return 'Empty list';
    return _head.toString();
  }

  @override
  Iterator<E> get iterator => _LinkedListIterator(this);
}

class _LinkedListIterator<E> implements Iterator<E> {
  _LinkedListIterator(LinkedList<E> list) : _list = list;

  final LinkedList<E> _list;

  Node<E>? _currentNode;
  bool _firstPass = true;

  @override
  E get current => _currentNode!.value;

  @override
  bool moveNext() {
    if (_list.isEmpty) return false;

    if (_firstPass) {
      _currentNode = _list._head;
      _firstPass = false;
    } else {
      _currentNode = _currentNode?.next;
    }

    return _currentNode != null;
  }
}
