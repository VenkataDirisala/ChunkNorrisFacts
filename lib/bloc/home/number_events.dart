import 'package:equatable/equatable.dart';

abstract class NumbersEvents extends Equatable {
  const NumbersEvents();

  @override
  List<Object> get props => [];
}

class NumberDtosFetchEvent extends NumbersEvents {
  const NumberDtosFetchEvent();

  @override
  List<Object> get props => [];
}

class NewClickedNumberAddEvent extends NumbersEvents {
  const NewClickedNumberAddEvent({this.newNumber});

  final int newNumber;

  @override
  List<Object> get props => [newNumber];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is NewClickedNumberAddEvent &&
          runtimeType == other.runtimeType &&
          newNumber == other.newNumber;

  @override
  int get hashCode => super.hashCode ^ newNumber.hashCode;
}
