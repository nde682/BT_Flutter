
class Userlogin {
  int? id;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? accessToken;
  String? refreshToken;

  Userlogin({
    this.id,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.accessToken,
    this.refreshToken
  });
  factory Userlogin.fromJson(Map<String, dynamic> json){
  return Userlogin(
    id : json["id"]??1,
    userName : json["userName"]??"",
    email : json["email"]??"",
    firstName : json["firstName"]??"",
    lastName : json["lastName"]??"",
    gender : json["gender"]??"",
    image : json["image"]??"",
    accessToken : json["accessToken"]??"",
    refreshToken : json["refreshToken"]??"",
  );
}}

