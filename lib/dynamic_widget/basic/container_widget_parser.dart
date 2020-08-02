import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/eventhandler/event.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class ContainerWidgetParser extends WidgetParser {
  @override
  String get widgetName => "Container";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    Alignment alignment = parseAlignment(map['alignment']);
    Color color = parseHexColor(map['color']);
    BoxConstraints constraints = parseBoxConstraints(map['constraints']);
    EdgeInsetsGeometry margin = parseEdgeInsetsGeometry(map['margin']);
    EdgeInsetsGeometry padding = parseEdgeInsetsGeometry(map['padding']);

    BoxDecoration decoration =
        parseBoxDecoration(map['decoration'], buildContext);
    BoxDecoration foregroundDecoration =
        parseBoxDecoration(map['foregroundDecoration'], buildContext);

    Map<String, dynamic> childMap = map['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener,
            stateKey: stateKey);

    Event clickEvent = map.containsKey("clickEvent")
        ? Event.fromJson(map['clickEvent'])
        : Event(EventType.NOT_DEFINED);

    var containerWidget = Container(
      alignment: alignment,
      padding: padding,
      color: color,
      margin: margin,
      width: map.containsKey('dynamicWidth')
          ? MediaQuery.of(buildContext).size.width * map['dynamicWidth']
          : map['width'],
      height: map.containsKey('dynamicHeight')
          ? MediaQuery.of(buildContext).size.height * map['dynamicHeight']
          : map['height'],
      constraints: constraints,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      child: child,
    );

    if (listener != null && clickEvent != null) {
      return GestureDetector(
        onTap: () {
          listener.onTriggered(clickEvent);
        },
        child: containerWidget,
      );
    } else {
      return containerWidget;
    }
  }
}
