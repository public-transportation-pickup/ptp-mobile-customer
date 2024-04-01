class Trip {
  final String id;
  final String? description;
  final String? startTime;
  final String? endTime;
  final String? applyDates;
  final List<Schedule> schedules;
  final Schedule schedule;

  Trip({
    required this.id,
    this.description,
    this.startTime,
    this.endTime,
    this.applyDates,
    required this.schedules,
    required this.schedule,
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
      schedule: Schedule.fromJson(json['schedule']),
    );
  }
}

class Schedule {
  final int index;
  final int? distanceFromStart;
  final int? distanceToNext;
  final double? durationFromStart;
  final double? durationToNext;
  final String? stationName;
  final String? arrivalTime;
  final String? storeId;
  final String? stationId;
  final double latitude;
  final double longitude;

  Schedule({
    required this.index,
    this.distanceFromStart,
    this.distanceToNext,
    this.durationFromStart,
    this.durationToNext,
    this.stationName,
    this.arrivalTime,
    this.storeId,
    this.stationId,
    required this.latitude,
    required this.longitude,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      index: json['index'],
      distanceFromStart: json['distanceFromStart'] ?? 0,
      distanceToNext: json['distanceToNext'] ?? 0,
      durationFromStart: json['durationFromStart'] != null
          ? json['durationFromStart'] is double
              ? json['durationFromStart']
              : (json['durationFromStart'] as num).toDouble()
          : null,
      durationToNext: json['durationToNext'] != null
          ? json['durationToNext'] is double
              ? json['durationToNext']
              : (json['durationToNext'] as num).toDouble()
          : null,
      stationName: json['stationName'],
      arrivalTime: json['arrivalTime'],
      storeId: json['storeId'],
      stationId: json['stationId'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
