import 'package:equatable/equatable.dart';

abstract class ChucknorrisEvents extends Equatable {
  const ChucknorrisEvents();

  @override
  List<Object> get props => [];
}

class RandomChucknorrisFetchEvent extends ChucknorrisEvents {
  const RandomChucknorrisFetchEvent({this.id});

  // give id to fetch different item every time
  final int id;

  @override
  List<Object> get props => [id];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is RandomChucknorrisFetchEvent &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => super.hashCode ^ id.hashCode;
}
