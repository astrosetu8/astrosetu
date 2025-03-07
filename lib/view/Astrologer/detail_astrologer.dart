import 'package:astrosetu/component/mytext.dart';
import 'package:astrosetu/modals/astro_profile.dart';
import 'package:astrosetu/provider/profile/profile_bloc.dart';
import 'package:astrosetu/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provider/astro_profile/astro_profile_bloc.dart';
import '../../provider/astrologer/astrologer_bloc.dart';

class AstrologerProfileScreen extends StatefulWidget {
  final String id;

  const AstrologerProfileScreen({super.key, required this.id});

  @override
  State<AstrologerProfileScreen> createState() =>
      _AstrologerProfileScreenState();
}

class _AstrologerProfileScreenState extends State<AstrologerProfileScreen> {
  late AstroProfileModal astrologerData;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AstroProfileBloc>(context).add(
      FetchByAstrologerId(id: widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AstroProfileBloc, AstroProfileState>(
        builder: (context, state) {
          if (state is AstrologerByIdLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AstrologerByIdError) {
            return const Center(
              child: Text("Failed to load profile. Please try again."),
            );
          } else if (state is AstrologerByIdLoaded) {
            final astrologerData = state.astrologersProfile;
            print("profile data >>>>>>$astrologerData");
            return buildProfileScreen(astrologerData);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget buildProfileScreen(AstroProfileModal data) {
    return Stack(
      children: [
        // Background Image
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "${ImagePath.imageBaseUrl}${data.data.profileImg}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Back Button
        Positioned(
          top: 40,
          left: 20,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        // Draggable Scrollable Sheet
        DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileHeader(data.data),
                      const SizedBox(height: 20),
                      _buildAboutSection(data.data.about),
                      const SizedBox(height: 20),
                      _buildPricingTabs(data.data),
                      const SizedBox(height: 20),
                      _buildCustomerReviews(data.latestReviews),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Profile Header
  Widget _buildProfileHeader(AstrologerData data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
          NetworkImage("${ImagePath.imageBaseUrl}${data.profileImg}"),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.verified, color: Colors.blue, size: 20),
                  Expanded(child: Icon(Icons.share))
                ],
              ),
              Text(
                "${data.experience} years experience",
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                data.skills.map((e) => e.name).join(", "),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // About Section
  Widget _buildAboutSection(String about) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          MyText(
          label: "About",
          fontSize: 16, fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  label: about,
                  fontSize: 14.sp,
                  fontColor: Colors.black87,
                  maxLines: isExpanded ? null : 3, // Show only 3 lines initially
                  overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
                if (about.length > 100) // Show "See More" only if text is long
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        isExpanded ? "See Less" : "See More",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  // Pricing Tabs
  Widget _buildPricingTabs(AstrologerData data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTab(label: "₹${data.perMinChat}/min\nChat",isActive: data.isChatOnline.toString()),
        _buildTab(label: "₹${data.perMinVoiceCall}/min\nCall",isActive: data.isVoiceOnline.toString()),
        _buildTab(label: "₹${data.perMinVideoCall}/min\nVideo",isActive: data.isVideoOnline.toString()),
      ],
    );
  }

  Widget _buildTab({required String label, required String isActive}) {
    return Container(
      padding:   EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
      margin:   EdgeInsets.only(right:  12),
      decoration: BoxDecoration(
          color: isActive != "on" ? Colors.grey.shade300 : Color(0xff5cbd5c),
        //border: Border.all(color: isActive != "on" ? Colors.blue : Colors.green),
        borderRadius: BorderRadius.circular(20),
      ),
      child: MyText(
       label:  label,
       alignment: true,
      fontSize: 13, fontWeight: FontWeight.w500,
      ),
    );
  }

  // Customer Reviews Section
  Widget _buildCustomerReviews(List<dynamic> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Reviews",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: reviews.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return _buildReviewCard(review);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review["review"],
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(review["userImage"]),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review["userName"],
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: List.generate(
                      review["rating"],
                          (index) =>
                      const Icon(Icons.star, color: Colors.orange, size: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
