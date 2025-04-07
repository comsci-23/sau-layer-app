import 'package:flutter_test/flutter_test.dart';
import 'package:sau_layer_app/presentation/model/nasa_history_model.dart';

void main() {
  group('NasaHistoryModel', () {
    test('fromJson returns a valid model', () {
      final json = {
        'data': [
          {'nasa_id': '123', 'title': 'Test Title', 'description': 'Some Desc'}
        ],
        'links': [
          {'href': 'http://example.com/image.jpg'}
        ],
      };
      final model = NasaHistoryModel.fromJson(json);
      expect(model.id, '123');
      expect(model.title, 'Test Title');
      expect(model.description, 'Some Desc');
      expect(model.imageUrl, 'http://example.com/image.jpg');
    });

    test('fromJson handles empty links', () {
      final json = {
        'data': [
          {'nasa_id': '987', 'title': 'No Links', 'description': 'No Links Desc'}
        ],
        'links': []
      };
      final model = NasaHistoryModel.fromJson(json);
      expect(model.imageUrl, '');
    });
  });

  group('NasaHistoryListModel', () {
    test('fromJson returns a valid list', () {
      final jsonList = [
        {
          'data': [
            {'nasa_id': '1', 'title': 'Title1', 'description': 'Desc1'}
          ],
          'links': [
            {'href': 'http://example.com/1.jpg'}
          ],
        },
        {
          'data': [
            {'nasa_id': '2', 'title': 'Title2', 'description': 'Desc2'}
          ],
          'links': [
            {'href': 'http://example.com/2.jpg'}
          ],
        }
      ];

      final listModel = NasaHistoryListModel.fromJson(jsonList);
      expect(listModel.items.length, 2);
      expect(listModel.items[0].id, '1');
      expect(listModel.items[1].title, 'Title2');
    });
  });
}