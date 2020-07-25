import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

//Creates a box that will become as large as its parent allows.
class ExpandedSizedBoxWidgetParser extends WidgetParser {
  @override
  String get widgetName => "ExpandedSizedBox";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickEventListener listener,
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
      ClickEventListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    Map<String, dynamic> childMap = map['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener,
            stateKey: stateKey);

    return SizedBox(
      width: map.containsKey('dynamicWidth')
          ? MediaQuery.of(buildContext).size.width * map['dynamicWidth']
          : map['width'],
      height: map.containsKey('dynamicHeight')
          ? MediaQuery.of(buildContext).size.height * map['dynamicHeight']
          : map['height'],
      child: child,
    );
  }
}
