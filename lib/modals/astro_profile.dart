class AstroProfileModal {
  final bool success;
  final String message;
  final AstrologerData data;
  final List<Review> latestReviews;

  AstroProfileModal({
    required this.success,
    required this.message,
    required this.data,
    required this.latestReviews,
  });

  factory AstroProfileModal.fromJson(Map<String, dynamic> json) {
    return AstroProfileModal(
      success: json['success'],
      message: json['message'],
      data: AstrologerData.fromJson(json['data']['astrologer']),
      latestReviews: (json['data']['latestReviews'] as List)
          .map((e) => Review.fromJson(e))
          .toList(),
    );
  }
}

class AstrologerData {
  final String id;
  final String name;
  final String number;
  final String email;
  final String about;
  final int experience;
  final DateTime dob;
  final String gender;
  final String address;
  final List<Language> languages;
  final List<Skill> skills;
  final String state;
  final String city;
  final AccountDetails accountDetails;
  final int wallet;
  final int commission;
  final int perMinChat;
  final int perMinVoiceCall;
  final int perMinVideoCall;
  final String isChat;
  final String isVoiceCall;
  final String isVideoCall;
  final String isChatOnline;
  final String isVoiceOnline;
  final String isVideoOnline;
  final String profileImg;
  final String status;
  final bool passwordCreated;
  final String deviceToken;
  final String deviceId;
  final String? contactNo2;
  final String pincode;
  final String panCard;
  final String aadharCardNo;
  final String? gst;
  final bool busy;
  final String? callType;
  final dynamic rating;
  final int totalReviews;
  final int callCounts;
  final DateTime createdAt;
  final DateTime updatedAt;

  AstrologerData({
    required this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.about,
    required this.experience,
    required this.dob,
    required this.gender,
    required this.address,
    required this.languages,
    required this.skills,
    required this.state,
    required this.city,
    required this.accountDetails,
    required this.wallet,
    required this.commission,
    required this.perMinChat,
    required this.perMinVoiceCall,
    required this.perMinVideoCall,
    required this.isChat,
    required this.isVoiceCall,
    required this.isVideoCall,
    required this.isChatOnline,
    required this.isVoiceOnline,
    required this.isVideoOnline,
    required this.profileImg,
    required this.status,
    required this.passwordCreated,
    required this.deviceToken,
    required this.deviceId,
    this.contactNo2,
    required this.pincode,
    required this.panCard,
    required this.aadharCardNo,
    this.gst,
    required this.busy,
    this.callType,
    required this.rating,
    required this.totalReviews,
    required this.callCounts,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AstrologerData.fromJson(Map<String, dynamic> json) {
    return AstrologerData(
      id: json['_id'],
      name: json['name'],
      number: json['number'],
      email: json['email'],
      about: json['about'],
      experience: json['experience'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      address: json['address'],
      languages: (json['languages'] as List)
          .map((e) => Language.fromJson(e))
          .toList(),
      skills: (json['skills'] as List).map((e) => Skill.fromJson(e)).toList(),
      state: json['state'],
      city: json['city'],
      accountDetails: AccountDetails.fromJson(json['account_details']),
      wallet: json['wallet'],
      commission: json['commission'],
      perMinChat: json['per_min_chat'],
      perMinVoiceCall: json['per_min_voice_call'],
      perMinVideoCall: json['per_min_video_call'],
      isChat: json['is_chat'],
      isVoiceCall: json['is_voice_call'],
      isVideoCall: json['is_video_call'],
      isChatOnline: json['is_chat_online'],
      isVoiceOnline: json['is_voice_online'],
      isVideoOnline: json['is_video_online'],
      profileImg: json['profile_img'],
      status: json['status'],
      passwordCreated: json['password_created'],
      deviceToken: json['deviceToken'],
      deviceId: json['deviceId'],
      contactNo2: json['contact_no2'],
      pincode: json['pincode'],
      panCard: json['pan_card'],
      aadharCardNo: json['aadhar_card_no'],
      gst: json['gst'],
      busy: json['busy'],
      callType: json['call_type'],
      rating: json['rating'],
      totalReviews: json['total_reviews'],
      callCounts: json['call_counts'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Review {
  final String id;
  final User user;
  final String astrologerId;
  final double rating;
  final String review;
  final DateTime timestamp;

  Review({
    required this.id,
    required this.user,
    required this.astrologerId,
    required this.rating,
    required this.review,
    required this.timestamp,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      user: User.fromJson(json['user_id']),
      astrologerId: json['astrologer_id'],
      rating: (json['rating'] as num).toDouble(),
      review: json['review'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String profileImg;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImg,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      profileImg: json['profile_img'] ?? "",
    );
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
      id: json['_id'],
      name: json['name'],
    );
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
      id: json['_id'],
      name: json['name'],
    );
  }
}

class AccountDetails {
  final String accountType;
  final String accountHolderName;
  final String accountNo;
  final String bank;
  final String ifsc;

  AccountDetails({
    required this.accountType,
    required this.accountHolderName,
    required this.accountNo,
    required this.bank,
    required this.ifsc,
  });

  factory AccountDetails.fromJson(Map<String, dynamic> json) {
    return AccountDetails(
      accountType: json['account_type'],
      accountHolderName: json['account_holder_name'],
      accountNo: json['account_no'],
      bank: json['bank'],
      ifsc: json['ifsc'],
    );
  }
}
