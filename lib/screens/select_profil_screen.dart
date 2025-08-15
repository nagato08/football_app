import 'package:flutter/material.dart';
import 'package:football/screens/profilejoueur.dart';
import 'package:football/screens/register_screen.dart';
import 'dashboard.dart';
import 'dashboardadmin.dart';
import 'dashboardcoach.dart';
import 'dashboardjoueur.dart';
import 'dashboardpresident.dart';
import 'login_screen.dart';

class ProfileSelectionPage extends StatefulWidget {
  const ProfileSelectionPage({super.key});

  @override
  State<ProfileSelectionPage> createState() => _ProfileSelectionPageState();
}

class _ProfileSelectionPageState extends State<ProfileSelectionPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Couleurs du thème
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color accentYellow = Color(0xFFFCD34D);
  static const Color darkColor = Color(0xFF1F2937);
  static const Color lightColor = Color(0xFFF9FAFB);

  // Liste des profils disponibles
  final List<ProfileType> profiles = [
    ProfileType(
      id: 'player',
      title: 'Joueur',
      description: 'Inscrivez-vous en tant que joueur de l\'équipe',
      icon: Icons.sports_soccer,
      color: primaryBlue,
    ),
    ProfileType(
      id: 'coach',
      title: 'Coach',
      description: 'Gérez votre équipe et les entraînements',
      icon: Icons.sports,
      color: Colors.green[700]!,
    ),
    ProfileType(
      id: 'president',
      title: 'Président du Club',
      description: 'Administration complète du club',
      icon: Icons.admin_panel_settings,
      color: Colors.purple[700]!,
    ),
    ProfileType(
      id: 'sporting_director',
      title: 'Directeur Sportif',
      description: 'Supervision des aspects sportifs du club',
      icon: Icons.business_center,
      color: Colors.orange[700]!,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryBlue,
              primaryBlue.withValues(alpha: 0.8),
              darkColor.withValues(alpha: 0.9),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(child: _buildProfileGrid()),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Logo ou icône du club
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: accentYellow,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.sports_soccer,

              size: 40,
              color: primaryBlue,
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Choisissez votre profil',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            'Sélectionnez le type de compte qui correspond à votre rôle dans le club',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          return _buildProfileCard(profiles[index], index);
        },
      ),
    );
  }

  Widget _buildProfileCard(ProfileType profile, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: GestureDetector(
            onTap: () => _selectProfile(profile),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // En-tête avec icône et couleur
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: profile.color,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Icon(profile.icon, size: 30, color: Colors.white),
                    ),
                  ),

                  // Contenu de la carte
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              profile.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: darkColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            profile.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            'Vous pourrez modifier votre profil plus tard dans les paramètres',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LoginPage(), // Votre page d'inscription
                ),
              );
            },
            child: const Text(
              'Retour à la connexion',
              style: TextStyle(
                color: accentYellow,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectProfile(ProfileType profile) {
    // Vérifier si le profil est disponible (seul "Joueur" est disponible pour l'instant)

    // Animation de sélection pour le profil joueur
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(profile.icon, size: 60, color: profile.color),
              const SizedBox(height: 16),
              Text(
                'Profil sélectionné',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Vous avez choisi : ${profile.title}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );

    // Simuler un délai puis rediriger
    final currentContext = context;
    Future.delayed(const Duration(seconds: 2), () {
      if (currentContext.mounted) {
        Navigator.pop(currentContext); // Fermer le dialog
        _navigateToRegistrationForm(profile, currentContext);
      }
    });
  }

  void _showUnavailableProfileMessage(ProfileType profile) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icône d'alerte stylisée
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orange, width: 3),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 40,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 20),

              // Titre du message
              Text(
                'Profil pas encore disponible',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Message descriptif
              Text(
                'Le profil "${profile.title}" n\'est pas encore disponible dans cette version de l\'application.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                'Veuillez sélectionner le profil "Joueur" pour continuer.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Bouton de fermeture
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Compris',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToRegistrationForm(ProfileType profile, BuildContext context) {
    Widget destinationPage;

    switch (profile.id) {
      case 'player':
        destinationPage = const PlayerHomePage();
        break;
      case 'coach':
        destinationPage = const CoachHomePage();
        break;
      case 'president':
        destinationPage = const DashboardPresident();
        break;
      case 'sporting_director':
        destinationPage = const dashboardadmin();
        break;
      default:
        destinationPage = const RegistrationPage();
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            destinationPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

// Classe pour définir un type de profil
class ProfileType {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  ProfileType({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
