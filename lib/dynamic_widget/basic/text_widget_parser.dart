import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/eventhandler/event.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class TextWidgetParser implements WidgetParser {
  @override
  String get widgetName => "Text";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {GlobalKey<State<StatefulWidget>> stateKey}) {
    String data = map['data'];
    String textAlignString = map['textAlign'];
    String overflow = map['overflow'];
    int maxLines = map['maxLines'];
    String semanticsLabel = map['semanticsLabel'];
    bool softWrap = map['softWrap'];
    String textDirectionString = map['textDirection'];
    double textScaleFactor = map['textScaleFactor'];
    var textSpan;
    var textSpanParser = TextSpanParser();
    if (map.containsKey("textSpan")) {
      textSpan = textSpanParser.parse(map['textSpan'], listener);
    }

    if (textSpan == null) {
      return Text(
        data,
        textAlign: parseTextAlign(textAlignString),
        overflow: parseTextOverflow(overflow),
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        softWrap: softWrap,
        textDirection: parseTextDirection(textDirectionString),
        style: map.containsKey('style') ? parseTextStyle(map['style']) : null,
        textScaleFactor: textScaleFactor,
      );
    } else {
      return Text.rich(
        textSpan,
        textAlign: parseTextAlign(textAlignString),
        overflow: parseTextOverflow(overflow),
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        softWrap: softWrap,
        textDirection: parseTextDirection(textDirectionString),
        style: map.containsKey('style') ? parseTextStyle(map['style']) : null,
        textScaleFactor: textScaleFactor,
      );
    }
  }
}

class TextSpanParser {
  TextSpan parse(Map<String, dynamic> map, EventListener listener) {
    Event clickEvent = map.containsKey("clickEvent")
        ? Event.fromJson(map['clickEvent'])
        : Event(EventType.NOT_DEFINED);
    var textSpan = TextSpan(
        text: map['text'],
        style: parseTextStyle(map['style']),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            listener.onTriggered(clickEvent);
          },
        children: []);

    if (map.containsKey('children')) {
      parseChildren(textSpan, map['children'], listener);
    }

    return textSpan;
  }

  void parseChildren(TextSpan textSpan, List<dynamic> childrenSpan,
      EventListener listener) {
    for (var childmap in childrenSpan) {
      textSpan.children.add(parse(childmap, listener));
    }
  }
}
