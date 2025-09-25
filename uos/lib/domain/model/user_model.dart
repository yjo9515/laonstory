import 'package:json_annotation/json_annotation.dart';

part 'generated/user_model.g.dart';


@JsonSerializable()
class User {
  @JsonKey(name: "idx")
   int? idx;
  @JsonKey(name: "id")
   String? id;
  @JsonKey(name: "name")
   String? name;
  @JsonKey(name: "name_en")
   String? nameEn;
  @JsonKey(name: "nickname")
   String? nickname;
  @JsonKey(name: "email")
   String? email;
  @JsonKey(name: "phone")
   String? phone;
  @JsonKey(name: "country")
   String? country;
  @JsonKey(name: "country_en")
   String? countryEn;
  @JsonKey(name: "city")
   String? city;
  @JsonKey(name: "city_en")
   String? cityEn;
  @JsonKey(name: "affiliation")
   String? affiliation;
  @JsonKey(name: "dept")
   String? dept;
  @JsonKey(name: "position")
   String? position;
  @JsonKey(name: "major")
   String? major;
  @JsonKey(name: "major_en")
   String? majorEn;
  @JsonKey(name: "research_field")
   String? researchField;
  @JsonKey(name: "admission")
   String? admission;
  @JsonKey(name: "birthday")
   DateTime? birthday;
  @JsonKey(name: "img")
   String? img;
  @JsonKey(name: "img_path")
   String? imgPath;
  @JsonKey(name: "ROLE_USER")
   String? roleUser;
  @JsonKey(name: "sns")
   List<Sns>? sns;

  User({
    this.idx,
    this.id,
    this.name,
    this.nameEn,
    this.nickname,
    this.email,
    this.phone,
    this.country,
    this.countryEn,
    this.city,
    this.cityEn,
    this.affiliation,
    this.dept,
    this.position,
    this.major,
    this.majorEn,
    this.researchField,
    this.admission,
    this.birthday,
    this.img,
    this.roleUser,
    this.sns,
    this.imgPath
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Sns {
  @JsonKey(name: "social")
   String? social;
  @JsonKey(name: "url")
   String? url;


  Sns({
    this.social,
    this.url,

  });

  factory Sns.fromJson(Map<String, dynamic> json) => _$SnsFromJson(json);

  Map<String, dynamic> toJson() => _$SnsToJson(this);
}