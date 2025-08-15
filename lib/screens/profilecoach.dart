import 'package:flutter/material.dart';

class CoachProfilePage extends StatefulWidget {
  const CoachProfilePage({super.key});

  @override
  _CoachProfilePageState createState() => _CoachProfilePageState();
}

class _CoachProfilePageState extends State<CoachProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Couleurs de l'application
  static const Color primaryBlue = Color(0xFF3852A4);
  static const Color accentYellow = Color(0xFFF8D959);
  static const Color darkColor = Color(0xFF050505);
  static const Color whiteColor = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildProfileHeader(),
                _buildTabSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      backgroundColor: primaryBlue,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Profil Coach',
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primaryBlue,
                primaryBlue.withOpacity(0.8),
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.sports_soccer,
              size: 80,
              color: accentYellow,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.edit, color: whiteColor),
          onPressed: () {
            // Action d'édition
          },
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Photo de profil
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accentYellow, width: 4),
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 56,
              backgroundColor: primaryBlue.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: 60,
                color: primaryBlue,
              ),
            ),
          ),
          SizedBox(height: 16),
          // Nom et titre
          Text(
            'Jean MBARGA',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: accentYellow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Entraîneur Principal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: darkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Column(
      children: [
        Container(
          color: whiteColor,
          child: TabBar(
            controller: _tabController,
            labelColor: primaryBlue,
            unselectedLabelColor: darkColor.withOpacity(0.6),
            indicatorColor: accentYellow,
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'Infos'),
              Tab(text: 'Expérience'),
              Tab(text: 'Contrat'),
              Tab(text: 'Historique'),
            ],
          ),
        ),
        SizedBox(
          height: 600,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildPersonalInfoTab(),
              _buildExperienceTab(),
              _buildContractTab(),
              _buildHistoryTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Informations Personnelles'),
          _buildInfoCard([
            _buildInfoRow(Icons.person, 'Nom complet', 'Jean Baptiste MBARGA'),
            _buildInfoRow(Icons.cake, 'Date de naissance', '15 Mars 1978'),
            _buildInfoRow(Icons.flag, 'Nationalité', 'Camerounaise'),
            _buildInfoRow(Icons.location_on, 'Adresse', 'Quartier Bonanjo, Douala'),
            _buildInfoRow(Icons.phone, 'Téléphone', '+237 6XX XX XX XX'),
            _buildInfoRow(Icons.email, 'Email', 'j.mbarga@coach.cm'),
          ]),
          SizedBox(height: 20),
          _buildSectionTitle('Diplômes et Licences'),
          _buildInfoCard([
            _buildCertificationRow('Licence CAF A', 'Valide jusqu\'en 2026', true),
            _buildCertificationRow('Licence FECAFOOT', 'Valide jusqu\'en 2025', true),
            _buildCertificationRow('Formation Médicale', 'Premiers secours', false),
          ]),
        ],
      ),
    );
  }

  Widget _buildExperienceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Expériences Passées'),
          _buildExperienceCard(
            'Union Sportive de Douala',
            '2020 - 2024',
            'Senior - Division 1',
            '3ème place championnat 2023',
            Icons.emoji_events,
            Colors.orange,
          ),
          _buildExperienceCard(
            'FC Bamenda',
            '2018 - 2020',
            'Senior - Division 2',
            'Promotion en Division 1',
            Icons.trending_up,
            Colors.green,
          ),
          _buildExperienceCard(
            'Académie Lions',
            '2015 - 2018',
            'Jeunes U-17',
            'Formation de 15 joueurs professionnels',
            Icons.school,
            primaryBlue,
          ),
          SizedBox(height: 20),
          _buildSectionTitle('Fonctions Techniques'),
          _buildInfoCard([
            _buildFunctionRow('Planification des entraînements'),
            _buildFunctionRow('Animation des séances'),
            _buildFunctionRow('Gestion composition équipe'),
            _buildFunctionRow('Sélection des joueurs'),
            _buildFunctionRow('Suivi des performances'),
            _buildFunctionRow('Rapports post-match'),
          ]),
        ],
      ),
    );
  }

  Widget _buildContractTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Détails du Contrat'),
          _buildInfoCard([
            _buildInfoRow(Icons.work, 'Statut', 'Salarié'),
            _buildInfoRow(Icons.calendar_today, 'Date de début', '01 Janvier 2024'),
            _buildInfoRow(Icons.event, 'Date de fin', '31 Décembre 2026'),
            _buildInfoRow(Icons.attach_money, 'Salaire mensuel', '800,000 FCFA'),
          ]),
          SizedBox(height: 20),
          _buildSectionTitle('Objectifs Contractuels'),
          _buildObjectiveCard('Top 5 du championnat', 'En cours', Colors.orange),
          _buildObjectiveCard('Formation 5 jeunes talents', 'Réalisé', Colors.green),
          _buildObjectiveCard('Qualification Coupe CAF', 'À venir', Colors.blue),
          SizedBox(height: 20),
          _buildSectionTitle('Évaluations'),
          _buildEvaluationCard('Performance générale', 8.5),
          _buildEvaluationCard('Gestion d\'équipe', 9.0),
          _buildEvaluationCard('Développement joueurs', 8.8),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Historique des Compositions'),
          _buildMatchHistoryCard(
            'vs FC Yaoundé',
            '4-3-3',
            'Victoire 2-1',
            '28 Juillet 2024',
          ),
          _buildMatchHistoryCard(
            'vs Coton Sport',
            '3-5-2',
            'Défaite 0-1',
            '21 Juillet 2024',
          ),
          _buildMatchHistoryCard(
            'vs Canon Yaoundé',
            '4-4-2',
            'Nul 1-1',
            '14 Juillet 2024',
          ),
          SizedBox(height: 20),
          _buildSectionTitle('Évaluations des Séances'),
          _buildSessionCard('Séance Physique', '26 Juillet', 9.2),
          _buildSessionCard('Tactique Défensive', '24 Juillet', 8.8),
          _buildSessionCard('Jeu de Possession', '22 Juillet', 8.5),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryBlue,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: darkColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: primaryBlue, size: 20),
          SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: darkColor.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: darkColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationRow(String title, String validity, bool isValid) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            Icons.verified,
            color: isValid ? Colors.green : Colors.orange,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: darkColor,
                  ),
                ),
                Text(
                  validity,
                  style: TextStyle(
                    color: darkColor.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(String club, String period, String category,
      String achievement, IconData icon, Color iconColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: iconColor, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: darkColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  club,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkColor,
                  ),
                ),
                Text(
                  '$period • $category',
                  style: TextStyle(
                    color: darkColor.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  achievement,
                  style: TextStyle(
                    color: iconColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionRow(String function) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 18),
          SizedBox(width: 12),
          Text(
            function,
            style: TextStyle(
              color: darkColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObjectiveCard(String objective, String status, Color statusColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: darkColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              objective,
              style: TextStyle(
                color: darkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvaluationCard(String criterion, double score) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: darkColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            criterion,
            style: TextStyle(
              color: darkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Text(
                '$score/10',
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 8),
              Container(
                width: 60,
                height: 8,
                decoration: BoxDecoration(
                  color: darkColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: score / 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: accentYellow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchHistoryCard(String opponent, String formation,
      String result, String date) {
    Color resultColor = result.contains('Victoire')
        ? Colors.green
        : result.contains('Défaite')
        ? Colors.red
        : Colors.orange;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: darkColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                opponent,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: darkColor.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Formation: $formation',
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: resultColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  result,
                  style: TextStyle(
                    color: resultColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard(String type, String date, double rating) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: darkColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: darkColor.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, color: accentYellow, size: 20),
              SizedBox(width: 4),
              Text(
                '$rating/10',
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}