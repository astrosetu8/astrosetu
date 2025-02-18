import 'package:astrosetu/component/mytext.dart';
import 'package:astrosetu/provider/dashboard/dashboard_bloc.dart';
import 'package:astrosetu/utils/utils.dart';
import 'package:astrosetu/view/Astrologer/all_astrologer.dart';
import 'package:astrosetu/view/call/call_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:astrosetu/modals/dashboard_modal.dart' as dashboard_model;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/share_pref.dart';
import '../../modals/dashboard_modal.dart';
import '../../route/pageroute.dart';
import '../../utils/image.dart';
import '../chat_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<String> images = [];
  List<Map<String, String>> activeBlogs = [];
  List<Map<String, String>> activeBanners = [];
  List<Map<String, String>> onlineAstrologers = [];
  List<Map<String, String>> paidServices = [];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Mocking data loading
    loadData();
  }

  void loadData() async {
    BlocProvider.of<DashboardBloc>(context).add(FetchDashboardDataEvent());
    setState(() {
      isLoading = true;
    });

    // Simulate data fetching
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
      images = [
        'https://via.placeholder.com/150',
        'https://via.placeholder.com/150',
        'https://via.placeholder.com/150',
      ];
      activeBlogs = [
        {"title": "Blog 1", "image": "http://65.1.117.252:5001/public/blog_thumbnails/1738929393485.png"},
        {"title": "Blog 2", "image": "http://65.1.117.252:5001/public/blog_thumbnails/1738929419737.jpg"},
        {"title": "Blog 3", "image": "http://65.1.117.252:5001/public/blog_thumbnails/1738929436302.jpg"},
      ];
      activeBanners = [
        {"image": "http://65.1.117.252:5001/public/banner_images/1737627486329.jpg"},
        {"image": "http://65.1.117.252:5001/public/banner_images/1737627502840.jpg"},
      ];
      onlineAstrologers = [
        {"name": "Astrologer 1", "image": "https://via.placeholder.com/150"},
        {"name": "Astrologer 2", "image": "https://via.placeholder.com/150"},
      ];
      paidServices = [
        {"title": "Premium Kundli", "image": "assets/image/wastuLogo.png"},
        {"title": "Tarot Reading", "image": "assets/image/wastuLogo.png"},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.account_balance_wallet_rounded),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DashboardLoaded) {
            return _buildDashboard(state.dashboard);
          } else if (state is DashboardError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("Welcome to Dashboard"));
        },
      ),
    );
  }


  Widget _buildDashboard(DashboardData dashboard) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w500)),
            const SizedBox(
              height: 10,
            ),
            MyText(label: "Wanna see your future? Then take a reading.",

                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
            const SizedBox(
              height: 10,
            ),
            _sliderBuildWidget(dashboard.activeBanners),
            const SizedBox(
              height: 10,
            ),
            _textBuildWidget(text: "Free Service", onTap: () {}),
            const SizedBox(
              height: 10,
            ),
            SizedBox(height: 150, child: freeSection()),
            const SizedBox(
              height: 10,
            ),
            _textBuildWidget(text: "Chat With Astrologers", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>AstrologersScreen() ));
            }),
            const SizedBox(
              height: 10,
            ),
            _chatBuildWidget(astrologers:   dashboard.onlineAstrologers,userProfile: dashboard.userProfile),
            const SizedBox(
              height: 10,
            ),
            _textBuildWidget(text: "Live Astrologers", onTap: () {}),
            const SizedBox(
              height: 10,
            ),
            SizedBox(height: 150, child: _liveBuildWidget()),
            // _sliderBuildWidget(),
            const SizedBox(
              height: 10,
            ),
            _textBuildWidget(text: "Paid Services", onTap: () {}),
            const SizedBox(
              height: 10,
            ),
            _paidServiceBuildWidget(),
            const SizedBox(
              height: 10,
            ),
            _textBuildWidget(text: "Blog", onTap: () {}),
            const SizedBox(
              height: 10,
            ),
            blogSection(dashboard.activeBlogs),
            const SizedBox(
              height: 10,
            ),
            _cardsBuildWidget(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _textBuildWidget({required String text, required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text("View All",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }

  Widget _sliderBuildWidget(List<dashboard_model.Banner> banners) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (activeBanners.isEmpty) {
      return const Center(child: Text('No Banner available'));
    }

    return Column(
      children: [
        Container(
          child: CarouselSlider.builder(
            itemCount: banners.length,
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIdx) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(
                    "${ImagePath.imageBaseUrl}${banners[index].img}"!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              banners.length,
                  (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index ? Colors.black : Colors.grey,
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget freeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _freeBuildWidget(image: "assets/image/hero.png", text: "Heroscope"),
        _freeBuildWidget(image: "assets/image/s.png", text: "Numerology"),
        _freeBuildWidget(image: "assets/image/r.png", text: "Tarot Reading"),
      ],
    );
  }

  Widget _freeBuildWidget({
    required String image,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Container(
              height: 119,
              width: 90,
              decoration: BoxDecoration(
                color: const Color(0xff26283F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Image.asset(image)),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget _chatBuildWidget(
      {
    required List<Astrologer> astrologers,
    required UserProfile userProfile,
  }) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (onlineAstrologers.isEmpty) {
      return const Center(child: Text('No Chat available'));
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: .60 / .70,
      ),
      shrinkWrap: true,
      physics:  const NeverScrollableScrollPhysics(),
      itemCount: astrologers.length,
      itemBuilder: (context, index) {
      var  astrologer =astrologers[index];
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
        return _buildAstrologerCard(image: "${ImagePath.imageBaseUrl}${astrologer.profileImg}", name: astrologer.name, rating: astrologer.rating.toString(), expert: skillString, amt: astrologer.perMinChat.toString(), call: false, chat: true, video: false, language: languageString, userId: userProfile.id.toString(), astrologerId: astrologer.id.toString()
        );
      },
    );
  }

  Widget _liveBuildWidget() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (onlineAstrologers.isEmpty) {
      return const Center(child: Text('No Live Astrologer available'));
    }

    return SizedBox(
      height: 150,
      child: ListView.builder(
        padding: EdgeInsets.only(right: 10),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(ImagePath.profile)
              // Image.network(
              //   onlineAstrologers[index]["image"]!,
              //   fit: BoxFit.cover,
              //   width: 120,
              // ),
            ),
          );
        },
      ),
    );
  }

  Widget _paidServiceBuildWidget() {
    return ListView.builder(
      physics:  const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: paidServices.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: Row(
                children: [
                  Image.asset(paidServices[index]["image"]!, width: 60, height: 60),
                  const SizedBox(width: 10),
                  Text(
                    paidServices[index]["title"]!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
          ],
        );
      },
    );
  }

  Widget blogSection(List<Blog> blogs) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (activeBanners.isEmpty) {
      return const Center(child: Text('No Banner available'));
    }

    return Column(
      children: [
        Container(
          child: CarouselSlider.builder(
            itemCount: activeBanners.length,
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIdx) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(
                    "${ImagePath.imageBaseUrl}${blogs[index].thumbnailImage}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              activeBanners.length,
                  (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index ? Colors.black : Colors.grey,
                  ),
                );
              }),
        ),
      ],
    );
  }

  // Widget blogSection() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     itemCount: activeBlogs.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         leading: Image.network(activeBlogs[index]["image"]!),
  //         title: Text(activeBlogs[index]["title"]!),
  //       );
  //     },
  //   );
  // }

  Widget _cardsBuildWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _cardsBuildWidget2(image: '', title: ''),
        _dividerbuildWidget(),
        _cardsBuildWidget2(image: '', title: ''),
        _dividerbuildWidget(),
        _cardsBuildWidget2(image: '', title: ''),
      ],
    );
  }

  Widget _cardsBuildWidget2({required String image, required String title}) {
    return Column(
      children: [
        Container(
          width: 42,
          height: 42,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFF26283F),
            shape: OvalBorder(),
          ),
          child: Icon(Icons.border_all, color: Colors.white),
        ),
        SizedBox(
          width: 80,
          child: Text(
            'Always Private & Confidential',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _dividerbuildWidget() {
    return Container(
      height: 100,
      width: 2,
      color: Colors.grey,
    );
  }


  Widget _buildAstrologerCard(
      {required String image,
        required String name,
        required String userId,
        required String astrologerId,
        required dynamic rating,
        required String expert,
        required String amt,
        required bool call,
        required bool chat,
        required bool video,
        required String language}) {
    return Container(
      height: 150.h,
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
              // Positioned(
              //   top: 8,
              //   right: 8,
              //   child: Container(
              //     padding:
              //     const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //     decoration: BoxDecoration(
              //       color: Colors.red,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: const Text(
              //       "Busy",
              //       style: TextStyle(color: Colors.white, fontSize: 10),
              //     ),
              //   ),
              // ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${amt}/min",

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


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    await clearAllData();
    print("All data cleared. User logged out.");


    // Navigate to Login Page & remove all previous routes
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutePath.login,
          (route) => false, // Clears all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red), // Logout icon
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => _logout(context), // Call logout function
          ),
        ],
      ),
    );
  }


}
