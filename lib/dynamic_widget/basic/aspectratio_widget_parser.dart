import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class AspectRatioWidgetParser extends WidgetParser {
  

  @override
  String get widgetName => "AspectRatio";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext, ClickEventListener listener, {GlobalKey<State<StatefulWidget>> stateKey}) {
    return AspectRatio(
      aspectRatio: map["aspectRatio"],
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener, stateKey: stateKey),
    );
  }
}
