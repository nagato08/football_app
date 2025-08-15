import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class TeamMember {
  final String name;
  final String role;
  final Color avatarColor;

  const TeamMember({
    required this.name,
    required this.role,
    this.avatarColor = Colors.blueAccent,
  });
}

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      TeamMember(
        name: 'Nague Justin',
        role: 'Chef de projet / Développeur Flutter',
        avatarColor: Colors.blue.shade700,
      ),
      TeamMember(
        name: 'Kameni Ulrich',
        role: 'Analyste',
        avatarColor: Colors.pink.shade400,
      ),
      TeamMember(
        name: 'Tadjo Nathan',
        role: 'Développeur Flutter',
        avatarColor: Colors.orange.shade600,
      ),
      TeamMember(
        name: 'Miguel Elia',
        role: 'Développeur Flutter',
        avatarColor: Colors.purple.shade500,
      ),
      TeamMember(
        name: 'Ketch Amar',
        role: 'Développeur Flutter',
        avatarColor: Colors.orange.shade600,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Équipe de développement',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryBlue,
        foregroundColor: white,
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: members.length,
          separatorBuilder: (_, __) => const Divider(
            height: 32,
            thickness: 1,
            indent: 72,
            endIndent: 20,
          ),
          itemBuilder: (context, index) {
            final member = members[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: member.avatarColor.withOpacity(0.2),
                radius: 28,
                child: Text(
                  member.name[0],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: member.avatarColor,
                  ),
                ),
              ),
              title: Text(
                member.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  member.role,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            );
          },
        ),
      ),
    );
  }
}