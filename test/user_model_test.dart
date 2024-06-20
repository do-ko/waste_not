import 'package:flutter_test/flutter_test.dart';
import 'package:waste_not/models/user.dart';

void main() {
  group('UserModel', () {
    test('should create a valid UserModel object from a map', () {
      final userMap = {
        'id': '1',
        'email': 'test@example.com',
        'username': 'TestUser',
      };

      final user = UserModel.fromMap(userMap);

      expect(user.id, '1');
      expect(user.email, 'test@example.com');
      expect(user.username, 'TestUser');
    });

    test('should convert a UserModel object to JSON', () {
      final user = UserModel(
        id: '1',
        email: 'test@example.com',
        username: 'TestUser',
      );

      final userJson = user.toJson();

      expect(userJson['id'], '1');
      expect(userJson['email'], 'test@example.com');
      expect(userJson['username'], 'TestUser');
    });

    test('should create a copy of UserModel with updated fields', () {
      final user = UserModel(
        id: '1',
        email: 'test@example.com',
        username: 'TestUser',
      );

      final updatedUser = user.copyWith(email: 'new@example.com', username: 'NewUser');

      expect(updatedUser.id, '1');
      expect(updatedUser.email, 'new@example.com');
      expect(updatedUser.username, 'NewUser');
    });
  });
}
