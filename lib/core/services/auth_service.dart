import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt_lib;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // AES Encryption setup (Using a static key for demonstration purposes. In production, this should be fetched securely)
  final _encrypter = encrypt_lib.Encrypter(encrypt_lib.AES(encrypt_lib.Key.fromUtf8('my_32_character_ultra_secure_key')));
  final _iv = encrypt_lib.IV.fromLength(16);

  // Stream of auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign up with email, password, and role
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await credential.user?.sendEmailVerification();

      // Encrypt sensitive data
      final encryptedPhone = _encrypter.encrypt(phone, iv: _iv).base64;

      // Save user details to Firestore
      if (credential.user != null) {
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'id': credential.user!.uid,
          'email': email,
          'name': name,
          'phone': encryptedPhone, // Saved as encrypted text
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });
        
        // Save to secure local storage
        await _secureStorage.write(key: 'uid', value: credential.user!.uid);
        await _secureStorage.write(key: 'role', value: role);
      }

      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Login with email and password
  Future<UserCredential> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Fetch role and save securely
      if (credential.user != null) {
        final role = await getUserRole(credential.user!.uid);
        await _secureStorage.write(key: 'uid', value: credential.user!.uid);
        if (role != null) await _secureStorage.write(key: 'role', value: role);
      }
      
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Get user role from Firestore
  Future<String?> getUserRole(String uid) async {
    try {
      // Check secure storage first
      String? localRole = await _secureStorage.read(key: 'role');
      if (localRole != null) return localRole;

      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        final role = doc.data()!['role'] as String?;
        if (role != null) await _secureStorage.write(key: 'role', value: role);
        return role;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _secureStorage.deleteAll();
    await _auth.signOut();
  }
}
