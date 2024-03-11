import 'package:json_annotation/json_annotation.dart';

part 'route_var_model.g.dart';

@JsonSerializable()
class RouteVarModel {
  final String id;
  @JsonKey(name: 'routeVarId')
  final int routeVarId;
  @JsonKey(name: 'routeVarName')
  final String routeVarName;
  @JsonKey(name: 'routeVarShortName')
  final String routeVarShortName;
  final String startStop;
  final String endStop;
  @JsonKey(name: 'outBound')
  final bool outBound;
  @JsonKey(name: 'runningTime')
  final num runningTime;
  final num distance;

  RouteVarModel({
    required this.id,
    required this.routeVarId,
    required this.routeVarName,
    required this.routeVarShortName,
    required this.startStop,
    required this.endStop,
    required this.outBound,
    required this.runningTime,
    required this.distance,
  });

  factory RouteVarModel.fromJson(Map<String, dynamic> json) =>
      _$RouteVarModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteVarModelToJson(this);
}
