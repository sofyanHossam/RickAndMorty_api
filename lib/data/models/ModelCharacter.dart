class ModelCharacters {
  late int id;
  late String name;
  late String status;
  late String species;
  late String type;
  late String image;
  late String gender;



  ModelCharacters.fromJson(Map<String, dynamic> json){

    id=json["id"];
    name=json['name'];
    status=json['status'];
    species=json['species'];
    type=json['type'];
    image=json['image'];
    gender=json['gender'];


  }

}