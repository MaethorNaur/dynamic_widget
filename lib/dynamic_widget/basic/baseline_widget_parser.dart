import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';

class BaselineWidgetParser extends WidgetParser {
  @override
  String get widgetName => "Baseline";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickEventListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    return Baseline(
      baseline: map["baseline"],
      baselineType: map["baselineType"] == "alphabetic"
          ? TextBaseline.alphabetic
          : TextBaseline.ideographic,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener, stateKey: stateKey),
    );
  }
}
