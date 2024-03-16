import 'package:json_annotation/json_annotation.dart';
import 'schedule_model.dart';

part 'trip_model.g.dart';

@JsonSerializable()
class TripModel {
  final String id;
  final String? description;
  @JsonKey(name: 'startTime')
  final String startTime;
  @JsonKey(name: 'endTime')
  final String endTime;
  @JsonKey(name: 'applyDates')
  final String applyDates;
  final List<ScheduleModel>? schedules;
  final String status;

  TripModel({
    required this.id,
    this.description,
    required this.startTime,
    required this.endTime,
    required this.applyDates,
    this.schedules,
    required this.status,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  Map<String, dynamic> toJson() => _$TripModelToJson(this);
}
