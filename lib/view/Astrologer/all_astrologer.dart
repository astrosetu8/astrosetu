import 'package:astrosetu/utils/image.dart';
import 'package:astrosetu/view/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../modals/all_astro_detail_modal.dart';
import '../../provider/astrologer/astrologer_bloc.dart';
import '../call/call_screen.dart';
import 'detail_astrologer.dart';

class AstrologersScreen extends StatefulWidget {
  const AstrologersScreen({super.key});

  @override
  State<AstrologersScreen> createState() => _AstrologersScreenState();
}

class _AstrologersScreenState extends State<AstrologersScreen> {
  String currentIndex = "0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AstrologerBloc>(context).add(FetchAstrologers(""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
        "Astrologers",
      )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffFFEECB),
                prefixIcon: const Icon(Icons.search),
                hintText: "Search, Astrologers, Pooja",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          BlocBuilder<AstrologerBloc, AstrologerState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton(context, "All", ""),
                  _buildTabButton(context, "Call", "voice"),
                  _buildTabButton(context, "Chat", "chat"),
                  _buildTabButton(context, "Video Call", "video"),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: GridView.builder(
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2, // Number of cards in a row
          //         crossAxisSpacing: 10,
          //         mainAxisSpacing: 20,
          //         childAspectRatio: 3 / 3.5,
          //       ),
          //       itemCount: 4, // Adjust this for the number of static cards
          //       itemBuilder: (context, index) {
          //         return GestureDetector(
          //           onTap: (){
          //             Navigator.push(context, MaterialPageRoute(builder: (context) =>AstrologerProfileScreen(id: '',) ));
          //
          //           },
          //           child: _buildAstrologerCard(
          //             image:
          //                 "http://65.1.117.252:5001/public/blog_thumbnails/1738929393485.png", // Static image
          //             name: "Astrologer ${index + 1}",
          //             rating: "4.${index + 1}",
          //             expert: "Expert in Astrology",
          //             amt: "${50 + (index * 10)}",
          //             call: index % 2 == 0, // Toggle call availability
          //             chat: true,
          //             video: index % 2 != 0, // Toggle video availability
          //             language: "English, Hindi",
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),

          Expanded(
            child: BlocBuilder<AstrologerBloc, AstrologerState>(
              builder: (context, state) {
                if (state is AstrologerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AstrologerLoaded) {
                  AstrologerResponse astrologers = state.astrologers;
                  // print("data>>>>>>>>>> $astrologers");
                  if (astrologers.data.isEmpty) {
                    return const Center(
                        child: Text('No Astrologers available'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 3 / 3.5,
                    ),
                    itemCount: astrologers.data.length,
                    itemBuilder: (context, index) {
                      final astrologer = astrologers.data[index];

                      // Collect all languages in a comma-separated string
                      final languages = astrologer.languages;
                      final skills = astrologer.skills;
                      final String languageString = languages
                          .take(2) // Take only the first 2 languages
                          .map((lang) => lang.name)
                          .join(', ');
                      final String skillString = skills
                          .take(2) // Take only the first 2 languages
                          .map((skill) => skill.name)
                          .join(', ');

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AstrologerProfileScreen(
                                id: astrologer.id.toString(),
                              ),
                            ),
                          );
                        },
                        child: _buildAstrologerCard(
                          image:
                              "${ImagePath.imageBaseUrl}${astrologer.profileImg}",
                          amt: astrologer.perMinChat.toString(),
                          call: astrologer
                              .isVoiceOnline, // Modify this based on the tab logic
                          chat: astrologer.isChatOnline,
                          video: astrologer.isVideoOnline,
                          language: languageString,
                          expert: skillString,
                          name: astrologer.name,
                          rating: astrologer.rating.toString(), userId: astrologer.id.toString(), astrologerId: astrologer.id.toString(),
                        ),
                      );
                    },
                  );
                } else if (state is AstrologerError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, String label, String index) {
    final AstrologerBloc bloc = BlocProvider.of<AstrologerBloc>(context);
    return GestureDetector(
      onTap: () {
        bloc.add(FetchAstrologers(index));
        setState(() {
          currentIndex = index.toString();
        });
      },
      child: BlocBuilder<AstrologerBloc, AstrologerState>(
        builder: (context, state) {
          final isSelected =
              (state is AstrologerLoaded && state.astrologers.data.isEmpty);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xff26283F)
                  : const Color(0xffDCDCDC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to check service availability
  bool _checkServiceAvailability(dynamic astrologer, String serviceType) {
    if (serviceType == "voice" && astrologer["voice_available"]) {
      return true;
    } else if (serviceType == "chat" && astrologer["chat_available"]) {
      return true;
    } else if (serviceType == "video" && astrologer["video_available"]) {
      return true;
    } else if (serviceType == "all") {
      return true; // Show all astrologers
    }
    return false;
  }

  Widget _buildAstrologerCard(
      {required String image,
      required String name,
      required String rating,
        required String userId,
        required String astrologerId,
      required String expert,
      required String amt,
      required bool call,
      required bool chat,
      required bool video,
      required String language}) {
    return Container(
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x49000000),
            blurRadius: 10,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 95.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                child: Image.network(image, fit: BoxFit.fill),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Busy",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: ShapeDecoration(
                        color: Color(0xFF147304),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 12, color: Colors.white),
                          SizedBox(width: 3),
                          Text(
                            rating,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(expert,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      overflow: TextOverflow.ellipsis,
                    )),
                Text(language,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      overflow: TextOverflow.ellipsis,
                    )),
                // const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    currentIndex == "0"
                        ? SizedBox()
                        : Text(
                            "₹${amt}/min",
                            key: ValueKey(currentIndex), // Force rebuild
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                    if (call == true)
                      Icon(
                        Icons.phone,
                        color: Color(0xFFFA8166),
                        size: 24,
                      ),
                    if (chat == true)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (_) => CallScreen(callerImage: image, callType: "chat",
                                callerName: name, phone: '', userId: userId, astrologerId: astrologerId,
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.chat,
                          color: Color(0xFFFA8166),
                          size: 24,
                        ),
                      ),
                    if (video == true)
                      Icon(
                        Icons.video_camera_back_rounded,
                        color: Color(0xFFFA8166),
                        size: 24,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
