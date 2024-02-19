import 'dart:convert';

BarcodeDetails barcodeDetailsFromJson(String str) => BarcodeDetails.fromJson(json.decode(str));

String barcodeDetailsToJson(BarcodeDetails data) => json.encode(data.toJson());

class BarcodeDetails {
  int? id;
  String? name;
  List<String>? allergens;
  List<String>? brands;
  int? carbonFootprint;
  List<String>? categories;
  List<String>? countries;
  String? ecoscoreGrade;
  int? ecoscoreScore;
  String? imageUrl;
  List<String>? ingredients;
  int? novaGroup;
  Nutri? nutrientLevels;
  String? nutriscoreGrade;
  int? nutriscoreScore;
  Nutri? nutriments;
  String? packaging;
  List<String>? warnings;
  String? historyId;

  BarcodeDetails({
    required this.id,
    required this.name,
    required this.allergens,
    required this.brands,
    required this.carbonFootprint,
    required this.categories,
    required this.countries,
    required this.ecoscoreGrade,
    required this.ecoscoreScore,
    required this.imageUrl,
    required this.ingredients,
    required this.novaGroup,
    required this.nutrientLevels,
    required this.nutriscoreGrade,
    required this.nutriscoreScore,
    required this.nutriments,
    required this.packaging,
    required this.warnings,
    required this.historyId,
  });

  factory BarcodeDetails.fromJson(Map<String, dynamic> json) => BarcodeDetails(
    id: json["id"],
    name: json["name"],
    allergens: List<String>.from(json["allergens"].map((x) => x)),
    brands: List<String>.from(json["brands"].map((x) => x)),
    carbonFootprint: json["carbon_footprint"],
    categories: List<String>.from(json["categories"].map((x) => x)),
    countries: List<String>.from(json["countries"].map((x) => x)),
    ecoscoreGrade: json["ecoscore_grade"],
    ecoscoreScore: json["ecoscore_score"],
    imageUrl: json["image_url"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
    novaGroup: json["nova_group"],
    nutrientLevels: Nutri.fromJson(json["nutrient_levels"]),
    nutriscoreGrade: json["nutriscore_grade"],
    nutriscoreScore: json["nutriscore_score"],
    nutriments: Nutri.fromJson(json["nutriments"]),
    packaging: json["packaging"],
    warnings: List<String>.from(json["warnings"].map((x) => x)),
    historyId: json["history_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "allergens": List<dynamic>.from(allergens!.map((x) => x)),
    "brands": List<dynamic>.from(brands!.map((x) => x)),
    "carbon_footprint": carbonFootprint,
    "categories": List<dynamic>.from(categories!.map((x) => x)),
    "countries": List<dynamic>.from(countries!.map((x) => x)),
    "ecoscore_grade": ecoscoreGrade,
    "ecoscore_score": ecoscoreScore,
    "image_url": imageUrl,
    "ingredients": List<dynamic>.from(ingredients!.map((x) => x)),
    "nova_group": novaGroup,
    "nutrient_levels": nutrientLevels?.toJson(),
    "nutriscore_grade": nutriscoreGrade,
    "nutriscore_score": nutriscoreScore,
    "nutriments": nutriments?.toJson(),
    "packaging": packaging,
    "warnings": List<dynamic>.from(warnings!.map((x) => x)),
    "history_id": historyId,
  };
}

class Nutri {
  Nutri();

  factory Nutri.fromJson(Map<String, dynamic> json) => Nutri(
  );

  Map<String, dynamic> toJson() => {
  };
}
