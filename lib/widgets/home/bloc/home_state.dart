part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.screenshots = const [],
  });


  final List<Uint8List> screenshots;


  @override
  List<Object?> get props => [
    screenshots
  ];

  HomeState copyWith({
    List<Uint8List>? screenshots
  }) {
    return HomeState(
        screenshots: screenshots ?? this.screenshots
    );
  }
}