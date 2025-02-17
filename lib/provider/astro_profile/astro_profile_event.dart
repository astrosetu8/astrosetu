part of 'astro_profile_bloc.dart';

@immutable
sealed class AstroProfileEvent {}
final class FetchByAstrologerId extends AstroProfileEvent {
  final String id;

  FetchByAstrologerId({required this.id});
}