
import 'package:flutter/material.dart';
import 'package:technical_test/common/utils/get_colors.dart';
import 'package:technical_test/services/home/dto/number_dto.dart';

class NumberCard extends StatefulWidget {
  const NumberCard({Key key, this.numberDto, this.onClick});

  final NumberDto numberDto;
  final Function(NumberDto numberDto) onClick;

  @override
  _NumberCardState createState() => _NumberCardState();
}

class _NumberCardState extends State<NumberCard> {
  Color textBackgroundColor;

  @override
  void initState() {
    super.initState();
    textBackgroundColor = widget.numberDto.isAlreadyClicked ? Colors.grey : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.numberDto.isPrime) {
          textBackgroundColor = Colors.grey;
          // setState(() {});
        }
        widget.onClick(widget.numberDto);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        width: double.infinity,
        height: 80,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: getTopColor(widget.numberDto.number, widget.numberDto.isPrime)),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(0),
                    // padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: getBottomColor(widget.numberDto.number, widget.numberDto.isPrime),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: textBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                widget.numberDto.number.toString(),
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
