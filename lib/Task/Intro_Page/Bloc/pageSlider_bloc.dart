import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/Task/Intro_Page/Bloc/pageslider_event.dart';
import 'package:pro2/Task/Intro_Page/Bloc/pageSlider_state.dart';

class PageSliderBloc extends Bloc<PageSliderEvent, PageSliderState> {
  final int totalIndex;

  PageSliderBloc({required this.totalIndex}) : super(PageSliderState(0)) {
    on<PageChangedEvent>(pageChange);

    on<NextPageEvent>((event, emit) {
      final nextPage = state.currentPage + 1;
      emit(PageSliderState(nextPage));
    });

    on<PrevPageEvent>((event, emit) {
      final prevPage = state.currentPage - 1;
      emit(PageSliderState(prevPage));
    });
  }

  FutureOr<void> pageChange(
    PageChangedEvent event,
    Emitter<PageSliderState> emit,
  ) {
    print(event.index);
    emit(PageSliderState(event.index));
  }
}