class ClickEvent {
  final EventType eventType;
  final String uri;
  final ClickEvent onFinish;

  ClickEvent(this.eventType, {this.uri, this.onFinish});

  static ClickEvent fromJson(Map<String, dynamic> json) {
    var eventType = getEventTypeFromString(json['eventType']);
    var uri = json['uri'];
    var onFinish = json.containsKey('onFinish')
        ? ClickEvent.fromJson(json['onFinish'])
        : null;
    return ClickEvent(eventType, uri: uri, onFinish: onFinish);
  }
}

enum EventType { NAVIGATE, NOT_DEFINED }

EventType getEventTypeFromString(String eventType) {
  return EventType.values.firstWhere((e) => e.toString() == eventType);
}
