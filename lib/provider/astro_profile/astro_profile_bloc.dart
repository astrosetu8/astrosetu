import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../modals/astro_profile.dart';
import '../astrologer/Astrologer_repo.dart';

part 'astro_profile_event.dart';
part 'astro_profile_state.dart';

class AstroProfileBloc extends Bloc<AstroProfileEvent, AstroProfileState> {
  AstroProfileBloc() : super(AstroProfileInitial()) {

    on<FetchByAstrologerId>((event, emit) async {
      emit(AstrologerByIdLoading());
      try {

        var response = await AstrologerRepo().getAstrologerById(event.id);

        if (response.data['success'] == true) {
          AstroProfileModal profileResponce = AstroProfileModal.fromJson(response.data);
          print("responce data >>>>> ${profileResponce.data}");
          emit(AstrologerByIdLoaded(profileResponce));
        } else {
          emit(AstrologerByIdError("Failed to fetch astrologers."));
        }
      } catch (e) {
        emit(AstrologerByIdError("An error occurred: $e"));
      }
    });
  }
}
