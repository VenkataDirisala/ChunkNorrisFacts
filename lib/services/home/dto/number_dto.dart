class NumberDto {
  NumberDto(this._number, this._isPrime, this._isAlreadyClicked);

  int _number;
  bool _isPrime;
  bool _isAlreadyClicked;

  int get number => _number;

  bool get isPrime => _isPrime;

  bool get isAlreadyClicked => _isAlreadyClicked;

  set isAlreadyClicked(bool value) {
    _isAlreadyClicked = value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberDto &&
          runtimeType == other.runtimeType &&
          _number == other._number &&
          _isPrime == other._isPrime &&
          _isAlreadyClicked == other._isAlreadyClicked;

  @override
  int get hashCode => _number.hashCode ^ _isPrime.hashCode ^ _isAlreadyClicked.hashCode;

  @override
  String toString() {
    return 'NumberDto{_number: $_number, _isPrime: $_isPrime, _isAlreadyClicked: $_isAlreadyClicked}';
  }
}
