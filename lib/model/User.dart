class StudentModel {
  final int? id;
  final String name;
  final String contact;
  final String description;
  final String image;
  final String bloodgroup;
  StudentModel(
      {required this.name,
      required this.contact,
      required this.description,
      required this.image,
      required this.bloodgroup,
      this.id
      });

  factory StudentModel.fromMap(Map<String,dynamic>map){
    return StudentModel(
      id : map['id'],
      name : map['name'],
      contact : map['contact'],
      description :map['description'],
      image :map['image'],
      bloodgroup :map['bloodgroup']
    );
  }

}
