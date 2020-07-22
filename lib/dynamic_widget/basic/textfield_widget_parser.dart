import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../dynamic_widget.dart';

class TextFieldWidgetParser extends WidgetParser {
  @override
  Widget parse(
      Map<String, dynamic> map, BuildContext context, ClickListener listener) {
    String attribute = map['attribute'];
    TextInputType keyboardType = map.containsKey('keyboardType')
        ? getKeyboardType(map['keyboardType'])
        : TextInputType.text;
    bool obscureText = map['obscureText'];
    int maxLines = map['maxLines'];

    var validators;
    if (map.containsKey('validators')) {
      validators = getValidators(map[validators]);
    }

    TextInputAction textInputAction;
    if (map.containsKey('textInputAction')) {
      textInputAction = getTextInputAction(map['textInputAction']);
    }

    LengthLimitingTextInputFormatter lengthLimitingTextInputFormatter;
    if (map.containsKey('validators')) {
      lengthLimitingTextInputFormatter =
          getLengthLimitingTextInputFormatter(map['validators']);
    }

    InputDecoration inputDecoration;
    if (map.containsKey('inputDecoration')) {
      inputDecoration = getInputDecoration(map['inputDecoration']);
    }

    FormBuilderTextField formBuilderTextField = FormBuilderTextField(
      attribute: attribute,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: inputDecoration,
      validators: validators,
      obscureText: obscureText,
      maxLines: maxLines,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
    );

    return formBuilderTextField;
  }

  getInputDecoration(Map<String, dynamic> map) {
    String labelText = map['labelText'];
    return InputDecoration(labelText: labelText);
  }

  LengthLimitingTextInputFormatter getLengthLimitingTextInputFormatter(
      Map<String, dynamic> map) {
    if (map.containsKey('maxLength')) {
      int maxLength = map['maxLength'];
      return LengthLimitingTextInputFormatter(maxLength);
    }
    return null;
  }

  List getValidators(Map<String, dynamic> validatorMap) {
    var validators = List();
    if (validatorMap.containsKey('minLength')) {
      int minLength = validatorMap['minLength'];
      String errorText = validatorMap['minLengthErrorText'];
      validators.add(
          FormBuilderValidators.minLength(minLength, errorText: errorText));
    }
    if (validatorMap.containsKey('maxLength')) {
      int maxLength = validatorMap['maxLength'];
      String errorText = validatorMap['maxLengthErrorText'];
      validators.add(
          FormBuilderValidators.maxLength(maxLength, errorText: errorText));
    }
    if (validatorMap.containsKey('isEmail') && validatorMap['isEmail']) {
      String errorText = validatorMap['emailErrorText'];
      validators.add(FormBuilderValidators.email(errorText: errorText));
    }
    return validators;
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

  @override
  String get widgetName => 'TextField';
}