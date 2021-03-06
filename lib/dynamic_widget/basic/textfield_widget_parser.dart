import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dynamic_widget/dynamic_widget/eventhandler/event.dart';

class TextFieldWidgetParser extends WidgetParser {
  @override
  String get widgetName => 'TextField';

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    TextInputType keyboardType = map.containsKey('keyboardType')
        ? getKeyboardType(map['keyboardType'])
        : TextInputType.text;
    bool obscureText =
        map.containsKey('obscureText') ? map['obscureText'] as bool : false;
    int maxLines = map['maxLines'];

    TextInputAction textInputAction;
    if (map.containsKey('textInputAction')) {
      textInputAction = getTextInputAction(map['textInputAction']);
    }

    InputDecoration inputDecoration;
    if (map.containsKey('inputDecoration')) {
      inputDecoration = getInputDecoration(map['inputDecoration']);
    }

    return TextField(
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: inputDecoration ?? InputDecoration(labelText: null),
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      onChanged: (value) => listener.onTriggered(
        Event(
          EventType.CHANGE,
          data: {map['data']: value},
          onFinish: null,
        ),
      ),
      onSubmitted: _getOnFieldSubmitted(
        map['data'],
        listener: listener,
        buildContext: buildContext,
        textInputAction: textInputAction,
      ),
    );
  }

  _getOnFieldSubmitted(String field,
      {EventListener listener,
      BuildContext buildContext,
      TextInputAction textInputAction}) {
    switch (textInputAction) {
      case TextInputAction.next:
      case TextInputAction.continueAction:
        return (value) {
          listener.onTriggered(
            Event(
              EventType.CHANGE,
              data: {field: value},
              onFinish: null,
            ),
          );
          return FocusScope.of(buildContext).nextFocus();
        };

      case TextInputAction.previous:
        return (_) => FocusScope.of(buildContext).previousFocus();
      default:
        return (_) => FocusScope.of(buildContext).dispose();
    }
  }

  getInputDecoration(Map<String, dynamic> map) {
    if (map.containsKey("collapsed")) {
      return InputDecoration.collapsed(hintText: map["collapsed"]);
    } else {
      String labelText = map['labelText'];
      String prefixText = map['prefixText'];
      return InputDecoration(labelText: labelText, prefixText: prefixText);
    }
  }

  LengthLimitingTextInputFormatter getLengthLimitingTextInputFormatter(
      Map<String, dynamic> map) {
    if (map.containsKey('maxLength')) {
      int maxLength = map['maxLength'];
      return LengthLimitingTextInputFormatter(maxLength);
    }
    return null;
  }

  TextInputType getKeyboardType(String keyboardType) {
    switch (keyboardType) {
      case 'text':
        return TextInputType.text;
      case 'phone':
        return TextInputType.phone;
      case 'datetime':
        return TextInputType.datetime;
      case 'number':
        return TextInputType.number;
      case 'emailAddress':
        return TextInputType.emailAddress;
      case 'multiline':
        return TextInputType.multiline;
      case 'visiblePassword':
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }

  TextInputAction getTextInputAction(String textInputAction) {
    switch (textInputAction) {
      case 'next':
        return TextInputAction.next;
      case 'done':
        return TextInputAction.done;
      case 'go':
        return TextInputAction.go;
      case 'search':
        return TextInputAction.search;
      case 'send':
        return TextInputAction.send;
      case 'previous':
        return TextInputAction.previous;
      default:
        return TextInputAction.next;
    }
  }
}