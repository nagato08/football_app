import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'dashboardadmin.dart';
import 'dashboardcoach.dart';
import 'dashboardjoueur.dart';

// Modèles simulés pour le homePage
enum UserRole { player, coach, president, sportsDirector, technicalStaff }

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final UserRole role;
  final String? phone;
  final Map<String, dynamic>? roleSpecificData;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.email,
    this.phone,
    this.roleSpecificData,
  });

  String get fullName => '$firstName $lastName';
}

// Classes simulées pour les pages
class FootballApp extends StatelessWidget {
  const FootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPage();
  }
}

class PlayerProfilePage extends StatelessWidget {
  const PlayerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Player Profile Page')));
  }
}

class CoachHomePage extends StatelessWidget {
  const CoachHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Coach Home Page')));
  }
}

class CoachProfilePage extends StatelessWidget {
  const CoachProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Coach Profile Page')));
  }
}

class SportsDirectorProfile extends StatelessWidget {
  const SportsDirectorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Sports Director Profile Page')),
    );
  }
}

class RoleBasedHomePage extends StatefulWidget {
  const RoleBasedHomePage({super.key});

  @override
  State<RoleBasedHomePage> createState() => RoleBasedHomePageState();
}

class RoleBasedHomePageState extends State<RoleBasedHomePage> {
  int _currentIndex = 0;
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    // Utiliser un utilisateur simulé pour le moment
    _currentUser = _createDefaultPlayer();
  }

  // Utilisateur par défaut pour les tests
  User _createDefaultPlayer() {
    return User(
      id: 'default_player_1',
      firstName: 'president',
      lastName: 'Test',
      role: UserRole.president,
      email: 'president@club.com',
      phone: '+1234567890',
      roleSpecificData: {
        'position': 'Attaquant',
        'number': '10',
        'foot': 'Droit',
      },
    );
  }

  // Pages par défaut
  final List<Widget> _playerPages = [
    const FootballApp(),
    const PlayerProfilePage(),
  ];

  final List<Widget> _coachPages = [
    const CoachHomePage(),
    const CoachProfilePage(),
  ];

  final List<Widget> _adminPages = [
    const dashboardadmin(),
    const SportsDirectorProfile(),
  ];

  List<Widget> get _pages {
    if (_currentUser == null) {
      return [const Center(child: Text('No user logged in'))];
    }

    switch (_currentUser!.role) {
      case UserRole.player:
        return _playerPages;
      case UserRole.coach:
        return _coachPages;
      case UserRole.president:
      case UserRole.sportsDirector:
        return _adminPages;
      case UserRole.technicalStaff:
        return _coachPages;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Please log in',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      );
    }

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(
          context,
        ).colorScheme.onSurface.withOpacity(0.6),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          if (_currentUser!.role != UserRole.player)
            const BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Team',
            ),
          if (_currentUser!.role == UserRole.coach ||
              _currentUser!.role == UserRole.sportsDirector)
            const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Schedule',
            ),
          if (_currentUser!.role == UserRole.president ||
              _currentUser!.role == UserRole.sportsDirector)
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Admin',
            ),
        ],
      ),
    );
  }
}
