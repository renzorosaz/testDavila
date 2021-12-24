// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.items,
    this.count,
  });

  final List<Item>? items;
  final int? count;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
        "count": count == null ? null : count,
      };
}

class Item {
  Item({
    this.image,
    this.createdAt,
    this.description,
    this.title,
    this.user,
    this.id,
  });

  final String? image;
  final DateTime? createdAt;
  final String? description;
  final String? title;
  final User? user;
  final String? id;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        image: json["image"] == null ? null : json["image"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        description: json["description"] == null ? null : json["description"],
        title: json["title"] == null ? null : json["title"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "description": description == null ? null : description,
        "title": title == null ? null : title,
        "user": user == null ? null : user!.toJson(),
        "id": id == null ? null : id,
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.avatar,
  });

  final String? firstName;
  final String? lastName;
  final String? avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        avatar: json["avatar"] == null ? null : json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "avatar": avatar == null ? null : avatar,
      };
}
