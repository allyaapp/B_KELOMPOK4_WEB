class AuthModels {
  int? id;
  String? name;
  String? email;
  String? level;
  Null emailVerifiedAt;
  Null twoFactorSecret;
  Null twoFactorRecoveryCodes;
  Null currentTeamId;
  Null profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;
  String? token;
  String? profile;

  AuthModels(
    user, {
    this.id,
    this.name,
    this.email,
    this.level,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
    this.token,
    this.profile,
  });

  AuthModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    level = json['level'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
    token = json['token'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['level'] = this.level;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['two_factor_secret'] = this.twoFactorSecret;
    data['two_factor_recovery_codes'] = this.twoFactorRecoveryCodes;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_photo_url'] = this.profilePhotoUrl;
    data['token'] = this.profilePhotoUrl;
    data['profile'] = this.profilePhotoUrl;
    return data;
  }
}
