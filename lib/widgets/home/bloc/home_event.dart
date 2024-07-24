part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AddScreenShot extends HomeEvent {
  final Uint8List image;
  const AddScreenShot({required this.image});
  @override
  List<Object> get props => [image];
}