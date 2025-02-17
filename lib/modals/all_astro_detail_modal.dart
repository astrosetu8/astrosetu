class AstrologerResponse {
  final bool success;
  final String message;
  final List<AstrologerModel> data;

  AstrologerResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AstrologerResponse.fromJson(Map<String, dynamic> json) {
    return AstrologerResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => AstrologerModel.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((astro) => astro.toJson()).toList(),
    };
  }
}

class AstrologerModel {
  final String id;
  final String name;
  final String number;
  final List<Language> languages;
  final List<Skill> skills;
  final int perMinChat;
  final int perMinVoiceCall;
  final int perMinVideoCall;
  final bool isChatOnline;
  final bool isVoiceOnline;
  final bool isVideoOnline;
  final String profileImg;
  final bool busy;
  final double rating;

  AstrologerModel({
    required this.id,
    required this.name,
    required this.number,
    required this.languages,
    required this.skills,
    required this.perMinChat,
    required this.perMinVoiceCall,
    required this.perMinVideoCall,
    required this.isChatOnline,
    required this.isVoiceOnline,
    required this.isVideoOnline,
    required this.profileImg,
    required this.busy,
    required this.rating,
  });

  factory AstrologerModel.fromJson(Map<String, dynamic> json) {
    return AstrologerModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      number: json['number'] ?? '',
      languages: (json['languages'] as List<dynamic>?)
          ?.map((lang) => Language.fromJson(lang))
          .toList() ??
          [],
      skills: (json['skills'] as List<dynamic>?)
          ?.map((skill) => Skill.fromJson(skill))
          .toList() ??
          [],
      perMinChat: json['per_min_chat'] ?? 0,
      perMinVoiceCall: json['per_min_voice_call'] ?? 0,
      perMinVideoCall: json['per_min_video_call'] ?? 0,
      isChatOnline: json['is_chat_online'] == "on",
      isVoiceOnline: json['is_voice_online'] == "on",
      isVideoOnline: json['is_video_online'] == "on",
      profileImg: json['profile_img'] ?? '',
      busy: json['busy'] ?? false,
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'number': number,
      'languages': languages.map((lang) => lang.toJson()).toList(),
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'per_min_chat': perMinChat,
      'per_min_voice_call': perMinVoiceCall,
      'per_min_video_call': perMinVideoCall,
      'is_chat_online': isChatOnline ? "on" : "off",
      'is_voice_online': isVoiceOnline ? "on" : "off",
      'is_video_online': isVideoOnline ? "on" : "off",
      'profile_img': profileImg,
      'busy': busy,
      'rating': rating,
    };
  }
}

class Language {
  final String id;
  final String name;

  Language({
    required this.id,
    required this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Skill {
  final String id;
  final String name;

  Skill({
    required this.id,
    required this.name,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
