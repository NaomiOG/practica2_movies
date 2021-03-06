// Generated by https://quicktype.io

class ActorDAO {
  int id;
  String name;
  String original_name;
  String character;
  String profile_path;
 
  ActorDAO({
    
    this.id,
    this.name,
    this.original_name,
    this.character,
    this.profile_path
  
  });

  factory ActorDAO.fromJSON(Map<String,dynamic> map ){
    return ActorDAO(
      id: map['id'],
      name: map['name'],
      original_name: map['original_name'],
      character: map['character'],
      profile_path: map['profile_path'],
    );
  }
}
