
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:technical_test/services/home/dto/number_dto.dart';
import 'package:technical_test/services/service_factory.dart';

import 'number_events.dart';
import 'number_states.dart';

class NumbersBloc extends Bloc<NumbersEvents, NumbersStates> {
  NumbersBloc() : super(NumbersUninitializedState());

  final numberService = ServiceFactory.instance.getNumberService();

  @override
  Stream<Transition<NumbersEvents, NumbersStates>> transformEvents(
    Stream<NumbersEvents> events,
    transitionFn,
  ) {
    return super
        .transformEvents(events.debounceTime(const Duration(milliseconds: 300)), transitionFn);
  }

  @override
  Stream<NumbersStates> mapEventToState(NumbersEvents event) async* {
    final currentState = state;
    if (event is NumberDtosFetchEvent) {
      try {
        if (currentState is NumbersErrorState || currentState is NumbersUninitializedState) {
          final numberDtos = await _fetchNumberList();
          if (numberDtos.isEmpty) {
            yield NumbersErrorState();
            return;
          }

          yield NumbersLoadedState(numberDtos: numberDtos);
        }

        if (currentState is NumbersLoadedState) {
          final numberDtos = await _fetchNumberList();

          yield NumbersLoadedState(numberDtos: numberDtos);
        }
      } catch (e) {
        debugPrint(e.toString());
        yield NumbersErrorState(exception: e);
      }
    } else if (event is NewClickedNumberAddEvent) {
      try {
        final numberDtos = await _fetchNumberList();

        // if number is successfully added
        if (await _addClickedNumber(event.newNumber)) {
          yield NumberSuccessfullyAddedState(numberDto: numberDtos[event.newNumber - 1]);
        }
        // if number already clicked
        else {
          yield NumberAlreadyClickedState(
            id: DateTime.now().millisecondsSinceEpoch,
            numberDto: numberDtos[event.newNumber - 1],
            numberDtos: numberDtos,
          );
        }
      } catch (e) {
        debugPrint(e.toString());
        yield NumbersErrorState(exception: e);
      }
    }
  }

  Future<bool> _addClickedNumber(int newNumber) async {
    return numberService.addNewClickedNumber(newNumber);
  }

  Future<List<NumberDto>> _fetchNumberList() async {
    return numberService.getNumberDtos();
  }
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
