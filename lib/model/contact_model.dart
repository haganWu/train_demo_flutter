class ContactModel {
  String? contactName;
  String? contactNumber;

  ContactModel({this.contactName, this.contactNumber});

  ContactModel.fromJson(Map<String, dynamic> json) {
    contactName = json['contactName'];
    contactNumber = json['contactNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contactName'] = contactName;
    data['contactNumber'] = contactNumber;
    return data;
  }

}
