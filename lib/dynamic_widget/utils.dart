import 'dart:ui';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

TextAlign parseTextAlign(String textAlignString) {
  //left the system decide
  TextAlign textAlign = TextAlign.start;
  switch (textAlignString) {
    case "left":
      textAlign = TextAlign.left;
      break;
    case "right":
      textAlign = TextAlign.right;
      break;
    case "center":
      textAlign = TextAlign.center;
      break;
    case "justify":
      textAlign = TextAlign.justify;
      break;
    case "start":
      textAlign = TextAlign.start;
      break;
    case "end":
      textAlign = TextAlign.end;
      break;
    default:
      textAlign = TextAlign.start;
  }
  return textAlign;
}

TextOverflow parseTextOverflow(String textOverflowString) {
  TextOverflow textOverflow = TextOverflow.ellipsis;
  switch (textOverflowString) {
    case "ellipsis":
      textOverflow = TextOverflow.ellipsis;
      break;
    case "clip":
      textOverflow = TextOverflow.clip;
      break;
    case "fade":
      textOverflow = TextOverflow.fade;
      break;
    default:
      textOverflow = TextOverflow.fade;
  }
  return textOverflow;
}

TextDecoration parseTextDecoration(String textDecorationString) {
  TextDecoration textDecoration = TextDecoration.none;
  switch (textDecorationString) {
    case "lineThrough":
      textDecoration = TextDecoration.lineThrough;
      break;
    case "overline":
      textDecoration = TextDecoration.overline;
      break;
    case "underline":
      textDecoration = TextDecoration.underline;
      break;
    case "none":
    default:
      textDecoration = TextDecoration.none;
  }
  return textDecoration;
}

TextDirection parseTextDirection(String textDirectionString) {
  TextDirection textDirection = TextDirection.ltr;
  switch (textDirectionString) {
    case 'ltr':
      textDirection = TextDirection.ltr;
      break;
    case 'rtl':
      textDirection = TextDirection.rtl;
      break;
    default:
      textDirection = TextDirection.ltr;
  }
  return textDirection;
}

FontWeight parseFontWeight(String textFontWeight) {
  FontWeight fontWeight = FontWeight.normal;
  switch (textFontWeight) {
    case 'w100':
      fontWeight = FontWeight.w100;
      break;
    case 'w200':
      fontWeight = FontWeight.w200;
      break;
    case 'w300':
      fontWeight = FontWeight.w300;
      break;
    case 'normal':
    case 'w400':
      fontWeight = FontWeight.w400;
      break;
    case 'w500':
      fontWeight = FontWeight.w500;
      break;
    case 'w600':
      fontWeight = FontWeight.w600;
      break;
    case 'bold':
    case 'w700':
      fontWeight = FontWeight.w700;
      break;
    case 'w800':
      fontWeight = FontWeight.w800;
      break;
    case 'w900':
      fontWeight = FontWeight.w900;
      break;
    default:
      fontWeight = FontWeight.normal;
  }
  return fontWeight;
}

Color parseHexColor(String hexColorString) {
  if (hexColorString == null) {
    return null;
  }
  hexColorString = hexColorString.toUpperCase().replaceAll("#", "");
  if (hexColorString.length == 6) {
    hexColorString = "FF" + hexColorString;
  }
  int colorInt = int.parse(hexColorString, radix: 16);
  return Color(colorInt);
}

TextStyle parseTextStyle(Map<String, dynamic> map) {
  //TODO: more properties need to be implemented, such as decorationColor, decorationStyle, wordSpacing and so on.
  String color = map['color'];
  String debugLabel = map['debugLabel'];
  String decoration = map['decoration'];
  String fontFamily = map['fontFamily'];
  double fontSize = map['fontSize'];
  String fontWeight = map['fontWeight'];
  FontStyle fontStyle =
      'italic' == map['fontStyle'] ? FontStyle.italic : FontStyle.normal;

  return TextStyle(
    color: parseHexColor(color),
    debugLabel: debugLabel,
    decoration: parseTextDecoration(decoration),
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontStyle: fontStyle,
    fontWeight: parseFontWeight(fontWeight),
  );
}

Alignment parseAlignment(String alignmentString) {
  Alignment alignment = Alignment.topLeft;
  switch (alignmentString) {
    case 'topLeft':
      alignment = Alignment.topLeft;
      break;
    case 'topCenter':
      alignment = Alignment.topCenter;
      break;
    case 'topRight':
      alignment = Alignment.topRight;
      break;
    case 'centerLeft':
      alignment = Alignment.centerLeft;
      break;
    case 'center':
      alignment = Alignment.center;
      break;
    case 'centerRight':
      alignment = Alignment.centerRight;
      break;
    case 'bottomLeft':
      alignment = Alignment.bottomLeft;
      break;
    case 'bottomCenter':
      alignment = Alignment.bottomCenter;
      break;
    case 'bottomRight':
      alignment = Alignment.bottomRight;
      break;
  }
  return alignment;
}

