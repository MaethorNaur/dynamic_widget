import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

//Creates a box that will become as large as its parent allows.
class ExpandedSizedBoxWidgetParser extends WidgetParser {
  @override
  String get widgetName => "ExpandedSizedBox";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    return SizedBox.expand(
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener,
          stateKey: stateKey),
    );
  }
}

class SizedBoxWidgetParser extends WidgetParser {
  @override
  String get widgetName => "SizedBox";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    return SizedBox(
      width: map["width"],
      height: map["height"],
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener,
          stateKey: stateKey),
    );
  }
}
