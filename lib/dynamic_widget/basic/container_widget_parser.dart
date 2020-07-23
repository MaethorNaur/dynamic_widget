import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class ContainerWidgetParser extends WidgetParser {
  @override
  String get widgetName => "Container";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    Alignment alignment = parseAlignment(map['alignment']);
    Color color = parseHexColor(map['color']);
    BoxConstraints constraints = parseBoxConstraints(map['constraints']);
    //TODO: decoration, foregroundDecoration and transform properties to be implemented.
    EdgeInsetsGeometry margin = parseEdgeInsetsGeometry(map['margin']);
    EdgeInsetsGeometry padding = parseEdgeInsetsGeometry(map['padding']);
    Map<String, dynamic> childMap = map['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener,
            stateKey: stateKey);

    String clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    var containerWidget = Container(
      alignment: alignment,
      padding: padding,
      color: color,
      margin: margin,
      width: map['width'],
      height: map['height'],
      constraints: constraints,
      child: child,
    );

    if (listener != null && clickEvent != null) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: containerWidget,
      );
    } else {
      return containerWidget;
    }
  }
}
