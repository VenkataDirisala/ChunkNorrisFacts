import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:technical_test/services/details/dto/chuck_norris_dto.dart';
import 'package:technical_test/services/service_factory.dart';

import 'chucknorris_events.dart';
import 'chucknorris_states.dart';

class ChucknorrisBloc extends Bloc<ChucknorrisEvents, ChucknorrisStates> {
  ChucknorrisBloc() : super(ChucknorrisUnitializedState());

  final chucknorrisService = ServiceFactory.instance.getChucknorrisService();

  @override
  Stream<Transition<ChucknorrisEvents, ChucknorrisStates>> transformEvents(
    Stream<ChucknorrisEvents> events,
    TransitionFunction<ChucknorrisEvents, ChucknorrisStates> transitionFn,
  ) {
    return super
        .transformEvents(events.debounceTime(const Duration(milliseconds: 300)), transitionFn);
  }

  @override
  Stream<ChucknorrisStates> mapEventToState(ChucknorrisEvents event) async* {
    final currentState = state;
    if (event is RandomChucknorrisFetchEvent) {
      try {
        if (currentState is ChucknorrisErrorState || currentState is ChucknorrisUnitializedState) {
          final chucknorrisDtos = await _fetchChucknorrisList();
          if (chucknorrisDtos.isEmpty) {
            yield ChucknorrisEmptyState();
            return;
          }

          yield ChucknorrisLoadedState(
              chucknorrisDto: chucknorrisDtos[Random().nextInt(chucknorrisDtos.length)]);
          return;
        }

        if (currentState is ChucknorrisLoadedState) {
          final chucknorrisList = await _fetchChucknorrisList();

          yield ChucknorrisLoadedState(
            chucknorrisDto: chucknorrisList[Random().nextInt(chucknorrisList.length)],
          );
        }
      } catch (e) {
        debugPrint(e.toString());
        yield ChucknorrisErrorState(exception: e);
      }
    }
  }

  Future<List<ChucknorrisDto>> _fetchChucknorrisList() async {
    return chucknorrisService.getChucknorrisList();
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
