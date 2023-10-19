class Reader {
  late final List<int> input;
  int _pos = -1;
  bool _end = false;

  Reader(String str) {
    input = str.runes.toList()..add(0);
  }

  int get pos => _pos;
  int get current => input[_pos];
  String get currentString => String.fromCharCode(input[_pos]);

  bool remaining() {
    if (_end) return false;
    if (_pos + 1 >= input.length) {
      _end = true;
      return false;
    }

    return true;
  }

  int next() {
    _pos++;
    return current;
  }

  void previous() => _pos--;

  String getRange(int start, int stop) =>
      String.fromCharCodes(input.sublist(start, stop));
}
