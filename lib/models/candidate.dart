class CandidateModel {
  String name;
  String image;
  int no;
  String year;
  String age;
  CandidateModel(
      {required this.age,
      required this.name,
      required this.image,
      required this.no,
      required this.year});

  Map toMap(CandidateModel user) {
    var data = <String, dynamic>{};
    data['name'] = user.name;
    data['image'] = user.image;
    data['no'] = user.no;
    data['year'] = user.year;
    data['age'] = user.age;
    return data;
  }

  // Named constructor
  // CandidateModel.fromMap(Map<String, dynamic> data) {
  //   this.name = data['name'];
  //   this.image = data['image'];
  //   this.no = data['no'];
  //   this.year = data['year'];
  // }
}
