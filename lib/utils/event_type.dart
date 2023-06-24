enum EventType { tourist, extravert, nurd, politic }

EventType getEventTypeFromString(String typeString) {
  switch (typeString) {
    case 'extravert':
      return EventType.extravert;
    case 'politic':
      return EventType.politic;
    case 'tourist':
      return EventType.tourist;
    case 'nurd':
      return EventType.nurd;
    default:
      return EventType.tourist;
  }
}
