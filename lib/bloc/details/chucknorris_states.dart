
import 'package:equatable/equatable.dart';
import 'package:technical_test/services/details/dto/chuck_norris_dto.dart';

abstract class ChucknorrisStates extends Equatable {
  const ChucknorrisStates();

  @override
  List<Object> get props => [];
}

class ChucknorrisUnitializedState extends ChucknorrisStates {}

class ChucknorrisErrorState extends ChucknorrisStates {
  const ChucknorrisErrorState({this.exception});

  final dynamic exception;
}

class ChucknorrisEmptyState extends ChucknorrisStates {}

class ChucknorrisLoadedState extends ChucknorrisStates {
  const ChucknorrisLoadedState({this.chucknorrisDto});

  final ChucknorrisDto chucknorrisDto;

  @override
  List<Object> get props => [chucknorrisDto];

  @override
  String toString() {
    return 'ChucknorrisLoaded{chucknorris: $chucknorrisDto}';
  }
}
