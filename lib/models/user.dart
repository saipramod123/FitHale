class User {
  String name;
  String email;
  String age;
  String height;
  String weight;
  String gender;
  var health=[];
  String ohealth;
  var foods=[];
  var ofoods;

  User(

      this.name,
      this.email,
      this.age,
      this.height,
      this.weight,
      this.gender,
      this.health,
      this.ohealth,
      this.foods,
      this.ofoods,


      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email':email,
    'age': age,
    'height': height,
    'weight': weight,
    'gender': gender,
    'health': health,
    'ohealth': ohealth,
    'foods': foods,
    'ofoods': ofoods,
  };
}