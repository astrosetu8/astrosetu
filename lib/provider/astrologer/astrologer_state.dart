part of 'astrologer_bloc.dart';

@immutable
sealed class AstrologerState {}

/// Initial state when no data is loaded
final class AstrologerInitial extends AstrologerState {}

/// State when data is being fetched
final class AstrologerLoading extends AstrologerState {}

/// State when data is successfully loaded
final class AstrologerLoaded extends AstrologerState {
  final AstrologerResponse astrologers;

  AstrologerLoaded(this.astrologers);
}

/// State when an error occurs while fetching data
final class AstrologerError extends AstrologerState {
  final String message;

  AstrologerError(this.message);
}


