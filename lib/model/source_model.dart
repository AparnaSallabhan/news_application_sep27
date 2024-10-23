
import 'dart:convert';

SourceModel sourceModelFromJson(String str) => SourceModel.fromJson(json.decode(str));

String sourceModelToJson(SourceModel data) => json.encode(data.toJson());

class SourceModel {
    List<NewsSource>? sources;

    SourceModel({
        this.sources,
    });

    factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        sources: json["sources"] == null ? [] : List<NewsSource>.from(json["sources"]!.map((x) => NewsSource.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sources": sources == null ? [] : List<dynamic>.from(sources!.map((x) => x.toJson())),
    };
}

class NewsSource {
    String? id;
    String? name;
    String? description;
    String? url;
    String? category;
    String? language;
    String? country;

    NewsSource({
        this.id,
        this.name,
        this.description,
        this.url,
        this.category,
        this.language,
        this.country,
    });

    factory NewsSource.fromJson(Map<String, dynamic> json) => NewsSource(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        category: json["category"],
        language: json["language"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "url": url,
        "category": category,
        "language": language,
        "country": country,
    };
}
