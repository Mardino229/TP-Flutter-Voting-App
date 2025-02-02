class AuthenticatedUser {
  String? accessToken;
  String? role;
  int? id;
  int? npi;

  AuthenticatedUser({this.accessToken, this.role, this.id, this.npi});

  AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    role = json['role'];
    npi = json['npi'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['role'] = this.role;
    data['id'] = this.id;
    data['npi'] = this.npi;
    return data;
  }
}