const double infinity = 9999999999;

BoxConstraints parseBoxConstraints(Map<String, dynamic> map) {
  double minWidth = 0.0;
  double maxWidth = double.infinity;
  double minHeight = 0.0;
  double maxHeight = double.infinity;

  if (map != null) {
    if (map.containsKey('minWidth')) {
      var minWidthValue = map['minWidth'];

      if (minWidthValue != null) {
        if (minWidthValue >= infinity) {
          minWidth = double.infinity;
        } else {
          minWidth = minWidthValue;
        }
      }
    }

    if (map.containsKey('maxWidth')) {
      var maxWidthValue = map['maxWidth'];

      if (maxWidthValue != null) {
        if (maxWidthValue >= infinity) {
          maxWidth = double.infinity;
        } else {
          maxWidth = maxWidthValue;
        }
      }
    }

    if (map.containsKey('minHeight')) {
      var minHeightValue = map['minHeight'];

      if (minHeightValue != null) {
        if (minHeightValue >= infinity) {
          minHeight = double.infinity;
        } else {
          minHeight = minHeightValue;
        }
      }
    }

    if (map.containsKey('maxHeight')) {
      var maxHeightValue = map['maxHeight'];

      if (maxHeightValue != null) {
        if (maxHeightValue >= infinity) {
          maxHeight = double.infinity;
        } else {
          maxHeight = maxHeightValue;
        }
      }
    }
  }

  return BoxConstraints(
    minWidth: minWidth,
    maxWidth: maxWidth,
    minHeight: minHeight,
    maxHeight: maxHeight,
  );
}

BoxDecoration parseBoxDecoration(
    Map<String, dynamic> map, BuildContext buildContext) {
  if (map == null) return null;

  Color color = parseHexColor(map['color']);

  Map<String, dynamic> mapOfImage =
      map.containsKey('image') ? map['image'] : null;
  DecorationImage image = parseDecorationImage(mapOfImage);

  Map<String, dynamic> mapOfBorder =
      map.containsKey('border') ? map['border'] : null;

  Border border = parseBoxBorder(mapOfBorder);
  BorderRadius borderRadius = parseBorderRadius(map['borderRadius']);
  BoxShape shape = parseBoxShape(map['shape']);

  Map<String, dynamic> mapOfBoxShadow =
      map.containsKey('boxShadow') ? map['boxShadow'] : null;
  BoxShadow boxShadow = parseBoxShadow(mapOfBoxShadow);

  return BoxDecoration(
    color: color,
    image: image,
    border: border,
    borderRadius: borderRadius,
    boxShadow: boxShadow != null ? [boxShadow] : [],
    shape: shape ?? BoxShape.rectangle,
  );
}

BoxShadow parseBoxShadow(Map<String, dynamic> mapOfBoxShadow) {
  if (mapOfBoxShadow == null) {
    return null;
  }

  Color color = parseHexColor(mapOfBoxShadow['color']);
  double spreadRadius = mapOfBoxShadow['spreadRadius'];
  double blurRadius = mapOfBoxShadow['blurRadius'];
  Offset offset = parseOffset(mapOfBoxShadow['offset']);

  return BoxShadow(
    color: color,
    spreadRadius: spreadRadius ?? 0.0,
    blurRadius: blurRadius ?? 0.0,
    offset: offset ?? Offset(0, 0),
  );
}

Offset parseOffset(String offsetString) {
  if (offsetString == null || offsetString == '') {
    return null;
  }

  var values = offsetString.split(',');
  return Offset(double.parse(values[0]), double.parse(values[1]));
}

BoxShape parseBoxShape(String boxShapeString) {
  if (boxShapeString == null) {
    return null;
  }

  switch (boxShapeString) {
    case 'circle':
      return BoxShape.circle;
    case 'rectangle':
      return BoxShape.rectangle;
  }

  return null;
}

BorderRadius parseBorderRadius(String borderRadiusString) {
  if (borderRadiusString == null || borderRadiusString == '') {
    return null;
  }

  var values = borderRadiusString.split(",");
  return BorderRadius.only(
      topLeft: Radius.circular(double.parse(values[0])),
      topRight: Radius.circular(double.parse(values[1])),
      bottomLeft: Radius.circular(double.parse(values[2])),
      bottomRight: Radius.circular(double.parse(values[3])));
}

BoxBorder parseBoxBorder(Map<String, dynamic> mapOfBorder) {
  if (mapOfBorder != null) {
    Color color = parseHexColor(mapOfBorder['color']);
    double width = mapOfBorder['width'];
    return Border.all(color: color, width: width);
  }
  return null;
}

