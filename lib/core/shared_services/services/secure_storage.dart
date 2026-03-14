// Provides an interface to store value with encryption
abstract class SecureStorage {
  // Reads a value saved wih key from storage
  Future<String?> read(String key);

  // Writes value to storage with key
  Future<void> write({
    required String key,
    required String value,
  });

  // Deletes a value saved with key from storage
  Future<bool> delete(String key);
}
