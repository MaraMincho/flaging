class BoardList {
  String? title;
  String? content;
  String? doName;
  String? sigungu;
  String? location;
  String? runningDate;
  String? runningAgeType;
  String? maxPeople;
  List<String>? imgUrlList;

  BoardList(
      {this.title,
        this.content,
        this.doName,
        this.sigungu,
        this.location,
        this.runningDate,
        this.runningAgeType,
        this.maxPeople,
        this.imgUrlList});

  BoardList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    doName = json['doName'];
    sigungu = json['sigungu'];
    location = json['location'];
    runningDate = json['runningDate'];
    runningAgeType = json['runningAgeType'];
    maxPeople = json['maxPeople'];
    imgUrlList = json['imgUrlList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['doName'] = this.doName;
    data['sigungu'] = this.sigungu;
    data['location'] = this.location;
    data['runningDate'] = this.runningDate;
    data['runningAgeType'] = this.runningAgeType;
    data['maxPeople'] = this.maxPeople;
    data['imgUrlList'] = this.imgUrlList;
    return data;
  }
}
