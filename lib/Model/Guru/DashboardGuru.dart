class DashboardGuru {
  final bool success;
  final DashboardData data;

  DashboardGuru({required this.success, required this.data});

  factory DashboardGuru.fromJson(Map<String, dynamic> json) {
    return DashboardGuru(
      success: json['success'],
      data: DashboardData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data.toJson()};
  }
}

class DashboardData {
  final int uncompletedTasks;
  final int absentStudents;
  final int lateSubmissions;
  final int todayMaterials;

  DashboardData({
    required this.uncompletedTasks,
    required this.absentStudents,
    required this.lateSubmissions,
    required this.todayMaterials,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      uncompletedTasks: json['uncompleted_tasks'],
      absentStudents: json['absent_students'],
      lateSubmissions: json['late_submissions'],
      todayMaterials: json['today_materials'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uncompleted_tasks': uncompletedTasks,
      'absent_students': absentStudents,
      'late_submissions': lateSubmissions,
      'today_materials': todayMaterials,
    };
  }
}
