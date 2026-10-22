import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // State sederhana untuk mengelola status login/favorite
  bool _isLoggedIn = true;
  String _userName = 'Vincent';
  String _userEmail = 'vincent@example.com';
  int _favoriteCount = 3;

  void _toggleSignIn() {
    setState(() {
      _isLoggedIn = !_isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigasi ke pengaturan jika ada
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header Profil (Foto, Nama, Email)
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade300,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: 'https://via.placeholder.com/150',
                              placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.person, size: 50),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (_isLoggedIn)
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt,
                                  size: 18, color: Colors.white),
                              onPressed: () {},
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _isLoggedIn ? _userName : 'Pengguna Tamu',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isLoggedIn ? _userEmail : 'Silakan masuk ke akun Anda',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Divider(),

              // Informasi & Statistik Ringkas
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red),
                title: const Text('Candi Favorit'),
                trailing: Text(
                  '$_favoriteCount',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onTap: () {},
              ),

              const Divider(),

              // Aksi / Tombol Auth
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _toggleSignIn,
                  icon: Icon(_isLoggedIn ? Icons.logout : Icons.login),
                  label: Text(_isLoggedIn ? 'Keluar' : 'Masuk'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _isLoggedIn ? Colors.red.shade400 : Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}