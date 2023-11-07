import 'package:flutter_test/flutter_test.dart';
import 'package:juling_apps/model/model_maintenance.dart';

void main() {
  group('MaintenanceData Tests', () {
    test('Construction should work correctly', () {
      final maintenanceData = MaintenanceData(
        id: '1',
        spesifikasi: ['Spec1', 'Spec2'],
        url: 'image_url',
      );

      expect(maintenanceData.id, '1');
      expect(maintenanceData.spesifikasi, ['Spec1', 'Spec2']);
      expect(maintenanceData.url, 'image_url');
    });

    test('toMap should convert to the correct map', () {
      final maintenanceData = MaintenanceData(
        id: '2',
        spesifikasi: ['Spec3', 'Spec4'],
        url: 'image_url_2',
      );

      final expectedMap = {
        'id': '2',
        'Spesifikasi': ['Spec3', 'Spec4'],
        'Gambar': 'image_url_2',
      };

      expect(maintenanceData.toMap(), expectedMap);
    });
  });
}
