class   User
{
 User(); 
 
  int? id;
  String? name;
  String? contact;
  String? description;
  String? image;
  String? bloodgroup;
  

  userMap(){
    var mapping=Map<String,dynamic>();
    
    mapping['id']=id??null;
    mapping['name']=name!;
     mapping['contact']=contact!;
      mapping['description']=description!;
      mapping['image']=image!;
      mapping['bloodgroup']=bloodgroup!;
      
      return mapping;
  }
}