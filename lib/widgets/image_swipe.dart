import 'package:flutter/material.dart';

class ImageSwiper extends StatefulWidget {
  final List imageList;

  const ImageSwiper({Key key, this.imageList}) : super(key: key);

  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  int selPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(children: [
        PageView(
          onPageChanged: (num) {
            setState(() {
              selPage = num;
            });
          },
          children: [
            for (var i = 0; i < widget.imageList.length; i++)
              Container(
                child: Image.network(
                  "${widget.imageList[i]}",
                  fit: BoxFit.cover,
                ),
              )
          ],
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.imageList.length; i++)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: selPage == i ? 35 : 12,
                  height: 12,
                )
            ],
          ),
        )
      ]),
    );
  }
}
