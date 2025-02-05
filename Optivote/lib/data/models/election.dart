class Election {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  int? status;

  Election({this.id, this.name, this.startDate, this.endDate, this.status});

  Election.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    return data;
  }
}


