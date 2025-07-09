class DashboardCountResponse {
  final bool success;
  final Map<String, Map<String, Map<String, DashboardCountDetail>>> data;

  DashboardCountResponse({
    required this.success,
    required this.data,
  });

  factory DashboardCountResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] as Map<String, dynamic>;

    // parsing nested maps
    final parsedData = rawData.map((hari, kelasMap) {
      final kelasParsed = (kelasMap as Map<String, dynamic>).map((kelas, mapelMap) {
        final mapelParsed = (mapelMap as Map<String, dynamic>).map((mapel, detailMap) {
          return MapEntry(mapel, DashboardCountDetail.fromJson(detailMap));
        });
        return MapEntry(kelas, mapelParsed);
      });
      return MapEntry(hari, kelasParsed);
    });

    return DashboardCountResponse(
      success: json['success'],
      data: parsedData,
    );
  }
}

class DashboardCountDetail {
  final int uncompletedTasks;
  final int absentStudents;
  final int lateSubmissions;
  final int todayMaterials;
  final List<UpcomingTask> upcomingTasks;

  DashboardCountDetail({
    required this.uncompletedTasks,
    required this.absentStudents,
    required this.lateSubmissions,
    required this.todayMaterials,
    required this.upcomingTasks,
  });

  factory DashboardCountDetail.fromJson(Map<String, dynamic> json) {
    return DashboardCountDetail(
      uncompletedTasks: json['uncompleted_tasks'],
      absentStudents: json['absent_students'],
      lateSubmissions: json['late_submissions'],
      todayMaterials: json['today_materials'],
      upcomingTasks: List<UpcomingTask>.from(
        (json['upcoming_tasks'] as List).map((e) => UpcomingTask.fromJson(e)),
      ),
    );
  }
}

class UpcomingTask {
  final String tugasId;
  final String judul;
  final DateTime tenggatKumpul;
  final String namaMapel;
  final String namaKelas;

  UpcomingTask({
    required this.tugasId,
    required this.judul,
    required this.tenggatKumpul,
    required this.namaMapel,
    required this.namaKelas,
  });

  factory UpcomingTask.fromJson(Map<String, dynamic> json) {
    return UpcomingTask(
      tugasId: json['tugas_id'],
      judul: json['judul'],
      tenggatKumpul: DateTime.parse(json['tenggat_kumpul']),
      namaMapel: json['nama_mapel'],
      namaKelas: json['nama_kelas'],
    );
  }
}

class DashboardGuruData {
  final int uncompletedTasks;
  final int absentStudents;
  final int lateSubmissions;
  final int todayMaterials;

  DashboardGuruData({
    required this.uncompletedTasks,
    required this.absentStudents,
    required this.lateSubmissions,
    required this.todayMaterials,
  });

  factory DashboardGuruData.fromJson(Map<String, dynamic> json) {
    return DashboardGuruData(
      uncompletedTasks: json['uncompleted_tasks'],
      absentStudents: json['absent_students'],
      lateSubmissions: json['late_submissions'],
      todayMaterials: json['today_materials'],
    );
  }
}

