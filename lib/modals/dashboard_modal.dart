import 'dart:convert';

class DashboardData {
  final bool success;
  final String message;
  final UserProfile userProfile;
  final List<Banner> activeBanners;
  final List<Blog> activeBlogs;
  final List<Astrologer> onlineAstrologers;

  DashboardData({
    required this.success,
    required this.message,
    required this.userProfile,
    required this.activeBanners,
    required this.activeBlogs,
    required this.onlineAstrologers,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      success: json['success'],
      message: json['message'],
      userProfile: UserProfile.fromJson(json['data']['userProfile']),
      activeBanners: List<Banner>.from(json['data']['activeBanners'].map((x) => Banner.fromJson(x))),
      activeBlogs: List<Blog>.from(json['data']['activeBlogs'].map((x) => Blog.fromJson(x))),
      onlineAstrologers: List<Astrologer>.from(json['data']['onlineAstrologers'].map((x) => Astrologer.fromJson(x))),
    );
  }
}

class UserProfile {
  final String id, name, email, number, gender, status, profileImg;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.number,
    required this.gender,
    required this.status,
    required this.profileImg,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      number: json['number'],
      gender: json['gender'],
      status: json['status'],
      profileImg: json['profile_img'],
    );
  }
}

class Banner {
  final String id, link, type, img, status;

  Banner({
    required this.id,
    required this.link,
    required this.type,
    required this.img,
    required this.status,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['_id'],
      link: json['link'],
      type: json['type'],
      img: json['img'],
      status: json['status'],
    );
  }
}

class Blog {
  final String id, title, description, author, thumbnailImage, status;

  Blog({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.thumbnailImage,
    required this.status,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      thumbnailImage: json['thumbnailImage'],
      status: json['status'],
    );
  }
}

class Astrologer {
  final String id, name, email, about, gender, state, city, status, profileImg;
  final int experience, perMinChat, perMinVoiceCall, perMinVideoCall;
  final dynamic rating;
  final List<Skill> skills;
  final List<Language> languages;

  Astrologer({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
    required this.gender,
    required this.state,
    required this.city,
    required this.status,
    required this.profileImg,
    required this.experience,
    required this.perMinChat,
    required this.perMinVoiceCall,
    required this.perMinVideoCall,
    required this.rating,
    required this.skills,
    required this.languages,
  });

  factory Astrologer.fromJson(Map<String, dynamic> json) {
    return Astrologer(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      about: json['about'],
      gender: json['gender'],
      state: json['state'],
      city: json['city'],
      status: json['status'],
      profileImg: json['profile_img'],
      experience: json['experience'],
      perMinChat: json['per_min_chat'],
      perMinVoiceCall: json['per_min_voice_call'],
      perMinVideoCall: json['per_min_video_call'],
      rating: json['rating'],
      skills: List<Skill>.from(json['skills'].map((x) => Skill.fromJson(x))),
      languages: List<Language>.from(json['languages'].map((x) => Language.fromJson(x))),
    );
  }
}

class Skill {
  final String id, name;

  Skill({required this.id, required this.name});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class Language {
  final String id, name;

  Language({required this.id, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['_id'],
      name: json['name'],
    );
  }
}
