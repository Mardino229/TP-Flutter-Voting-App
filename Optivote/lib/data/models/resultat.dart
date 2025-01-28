class Resultat {
  int? id;
  int? electionId;
  int? candidatId;
  int? votes;
  double? percentage;

  Resultat(
      {this.id, this.electionId, this.candidatId, this.votes, this.percentage});

  Resultat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    electionId = json['election_id'];
    candidatId = json['candidat_id'];
    votes = json['votes'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['election_id'] = this.electionId;
    data['candidat_id'] = this.candidatId;
    data['votes'] = this.votes;
    data['percentage'] = this.percentage;
    return data;
  }
}
