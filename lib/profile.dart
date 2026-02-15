import 'package:flutter/material.dart';
import 'package:project/login.dart';

class ProfilePage extends StatefulWidget {
  final String emailid;
  final String username;
  final Function(String) onUsernameChanged;
  final String photo;
  final Function(String) onPhotoChanged;
  final String password;
  final Function(String) onPasswordChanged;
  const ProfilePage({
    super.key,
    required this.emailid,
    required this.username,
    required this.onUsernameChanged,
    required this.photo,
    required this.onPhotoChanged,
    required this.password,
    required this.onPasswordChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String current_username = "DefaultUser";
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void togglePhoto() {
    String nextPhoto = (widget.photo == 'images/guest.png')
        ? 'images/superhero.jpg'
        : 'images/guest.png';

    widget.onPhotoChanged(nextPhoto);
  }

  void _showEditDialog() {
    _usernameController.text = widget.username;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Username"),
          content: TextField(
            controller: _usernameController,
            maxLength: 15,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(164, 158, 158, 158),
                hintText: "Enter new username"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL"),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onUsernameChanged(_usernameController.text);
                Navigator.pop(context);
              },
              child: const Text("SAVE"),
            ),
          ],
        );
      },
    );
  }

  void _showPasswordDialog() {
    _passwordController.text = widget.password;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Password"),
        content: TextField(
          controller: _passwordController,
          obscureText: false,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color.fromARGB(164, 158, 158, 158),
              hintText: "Enter new password"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL")),
          ElevatedButton(
            onPressed: () {
              widget.onPasswordChanged(_passwordController.text);
              Navigator.pop(context);
            },
            child: const Text("SAVE"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.green,
            width: 3,
          ),
        ),
        title: Center(
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
            height: 35,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 85,
              child: CircleAvatar(
                foregroundImage: AssetImage(widget.photo),
                radius: 75,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              "Email: ${widget.emailid}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Password: ${widget.password}",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _showPasswordDialog,
                  icon: const Icon(Icons.edit, size: 20, color: Colors.green),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Username: ${widget.username}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _showEditDialog,
                  icon: const Icon(Icons.edit, size: 20, color: Colors.green),
                  tooltip: "Edit Username",
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('LOGOUT',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            togglePhoto();
          },
          child: const Column(
            children: [
              Icon(Icons.photo_camera_front_outlined),
              Text(
                "Toggle Pic",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              )
            ],
          )),
    );
  }
}
