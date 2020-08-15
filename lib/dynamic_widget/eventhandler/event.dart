class Event {
  final EventType eventType;
  final dynamic data;
  final Event onFinish;

  Event(this.eventType, {this.data, this.onFinish});

  static Event fromJson(Map<String, dynamic> json) {
    var eventType = _parseEventType(json['type']);
    var data = json.containsKey('data') ? json['data'] : null;
    var onFinish =
        json.containsKey('onFinish') ? Event.fromJson(json['onFinish']) : null;
    return Event(eventType, data: data, onFinish: onFinish);
  }
}

enum EventType { CLICK, NAVIGATE, CHANGE, NOT_DEFINED }

_parseEventType(String eventType) {
  if (eventType == null) return EventType.NOT_DEFINED;
  switch (eventType) {
    case "CLICK":
    case "click":
      return EventType.CLICK;
    case "CHANGE":
    case "change":
      return EventType.CHANGE;
      break;
    case "NAVIGATE":
    case "navigate":
      return EventType.NAVIGATE;
      break;
    default:
      return EventType.CLICK;
  }
}
