import 'dart:async';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is AddScreenShot) {
      final List<Uint8List> updatedScreenshots = List.from(state.screenshots)..add(event.image);
      yield state.copyWith(screenshots: updatedScreenshots);
    }
  }
}
