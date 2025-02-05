class ElectionDetails {
  String? delay;
  int? nbrVote;
  List<String>? lead;

  ElectionDetails({this.delay, this.nbrVote, this.lead});

  ElectionDetails.fromJson(Map<String, dynamic> json) {
    delay = json['delay'];
    nbrVote = json['nbr_vote'];
    lead = json['lead'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delay'] = this.delay;
    data['nbr_vote'] = this.nbrVote;
    data['lead'] = this.lead;
    return data;
  }
}