import 'dart:convert';

class JsonPlaceHolderModel {
  final String title;
  final String url;
  JsonPlaceHolderModel({
    required this.title,
    required this.url,
  });

  JsonPlaceHolderModel copyWith({
    String? title,
    String? url,
  }) {
    return JsonPlaceHolderModel(
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
    };
  }

  factory JsonPlaceHolderModel.fromMap(Map<String, dynamic> map) {
    return JsonPlaceHolderModel(
      title: map['title'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory JsonPlaceHolderModel.fromJson(String source) => JsonPlaceHolderModel.fromMap(json.decode(source));

  @override
  String toString() => 'JsonPlaceHolderModel(title: $title, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is JsonPlaceHolderModel &&
      other.title == title &&
      other.url == url;
  }

  @override
  int get hashCode => title.hashCode ^ url.hashCode;
}
