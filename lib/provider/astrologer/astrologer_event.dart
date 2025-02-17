part of 'astrologer_bloc.dart';

@immutable
sealed class AstrologerEvent {}

/// Event to fetch astrologers based on the selected tab
final class FetchAstrologers extends AstrologerEvent {
  final String tab;

  FetchAstrologers(this.tab);
}

