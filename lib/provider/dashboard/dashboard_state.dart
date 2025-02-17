// dashboard_state.dart
part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardData dashboard;

  DashboardLoaded(this.dashboard);
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
