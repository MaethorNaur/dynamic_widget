import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class ClipRRectWidgetParser extends WidgetParser {
  @override
  String get widgetName => "ClipRRect";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    var radius = map['borderRadius'].toString().split(",");
    double topLeft = double.parse(radius[0]);
    double topRight = double.parse(radius[1]);
    double bottomLeft = double.parse(radius[2]);
    double bottomRight = double.parse(radius[3]);
    var clipBehaviorString = map['clipBehavior'];
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight)),
      clipBehavior: parseClipBehavior(clipBehaviorString),
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener,
          stateKey: stateKey),
    );
  }
}
