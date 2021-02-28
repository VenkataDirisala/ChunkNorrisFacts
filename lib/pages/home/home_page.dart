
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/bloc/home/number_events.dart';
import 'package:technical_test/bloc/home/number_states.dart';
import 'package:technical_test/bloc/home/numbers_bloc.dart';
import 'package:technical_test/common/constants/general_constants.dart';
import 'package:technical_test/pages/details/details_page.dart';
import 'package:technical_test/pages/home/widgets/number_card.dart';
import 'package:technical_test/services/home/dto/number_dto.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<NumberDto> numberDtos;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NumbersBloc>(context).add(const NumberDtosFetchEvent());
  }

  void _onNumberClicked(NumberDto numberDto) {
    if (numberDto.isPrime == false) {
      showInSnackBar('Sorry, ${numberDto.number} is not prime number');
      return;
    }
    BlocProvider.of<NumbersBloc>(context)
        .add(NewClickedNumberAddEvent(newNumber: numberDto.number));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(GeneralConstants.APP_TITLE),
      ),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<NumbersBloc, NumbersStates>(
          builder: (context, NumbersStates state) {
            debugPrint('state in home -> ${state}');
            if (state is NumbersUninitializedState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NumbersErrorState) {
              return const Center(
                child: Text(
                  'Failed to fetch numbers',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is NumbersLoadedState) {
              numberDtos = state.numberDtos;
              return _generateCardList(numberDtos);
            }

            if (state is NumberSuccessfullyAddedState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return DetailsPage();
                    },
                  ),
                );
              });

              return _generateCardList(numberDtos);
            }

            if (state is NumberAlreadyClickedState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showInSnackBar('${state.numberDto.number} already clicked');
              });
              return _generateCardList(state.numberDtos);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _generateCardList(List<NumberDto> mNumberDtos) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 8.0, top: 10, right: 8.0),
        itemCount: mNumberDtos.length,
        itemBuilder: (context, index) {
          return NumberCard(
            key: Key('${mNumberDtos[index].number}'),
            numberDto: mNumberDtos[index],
            onClick: _onNumberClicked,
          );
        },
      ),
    );
  }
}
