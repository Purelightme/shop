import 'package:flutter/material.dart';
import 'package:flutter_drag_scale/core/drag_scale_widget.dart';
import 'package:shop/common/save_image.dart';

class ImagePreview extends StatefulWidget {

  ImagePreview({@required this.images,@required this.index});

  List<String> images;
  int index;

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    PageController _pageController = new PageController(initialPage: widget.index);

    return Scaffold(
        body: Center(
          child: Container(
            child: PageView(
              controller: _pageController,
              pageSnapping:false,
              children: widget.images.map((url){
                return GestureDetector(
                  child: DragScaleContainer(
                    doubleTapStillScale: true,
                    child: Image.network(url),
                  ),
                  onLongPress: () {
                    saveNetworkImage(context, url);
                  },
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        )
    );
  }
}

