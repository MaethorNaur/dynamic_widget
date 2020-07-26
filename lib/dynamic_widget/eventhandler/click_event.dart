class ClickEvent {
  final EventType eventType;
  final String uri;
  final ClickEvent onFinish;

  ClickEvent(this.eventType, {this.uri, this.onFinish});

  static ClickEvent fromJson(Map<String, dynamic> json) {
    var eventType = _parseEventType(json['eventType']);
    var uri = json.containsKey('uri') ? json['uri'] : null;
    var onFinish = json.containsKey('onFinish')
        ? ClickEvent.fromJson(json['onFinish'])
        : null;
    return ClickEvent(eventType, uri: uri, onFinish: onFinish);
  }
}

enum EventType { NAVIGATE, VALIDATE, NOT_DEFINED }

_parseEventType(String eventType) {
  switch (eventType) {
    case "VALIDATE":
    case "validate":
      return EventType.VALIDATE;
      break;
    case "NAVIGATE":
    case "navigate":
      return EventType.NAVIGATE;
      break;
    default:
      return EventType.VALIDATE;
  }
}
