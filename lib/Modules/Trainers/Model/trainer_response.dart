 
import 'package:talents/Modules/Trainers/Model/trainer.dart';

class TrainersResponse {
  final int currentPage;
  final List<Trainer> data;
  

  TrainersResponse({
    required this.currentPage,
    required this.data,  
  });

  factory TrainersResponse.fromJson(Map<String, dynamic> json) =>
      TrainersResponse(
        currentPage: json['data']["current_page"],
        data: List<Trainer>.from(json["data"]['data'].map((x) => Trainer.fromJson(x))),  
      );
 
}
