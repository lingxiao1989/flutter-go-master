import 'package:event_bus/event_bus.dart';

/// The global [EventBus] object.
EventBus eventBus = EventBus();
class ApplicationEvent{
  static EventBus event;
  bool popSheetEvent;
  ApplicationEvent(this.popSheetEvent);
}