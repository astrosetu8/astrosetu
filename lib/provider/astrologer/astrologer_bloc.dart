import 'package:astrosetu/provider/astrologer/Astrologer_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../modals/all_astro_detail_modal.dart';
import '../../modals/astro_profile.dart';

part 'astrologer_event.dart';
part 'astrologer_state.dart';

class AstrologerBloc extends Bloc<AstrologerEvent, AstrologerState> {
  AstrologerBloc() : super(AstrologerInitial()) {
    on<FetchAstrologers>((event, emit) async {
      emit(AstrologerLoading());

      try {
        String data = "";
        if(event.tab.isEmpty){
          data = "";
        }else{
          data = "?serviceType=${event.tab}";
        }
        var response = await AstrologerRepo().getAstrologer(tab: data);


        if (response.data['success'] == true) {
          AstrologerResponse allDataResponce = AstrologerResponse.fromJson(response.data);
          print("allDataResponce data >>>>> ${allDataResponce}");

          emit(AstrologerLoaded(allDataResponce));
        } else {
          emit(AstrologerError("Failed to fetch astrologers."));
        }
      } catch (e) {
        emit(AstrologerError("An error occurred: $e"));
      }
    });

  }
}
