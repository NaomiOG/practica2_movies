class UserDAO{
  int id;
  String nomusr;
  String apepat;
  String apemat;
  String telusr;
  String mailusr;
  String photousr;

  UserDAO({
    this.id,
    this.nomusr,
    this.apepat,
    this.apemat,
    this.telusr,
    this.mailusr,
    this.photousr
  });

  factory UserDAO.fromJSON(Map<String,dynamic> map ){
    return UserDAO(
      id: map['id'],
      nomusr: map['nomusr'],
      apepat: map['apepat'],
      apemat: map['apemat'],
      telusr: map['telusr'],
      mailusr: map['mailusr'],
      photousr: map['photousr']
    );
  }

//Devuelve un mapa
  Map<String, dynamic> toJSON(){
    return{
      "id": id,
      "nomusr": nomusr,
      "apepat": apepat,
      "apemat": apemat,
      "telusr": telusr,
      "mailusr": mailusr,
      "photousr": photousr
    };
  }
}