DecorationImage parseDecorationImage(Map<String, dynamic> mapOfImage) {
  if (mapOfImage != null) {
    return DecorationImage(
      image: NetworkImage(mapOfImage['url']),
      fit: parseBoxFit(mapOfImage['fit']),
    );
  }
  return null;
}

EdgeInsetsGeometry parseEdgeInsetsGeometry(String edgeInsetsGeometryString) {
  //left,top,right,bottom
  if (edgeInsetsGeometryString == null ||
      edgeInsetsGeometryString.trim() == '') {
    return null;
  }
  var values = edgeInsetsGeometryString.split(",");
  return EdgeInsets.only(
      left: double.parse(values[0]),
      top: double.parse(values[1]),
      right: double.parse(values[2]),
      bottom: double.parse(values[3]));
}

CrossAxisAlignment parseCrossAxisAlignment(String crossAxisAlignmentString) {
  switch (crossAxisAlignmentString) {
    case 'start':
      return CrossAxisAlignment.start;
    case 'end':
      return CrossAxisAlignment.end;
    case 'center':
      return CrossAxisAlignment.center;
    case 'stretch':
      return CrossAxisAlignment.stretch;
    case 'baseline':
      return CrossAxisAlignment.baseline;
  }
  return CrossAxisAlignment.center;
}

MainAxisAlignment parseMainAxisAlignment(String mainAxisAlignmentString) {
  switch (mainAxisAlignmentString) {
    case 'start':
      return MainAxisAlignment.start;
    case 'end':
      return MainAxisAlignment.end;
    case 'center':
      return MainAxisAlignment.center;
    case 'spaceBetween':
      return MainAxisAlignment.spaceBetween;
    case 'spaceAround':
      return MainAxisAlignment.spaceAround;
    case 'spaceEvenly':
      return MainAxisAlignment.spaceEvenly;
  }
  return MainAxisAlignment.start;
}

MainAxisSize parseMainAxisSize(String mainAxisSizeString) =>
    mainAxisSizeString == 'min' ? MainAxisSize.min : MainAxisSize.max;

TextBaseline parseTextBaseline(String parseTextBaselineString) =>
    'alphabetic' == parseTextBaselineString
        ? TextBaseline.alphabetic
        : TextBaseline.ideographic;

VerticalDirection parseVerticalDirection(String verticalDirectionString) =>
    'up' == verticalDirectionString
        ? VerticalDirection.up
        : VerticalDirection.down;

BlendMode parseBlendMode(String blendModeString) {
  if (blendModeString == null || blendModeString.trim().length == 0) {
    return null;
  }

  switch (blendModeString.trim()) {
    case 'clear':
      return BlendMode.clear;
    case 'src':
      return BlendMode.src;
    case 'dst':
      return BlendMode.dst;
    case 'srcOver':
      return BlendMode.srcOver;
    case 'dstOver':
      return BlendMode.dstOver;
    case 'srcIn':
      return BlendMode.srcIn;
    case 'dstIn':
      return BlendMode.dstIn;
    case 'srcOut':
      return BlendMode.srcOut;
    case 'dstOut':
      return BlendMode.dstOut;
    case 'srcATop':
      return BlendMode.srcATop;
    case 'dstATop':
      return BlendMode.dstATop;
    case 'xor':
      return BlendMode.xor;
    case 'plus':
      return BlendMode.plus;
    case 'modulate':
      return BlendMode.modulate;
    case 'screen':
      return BlendMode.screen;
    case 'overlay':
      return BlendMode.overlay;
    case 'darken':
      return BlendMode.darken;
    case 'lighten':
      return BlendMode.lighten;
    case 'colorDodge':
      return BlendMode.colorDodge;
    case 'colorBurn':
      return BlendMode.colorBurn;
    case 'hardLight':
      return BlendMode.hardLight;
    case 'softLight':
      return BlendMode.softLight;
    case 'difference':
      return BlendMode.difference;
    case 'exclusion':
      return BlendMode.exclusion;
    case 'multiply':
      return BlendMode.multiply;
    case 'hue':
      return BlendMode.hue;
    case 'saturation':
      return BlendMode.saturation;
    case 'color':
      return BlendMode.color;
    case 'luminosity':
      return BlendMode.luminosity;

    default:
      return BlendMode.srcIn;
  }
}

