class ClickEvent {
  final EventType eventType;
  final String uri;

  ClickEvent(this.eventType, this.uri);

  static ClickEvent fromJson(Map<String, dynamic> json) {
    var eventType = getEventTypeFromString(json['eventType']);
    var uri = json['uri'];
    return ClickEvent(eventType, uri);
  }
}

enum EventType { GET, POST, VALIDATE, VALIDATE_AND_SAVE, NAVIGATE, NOT_DEFINED }

EventType getEventTypeFromString(String eventType) {
  return EventType.values.firstWhere((e) => e.toString() == eventType);
}
