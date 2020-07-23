import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderWidgetParser extends WidgetParser<FormBuilderState> {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickEventListener listener,
      {GlobalKey<FormBuilderState> stateKey}) {
    bool autoValidate = map['autoValidate'];
    Map<String, dynamic> childMap = map['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener,
            stateKey: stateKey);

    return FormBuilder(
      key: stateKey,
      autovalidate: autoValidate ?? true,
      child: child,
    );
  }

  @override
  String get widgetName => 'FormBuilder';
}
