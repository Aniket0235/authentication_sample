class userModel{
  String? uid;
  String? email;
  String? fullname;

  userModel({
    this.email,this.fullname,this.uid
  });

  factory userModel.fromMap(map){
     return userModel(
       uid: map['uid'],
       email: map['email'],
       fullname: map['fullname'],
     );
  }


  Map<String,dynamic> tomap(){
    return{
      'uid':uid,
      'email':email,
      'fullname':fullname,
    };
  }
}
