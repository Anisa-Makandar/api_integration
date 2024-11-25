class SupportDataModel {
  String text;
  String url;

  SupportDataModel({required this.text, required this.url});
  factory SupportDataModel.fromJson(Map<String, dynamic> json) {
    return SupportDataModel(
      text: json['text'],
      url: json['url'],
    );
  }
}

class DataModel {
  int id;
  String first_name;
  String last_name;
  String email;
  String avatar;

  DataModel(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.avatar});
  factory DataModel.fromJson(Map<String, dynamic> datajson) {
    return DataModel(
        id: datajson['id'],
        first_name: datajson['first_name'],
        last_name: datajson['last_name'],
        email: datajson['email'],
        avatar: datajson['avatar']);
  }
}

class UserDataModel {
  int per_page;
  int page;
  int total;
  int total_pages;
  List<DataModel> data;
  SupportDataModel support;

  UserDataModel(
      {required this.per_page,
      required this.page,
      required this.total,
      required this.total_pages,
      required this.data,
      required this.support});
  factory UserDataModel.fromJson(Map<String, dynamic> userjson) {
    // var list = userjson['data'] as List;

    // List<DataModel> dataList =
    //     list.map((index) => DataModel.fromJson(index)).toList();
    List<DataModel> dataList = (userjson['data'] as List)
        .map((index) => DataModel.fromJson(index))
        .toList();

    for (Map<String, dynamic> eachMap in userjson['data']) {
      dataList.add(DataModel.fromJson(eachMap));
    }

    return UserDataModel(
      per_page: userjson['per_page'],
      page: userjson['page'],
      total: userjson['total'],
      total_pages: userjson['total_pages'],
      data: dataList,
      support: SupportDataModel.fromJson(userjson['support']),
    );
  }
}
