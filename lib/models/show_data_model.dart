class ShowData {
  int? Date;
  String? PName;
  String? SName;
  String? Time;
  String? ZoneColor;



  ShowData({
    this.Date,
    this.PName,
    this.SName,
    this.Time,
    this.ZoneColor,
  });

  Map<String, dynamic> toJson() {
    return {
      "Date": this.Date,
      "PName": this.PName,
      "SName": this.SName,
      "Time": this.Time,
      "ZoneColor": this.ZoneColor,

    };
  }

  factory ShowData.fromJson(Map<String, dynamic> json) {
    return ShowData(
      Date: json["Date"] ?? "",
      PName: json["PName"] ?? "",
      SName: json["SName"] ?? "",
      Time: json["Time"] ?? "",
      ZoneColor: json["ZoneColor"] ?? "",


    );
  }
}
