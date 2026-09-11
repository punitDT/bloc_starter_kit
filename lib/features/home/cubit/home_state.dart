import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.selectedIndex = 0,
    this.items = const ['Overview', 'Activity', 'Profile'],
  });

  final int selectedIndex;
  final List<String> items;

  HomeState copyWith({int? selectedIndex, List<String>? items}) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [selectedIndex, items];
}
