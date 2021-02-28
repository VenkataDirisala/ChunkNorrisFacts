import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:technical_test/bloc/details/chucknorris_bloc.dart';
import 'package:technical_test/bloc/details/chucknorris_events.dart';
import 'package:technical_test/bloc/details/chucknorris_states.dart';
import 'package:technical_test/services/details/dto/chuck_norris_dto.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ChucknorrisBloc>(context)
        .add(RandomChucknorrisFetchEvent(id: DateTime.now().millisecondsSinceEpoch));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facts'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.grey.shade200,
          ),
          child: BlocBuilder<ChucknorrisBloc, ChucknorrisStates>(
            builder: (context, ChucknorrisStates state) {
              if (state is ChucknorrisErrorState) {
                return const Center(
                  child: Text(
                    'Failed to fetch random fact',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              if (state is ChucknorrisLoadedState) {
                return _mainBodyWidget(state.chucknorrisDto);
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _mainBodyWidget(ChucknorrisDto chucknorrisDto) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                          // shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(chucknorrisDto.iconUrl),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Fact #${chucknorrisDto.order}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Created Time: ${_formatDDMMMYYYY(chucknorrisDto.createdTime)}',
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Updated Time: ${_formatDDMMMYYYY(chucknorrisDto.updatedTime)}',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            chucknorrisDto.description,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () async {
                    if (await canLaunch(chucknorrisDto.url)) await launch(chucknorrisDto.url);
                  },
                  color: Colors.white,
                  child: Text(
                    'Go To Website',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDDMMMYYYY(DateTime mDate) {
    return '${mDate.day} ${DateFormat.MMMM().format(mDate)}, ${mDate.year}';
  }
}


