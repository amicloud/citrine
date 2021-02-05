import 'dart:io';

enum UserType {
  NEW, CUSTOMER, VENDOR
}

class CitrineUser {

  String fullName;
  String uid;
  String preferredName;
  String profilePictureUrl;
  String userType;
  String publicProfileUid;
  File profilePicture;

  CitrineUser(Map<String, dynamic> _data){
    uid = _data["uid"];
    fullName = _data["full_name"];
    preferredName = _data["preferred_name"];
    profilePictureUrl = _data["profile_picture_url"];
    userType = _data["type"];
    publicProfileUid = _data["public_profile"];
    profilePicture = File(profilePictureUrl);
  }

}


