import 'package:astrosetu/provider/dashboard/dashboard_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../modals/dashboard_modal.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

// dashboard_bloc.dart
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchDashboardDataEvent>((event, emit) async {
      try {
        emit(DashboardLoading());

var response = await DashboardRepo().getDashboard();
        if (response.statusCode == 200) {

          // Ensure response.data is properly parsed into the Dashboard model
          DashboardData dashboard = DashboardData.fromJson(response.data);

          emit(DashboardLoaded(dashboard));
        } else {
          emit(DashboardError('Failed to load data'));
        }
      } catch (e) {
        emit(DashboardError('An error occurred: $e'));
      }
    });
  }
}
