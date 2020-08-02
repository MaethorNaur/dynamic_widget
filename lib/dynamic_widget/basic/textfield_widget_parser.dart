import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextFieldWidgetParser extends WidgetParser {
  @override
  String get widgetName => 'TextField';

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    String attribute = map['attribute'];
    String initialValue = map['initialValue'];
    TextInputType keyboardType = map.containsKey('keyboardType')
        ? getKeyboardType(map['keyboardType'])
        : TextInputType.text;
    bool obscureText =
        map.containsKey('obscureText') ? map['obscureText'] as bool : false;
    int maxLines = map['maxLines'];

    var validators;
    if (map.containsKey('validators')) {
      validators = getValidators(map['validators']);
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

    return FormBuilderTextField(
      initialValue: initialValue ?? '',
      attribute: attribute ?? null,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: inputDecoration ?? InputDecoration(labelText: null),
      validators: validators ??
          [
            FormBuilderValidators.minLength(3),
            FormBuilderValidators.maxLength(100),
          ],
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      inputFormatters: [
        lengthLimitingTextInputFormatter,
      ],
      onFieldSubmitted: _getOnFieldSubmitted(buildContext, textInputAction),
    );
  }

  _getOnFieldSubmitted(
      BuildContext buildContext, TextInputAction textInputAction) {
    switch (textInputAction) {
      case TextInputAction.next:
      case TextInputAction.continueAction:
        return (_) => FocusScope.of(buildContext).nextFocus();
      case TextInputAction.previous:
        return (_) => FocusScope.of(buildContext).previousFocus();
      default:
        return (_) => FocusScope.of(buildContext).dispose();
    }
  }

  getInputDecoration(Map<String, dynamic> map) {
    String labelText = map['labelText'];
    String prefixText = map['prefixText'];
    return InputDecoration(labelText: labelText, prefixText: prefixText);
  }

  LengthLimitingTextInputFormatter getLengthLimitingTextInputFormatter(
      Map<String, dynamic> map) {
    if (map.containsKey('maxLength')) {
      int maxLength = map['maxLength'];
      return LengthLimitingTextInputFormatter(maxLength);
    }
    return null;
  }

  List<ValidatorType> getValidators(Map<String, dynamic> validatorMap) {
    var validators = List<ValidatorType>();
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
}

typedef String ValidatorType(dynamic);
