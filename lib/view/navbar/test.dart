import 'package:astrosetu/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:astrosetu/modals/dashboard_modal.dart';
import 'package:astrosetu/modals/dashboard_modal.dart' as dashboard_model;

import '../../provider/dashboard/dashboard_bloc.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(FetchDashboardDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
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
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserProfile(dashboard.userProfile),
          SizedBox(height: 20),
          _buildBannerSection(dashboard.activeBanners),
          SizedBox(height: 20),
          _buildBlogSection(dashboard.activeBlogs),
          SizedBox(height: 20),
          _buildAstrologersSection(dashboard.onlineAstrologers),
        ],
      ),
    );
  }

  Widget _buildUserProfile(UserProfile profile) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage("${ImagePath.imageBaseUrl}${profile.profileImg}")),
        title: Text(profile.name),
        subtitle: Text(profile.email),
      ),
    );
  }

  Widget _buildBannerSection( List<dashboard_model.Banner> banners) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Active Banners", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.network("${ImagePath.imageBaseUrl}${banners[index].img}", width: 200, fit: BoxFit.cover),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBlogSection(List<Blog> blogs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Blogs", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ...blogs.map((blog) => Card(
          child: ListTile(
            title: Text(blog.title),
            subtitle: Text(blog.author),
            leading: Image.network("${ImagePath.imageBaseUrl}${blog.thumbnailImage}", width: 50, height: 50, fit: BoxFit.cover),
          ),
        )),
      ],
    );
  }

  Widget _buildAstrologersSection(List<Astrologer> astrologers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Online Astrologers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ...astrologers.map((astrologer) => Card(
          child: ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage("${ImagePath.imageBaseUrl}${astrologer.profileImg}")),
            title: Text(astrologer.name),
            subtitle: Text("Experience: ${astrologer.experience} years"),
          ),
        )),
      ],
    );
  }
}
