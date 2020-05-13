
/// cast_id : 7
/// character : "Hellboy"
/// credit_id : "59112b0bc3a36864a703a266"
/// gender : 2
/// id : 35029
/// name : "David Harbour"
/// order : 0
/// profile_path : "/chPekukMF5SNnW6b22NbYPqAStr.jpg"


class Cast {
  List<Actor> actores = new List();

  Cast.fromJsonList (List<dynamic> jsonList) {
    jsonList.forEach((element) {

      final actor = Actor.fromMap(element);
      actores.add(actor);

    });

  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  static Actor fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Actor actor       = Actor();
    actor.castId      = map['cast_id'];
    actor.character   = map['character'];
    actor.creditId    = map['credit_id'];
    actor.gender      = map['gender'];
    actor.id          = map['id'];
    actor.name        = map['name'];
    actor.order       = map['order'];
    actor.profilePath = map['profile_path'];
    return actor;
  }

  Map toJson() => {
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "gender": gender,
    "id": id,
    "name": name,
    "order": order,
    "profile_path": profilePath,
  };


  getFoto(){
    if(profilePath == null){
      return 'https://iupac.org/wp-content/uploads/2018/05/default-avatar.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}