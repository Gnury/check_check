class PostDetails {
  final String details;
  final String limitAllPiece;
  final String limitPerPerson;
  final String limitTime;
  final List<String> options;
  final List<String> imageUrlList;

  const PostDetails({
    required this.details,
    required this.limitAllPiece,
    required this.limitPerPerson,
    required this.limitTime,
    required this.options,
    required this.imageUrlList,
  });

  factory PostDetails.fromJson(Map<String, dynamic> json) => PostDetails(
    details: json["details"],
    limitAllPiece: json["limit_all_piece"],
    limitPerPerson: json["limit_per_person"],
    limitTime: json["limit_time"],
    options: List<String>.from(json["options"].map((x) => x)),
    imageUrlList: List<String>.from(json["image_url_list"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "details": details,
    "limit_all_piece": limitAllPiece,
    "limit_per_person": limitPerPerson,
    "limit_time": limitTime,
    "options": List<dynamic>.from(options.map((x) => x)),
    "image_url_list": List<dynamic>.from(imageUrlList.map((x) => x)),
  };
}
