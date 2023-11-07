class MaintenanceData {
  final String id;
  final List<String> spesifikasi;
  final String url;

  MaintenanceData({required this.id, required this.spesifikasi,required this.url});

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'Spesifikasi': spesifikasi,
      'Gambar':url
    };
  }
}