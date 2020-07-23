import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class IndexedStackWidgetParser extends WidgetParser {
  @override
  String get widgetName => "IndexedStack";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    return IndexedStack(
      index: map.containsKey("index") ? map["index"] : 0,
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])
          : AlignmentDirectional.topStart,
      textDirection: map.containsKey("textDirection")
          ? parseTextDirection(map["textDirection"])
          : null,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener,
          stateKey: stateKey),
    );
  }
}
