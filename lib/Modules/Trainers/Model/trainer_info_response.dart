 
 
import 'package:talents/Modules/Trainers/Model/trainer.dart';

class TrainerInfoResponse {
    final Trainer data;
    final int code;

    TrainerInfoResponse({
        required this.data,
        required this.code,
    });

    factory TrainerInfoResponse.fromJson(Map<String, dynamic> json) => TrainerInfoResponse(
        data: Trainer.fromJson(json["data"]),
        code: json["code"],
    );

   
}
 
