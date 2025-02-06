import 'package:optivote/data/models/candidat.dart';

class Resultat {
  int? id;
  int? electionId;
  int? candidatId;
  int? nbr_vote;
  double? percentage;
  Candidat? candidat;

  Resultat(
      {this.id, this.electionId, this.candidatId, this.nbr_vote, this.percentage, this.candidat});

  Resultat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    electionId = json['election_id'];
    candidatId = json['candidat_id'];
    nbr_vote = json['nbr_vote'];
    percentage = (json['percentage'] as num).toDouble();
    candidat = json['candidat'] != null
        ? new Candidat.fromJson(json['candidat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['election_id'] = this.electionId;
    data['candidat_id'] = this.candidatId;
    data['nbr_vote'] = this.nbr_vote;
    data['percentage'] = this.percentage;
    if (this.candidat != null) {
      data['candidat'] = this.candidat!.toJson();
    }
    return data;
  }
}
