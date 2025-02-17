// dashboard_event.dart
part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class FetchDashboardDataEvent extends DashboardEvent {}
