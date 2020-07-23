import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlignWidgetParser extends WidgetParser {
  @override
  String get widgetName => "Align";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    return Align(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])
          : Alignment.center,
      widthFactor: map.containsKey("widthFactor") ? map["widthFactor"] : null,
      heightFactor:
          map.containsKey("heightFactor") ? map["heightFactor"] : null,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener, stateKey: stateKey),
    );
  }
}
