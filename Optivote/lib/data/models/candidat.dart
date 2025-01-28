class Candidat {
  int? id;
  String? name;
  int? npi;
  int? electionId;
  String? description;
  String? photo;

  Candidat(
      {this.id,
        this.name,
        this.npi,
        this.electionId,
        this.description,
        this.photo});

  Candidat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    npi = json['npi'];
    electionId = json['election_id'];
    description = json['description'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['npi'] = this.npi;
    data['election_id'] = this.electionId;
    data['description'] = this.description;
    data['photo'] = this.photo;
    return data;
  }
}
