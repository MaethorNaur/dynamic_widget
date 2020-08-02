import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/eventhandler/event.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListTileWidgetParser extends WidgetParser {
  @override
  String get widgetName => "ListTile";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    bool isThreeLine =
        map.containsKey("isThreeLine") ? map["isThreeLine"] : false;
    EdgeInsetsGeometry contentPadding = map.containsKey("contentPadding")
        ? parseEdgeInsetsGeometry(map["contentPadding"])
        : null;
    bool dense = map.containsKey("dense") ? map["dense"] : false;
    bool enabled = map.containsKey("enabled") ? map["enabled"] : true;
    Widget leading = map.containsKey("leading")
        ? DynamicWidgetBuilder.buildFromMap(
            map["leading"], buildContext, listener,
            stateKey: stateKey)
        : null;
    bool selected = map.containsKey("selected") ? map["selected"] : false;
    Widget subtitle = map.containsKey("subtitle")
        ? DynamicWidgetBuilder.buildFromMap(
            map["subtitle"], buildContext, listener,
            stateKey: stateKey)
        : null;
    Widget title = map.containsKey("title")
        ? DynamicWidgetBuilder.buildFromMap(
            map["title"], buildContext, listener,
            stateKey: stateKey)
        : null;
    Widget trailing = map.containsKey("trailing")
        ? DynamicWidgetBuilder.buildFromMap(
            map["trailing"], buildContext, listener,
            stateKey: stateKey)
        : null;

    Event clickEvent = map.containsKey("clickEvent")
        ? Event.fromJson(map['clickEvent'])
        : Event(EventType.NOT_DEFINED);

    return ListTile(
      isThreeLine: isThreeLine,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      dense: dense,
      contentPadding: contentPadding,
      enabled: enabled,
      onTap: () {
        if (listener != null && clickEvent != null) {
          listener.onTriggered(clickEvent);
        }
      },
      selected: selected,
    );
  }
}