BoxFit parseBoxFit(String boxFitString) {
  if (boxFitString == null) {
    return null;
  }

  switch (boxFitString) {
    case 'fill':
      return BoxFit.fill;
    case 'contain':
      return BoxFit.contain;
    case 'cover':
      return BoxFit.cover;
    case 'fitWidth':
      return BoxFit.fitWidth;
    case 'fitHeight':
      return BoxFit.fitHeight;
    case 'none':
      return BoxFit.none;
    case 'scaleDown':
      return BoxFit.scaleDown;
  }

  return null;
}

ImageRepeat parseImageRepeat(String imageRepeatString) {
  if (imageRepeatString == null) {
    return null;
  }

  switch (imageRepeatString) {
    case 'repeat':
      return ImageRepeat.repeat;
    case 'repeatX':
      return ImageRepeat.repeatX;
    case 'repeatY':
      return ImageRepeat.repeatY;
    case 'noRepeat':
      return ImageRepeat.noRepeat;

    default:
      return ImageRepeat.noRepeat;
  }
}

Rect parseRect(String fromLTRBString) {
  var strings = fromLTRBString.split(',');
  return Rect.fromLTRB(double.parse(strings[0]), double.parse(strings[1]),
      double.parse(strings[2]), double.parse(strings[3]));
}

FilterQuality parseFilterQuality(String filterQualityString) {
  if (filterQualityString == null) {
    return null;
  }
  switch (filterQualityString) {
    case 'none':
      return FilterQuality.none;
    case 'low':
      return FilterQuality.low;
    case 'medium':
      return FilterQuality.medium;
    case 'high':
      return FilterQuality.high;
    default:
      return FilterQuality.low;
  }
}

StackFit parseStackFit(String value) {
  if (value == null) return null;

  switch (value) {
    case 'loose':
      return StackFit.loose;
    case 'expand':
      return StackFit.expand;
    case 'passthrough':
      return StackFit.passthrough;
    default:
      return StackFit.loose;
  }
}

Overflow parseOverflow(String value) {
  if (value == null) {
    return null;
  }

  switch (value) {
    case 'visible':
      return Overflow.visible;
    case 'clip':
      return Overflow.clip;
    default:
      return Overflow.clip;
  }
}

Axis parseAxis(String axisString) {
  if (axisString == null) {
    return Axis.horizontal;
  }

  switch (axisString) {
    case "horizontal":
      return Axis.horizontal;
    case "vertical":
      return Axis.vertical;
  }
  return Axis.horizontal;
}

//WrapAlignment
WrapAlignment parseWrapAlignment(String wrapAlignmentString) {
  if (wrapAlignmentString == null) {
    return WrapAlignment.start;
  }

  switch (wrapAlignmentString) {
    case "start":
      return WrapAlignment.start;
    case "end":
      return WrapAlignment.end;
    case "center":
      return WrapAlignment.center;
    case "spaceBetween":
      return WrapAlignment.spaceBetween;
    case "spaceAround":
      return WrapAlignment.spaceAround;
    case "spaceEvenly":
      return WrapAlignment.spaceEvenly;
  }
  return WrapAlignment.start;
}

//WrapCrossAlignment
WrapCrossAlignment parseWrapCrossAlignment(String wrapCrossAlignmentString) {
  if (wrapCrossAlignmentString == null) {
    return WrapCrossAlignment.start;
  }

  switch (wrapCrossAlignmentString) {
    case "start":
      return WrapCrossAlignment.start;
    case "end":
      return WrapCrossAlignment.end;
    case "center":
      return WrapCrossAlignment.center;
  }

  return WrapCrossAlignment.start;
}

Clip parseClipBehavior(String clipBehaviorString) {
  if (clipBehaviorString == null) {
    return Clip.antiAlias;
  }
  switch (clipBehaviorString) {
    case "antiAlias":
      return Clip.antiAlias;
    case "none":
      return Clip.none;
    case "hardEdge":
      return Clip.hardEdge;
    case "antiAliasWithSaveLayer":
      return Clip.antiAliasWithSaveLayer;
  }
  return Clip.antiAlias;
}

DropCapMode parseDropCapMode(String value) {
  if (value == null) {
    return null;
  }

  switch (value) {
    case 'inside':
      return DropCapMode.inside;
    case 'upwards':
      return DropCapMode.upwards;
    case 'aside':
      return DropCapMode.aside;
    default:
      return DropCapMode.inside;
  }
}

DropCapPosition parseDropCapPosition(String value) {
  if (value == null) {
    return null;
  }

  switch (value) {
    case 'start':
      return DropCapPosition.start;
    case 'end':
      return DropCapPosition.end;
    default:
      return DropCapPosition.start;
  }
}

DropCap parseDropCap(Map<String, dynamic> map, BuildContext buildContext,
    EventListener listener) {
  return DropCap(
    width: map['width'],
    height: map['height'],
    child:
        DynamicWidgetBuilder.buildFromMap(map["child"], buildContext, listener),
  );
}
