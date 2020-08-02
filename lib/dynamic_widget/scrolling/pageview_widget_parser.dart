import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class PageViewWidgetParser extends WidgetParser {
  @override
  String get widgetName => "PageView";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    var scrollDirection = Axis.vertical;
    if (map.containsKey("scrollDirection") &&
        "horizontal" == map["scrollDirection"]) {
      scrollDirection = Axis.horizontal;
    }
    return PageView(
      scrollDirection: scrollDirection,
      reverse: map.containsKey("reverse") ? map["reverse"] : false,
      pageSnapping:
          map.containsKey("pageSnapping") ? map["pageSnapping"] : true,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener,
          stateKey: stateKey),
    );
  }
}
