class UserModel {
  String? uName;
  String? uEmail;
  String? uPassword;
  String? uId;
  bool? isOnline;
  String? uProfileImage;
  String? aboutUs;

  UserModel(
      {this.uName,
        this.uEmail,
        this.uPassword,
        this.uId,
        this.isOnline,
        this.uProfileImage,
        this.aboutUs
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    uName = json['uName'];
    uEmail = json['uEmail'];
    uPassword = json['uPassword'];
    uId = json['uId'];
    isOnline = json['isOnline'];
    uProfileImage = json['uProfileImage'];
    aboutUs=json['aboutUs'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();



    data['uName'] = this.uName;
    data['uEmail'] = this.uEmail;
    data['uPassword'] = this.uPassword;
    data['uId'] = this.uId;
    data['isOnline'] = this.isOnline;
    data['uProfileImage'] = this.uProfileImage;
    data['aboutUs']=this.aboutUs;
    return data;
  }
}
