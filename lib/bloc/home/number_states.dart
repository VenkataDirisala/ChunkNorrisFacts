
import 'package:equatable/equatable.dart';
import 'package:technical_test/services/home/dto/number_dto.dart';

abstract class NumbersStates extends Equatable {
  const NumbersStates();

  @override
  List<Object> get props => [];
}

class NumbersUninitializedState extends NumbersStates {}

class NumbersErrorState extends NumbersStates {
  const NumbersErrorState({this.exception});

  final dynamic exception;
}

class NumberAlreadyClickedState extends NumbersStates {
  const NumberAlreadyClickedState({this.id, this.numberDto, this.numberDtos});

  // id is necessary to set same state more then once
  // if id is not set, same state is not got many times from bloc,
  // so second click event of same number cannot be seen
  final id;
  final NumberDto numberDto;
  final List<NumberDto> numberDtos;

  @override
  List<Object> get props => [numberDto, numberDtos, id];

  @override
  String toString() {
    return 'NumberAlreadyClickedState{numberDto: $numberDto, numberDtos: $numberDtos, id: $id}';
  }
}

class NumberSuccessfullyAddedState extends NumbersStates {
  const NumberSuccessfullyAddedState({this.numberDto});

  final NumberDto numberDto;

  @override
  List<Object> get props => [numberDto];

  @override
  String toString() {
    return 'NumberSuccessfullyAddedState{numberDto: $numberDto}';
  }
}

class NumbersLoadedState extends NumbersStates {
  const NumbersLoadedState({this.numberDtos});

  final List<NumberDto> numberDtos;

  @override
  List<Object> get props => [numberDtos];

  @override
  String toString() {
    return 'NumbersLoaded{numberDtos length: ${numberDtos.length}';
  }
}
