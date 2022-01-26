import 'package:encrypt/encrypt.dart';

class EncryptUtil{

 /// Encryption key to use in encrypting and decrypting text notes
  static final _ENCRYPTION_KEY = 'b4CplJtMrcfEg7LJhL2dZyEwgvHP/75w';

/// Encrypt a plain text note and serialize it as a base-64 string
  static String  encryptNote(plainNote) {
    final key = Key.fromUtf8(_ENCRYPTION_KEY);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encryptedNote = encrypter.encrypt(plainNote, iv: iv);
    return encryptedNote.base64;
  }

  /// Decrypt an encrypted text note serialized as a base-64 string
  static String decryptNote(base64Note) {
    try {
      final key = Key.fromUtf8(_ENCRYPTION_KEY);
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      final encryptedNote = Encrypted.fromBase64(base64Note);
      final decryptedNote = encrypter.decrypt(encryptedNote, iv: iv);
      return decryptedNote;
    } catch (e) {
      return base64Note;
    }
  }

}
