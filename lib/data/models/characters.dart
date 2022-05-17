class Character{
  dynamic charId;
  late String name;
  late String nickname;
  String? birthday;
  List<String>? occupation;  // == List<dynamic>jobs;
  late String image;// == images
  late String statusIfDeadOrAlive;
  List<dynamic>? appearanceOfSeasons;
  String? actorName;
  late String categoryForTwoSeries;
  List<Null>? betterCallSaulAppearance;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'].cast<String>();
    image = json['img'];
    statusIfDeadOrAlive = json['status'];
    nickname = json['nickname'];
    appearanceOfSeasons = json['appearance'].cast<int>();
    actorName = json['portrayed'];
    categoryForTwoSeries = json['category'];
    betterCallSaulAppearance=json['better_call_saul_appearance'];
    // if (json['better_call_saul_appearance'] != null) {
    //   betterCallSaulAppearance = <Null>[];
    //   json['better_call_saul_appearance'].forEach((v) {
    //     betterCallSaulAppearance!.add(new Null.fromJson(v));
    //   });
    }
  }
