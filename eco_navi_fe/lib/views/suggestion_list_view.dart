import 'package:eco_navi_fe/models/place.dart';
import 'package:eco_navi_fe/services/econavi_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuggestionListView extends StatefulWidget {
  const SuggestionListView({
    super.key,
    required this.place,
    required this.height,
    required this.width,
    required this.heightRatio,
    required this.name,
    required this.imageSrc,
    required this.date,
    required this.adrr,
    required this.content,
  });

  final double height;
  final double width;
  final double heightRatio;
  final String name;
  final String imageSrc;
  final String date;
  final String adrr;
  final String content;

  final Place place;

  @override
  State<SuggestionListView> createState() => _SuggestionListViewState();
}

class _SuggestionListViewState extends State<SuggestionListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border(bottom: BorderSide(color: Color(0xFF737373), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(10 * widget.heightRatio),
              decoration: BoxDecoration(
                color: Color(0xFFB9B9B9),
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50 * widget.heightRatio,
              width: 50 * widget.heightRatio,
              //child: Image.network(widget.imageSrc),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(
              0,
              5 * widget.heightRatio,
              0,
              5 * widget.heightRatio,
            ),
            width: 250 * widget.heightRatio,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 14 * widget.heightRatio,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Text(
                  "날짜: ${widget.date}",
                  style: TextStyle(
                    fontSize: 10 * widget.heightRatio,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "주소:${widget.adrr}",
                  style: TextStyle(
                    fontSize: 10 * widget.heightRatio,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          Flexible(
            flex: 1,
            child: Container(
              height: 50 * widget.heightRatio,
              width: 50 * widget.heightRatio,
              alignment: Alignment.center,
              margin: EdgeInsets.all(10 * widget.heightRatio),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if (await BookMarkApiService.isBookMarked(
                        widget.place.id,
                      )) {
                        await BookMarkApiService.deleteBookMark(
                          widget.place.id,
                        );
                      } else {
                        await BookMarkApiService.addBookMark(widget.place.id);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 24 * widget.heightRatio,
                      width: 24 * widget.heightRatio,
                      child: SvgPicture.asset('svg/favourite.svg'),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 24 * widget.heightRatio,
                      width: 24 * widget.heightRatio,
                      child: SvgPicture.asset('svg/dot-vertical.svg'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
