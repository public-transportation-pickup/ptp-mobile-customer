class Trip {
  final String id;
  final String description;
  final String startTime;
  final String endTime;
  final String applyDates;
  final List<Schedule> schedules;

  Trip({
    required this.id,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.applyDates,
    required this.schedules,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['trip']['id'],
      description: json['trip']['description'],
      startTime: json['trip']['startTime'],
      endTime: json['trip']['endTime'],
      applyDates: json['trip']['applyDates'],
      schedules: List<Schedule>.from(json['trip']['schedules']
          .map((schedule) => Schedule.fromJson(schedule))),
    );
  }
}

class Schedule {
  final int index;
  final int distanceFromStart;
  final int distanceToNext;
  final double durationFromStart;
  final double durationToNext;
  final String stationName;
  final String arrivalTime;
  final String? storeId;
  final String stationId;

  Schedule({
    required this.index,
    required this.distanceFromStart,
    required this.distanceToNext,
    required this.durationFromStart,
    required this.durationToNext,
    required this.stationName,
    required this.arrivalTime,
    required this.storeId,
    required this.stationId,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      index: json['index'],
      distanceFromStart: json['distanceFromStart'],
      distanceToNext: json['distanceToNext'],
      durationFromStart: json['durationFromStart'],
      durationToNext: json['durationToNext'],
      stationName: json['stationName'],
      arrivalTime: json['arrivalTime'],
      storeId: json['storeId'],
      stationId: json['stationId'],
    );
  }
}
