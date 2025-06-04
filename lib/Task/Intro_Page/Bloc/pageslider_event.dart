abstract class PageSliderEvent {}

class PageChangedEvent extends PageSliderEvent {
  final int index;
  PageChangedEvent(this.index);
}

class NextPageEvent extends PageSliderEvent {}

class PrevPageEvent extends PageSliderEvent {}