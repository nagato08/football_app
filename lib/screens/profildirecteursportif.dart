import 'package:flutter/material.dart';

class SportsDirectorProfile extends StatefulWidget {
  const SportsDirectorProfile({super.key});

  @override
  _SportsDirectorProfileState createState() => _SportsDirectorProfileState();
}

class _SportsDirectorProfileState extends State<SportsDirectorProfile>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Couleurs du thème
  static const primaryBlue = Color(0xFF3852A4);
  static const accentYellow = Color(0xFFF8D959);
  static const darkBlack = Color(0xFF050505);
  static const pureWhite = Color(0xFFFFFFFF);

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
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [_buildProfileHeader(), _buildTabSection()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: primaryBlue,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [primaryBlue, primaryBlue.withValues(alpha: 0.8)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -50,
                top: -50,
                child: Icon(
                  Icons.sports_soccer,
                  size: 200,
                  color: pureWhite.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ),
        title: Text(
          'Directeur Sportif',
          style: TextStyle(color: pureWhite, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.edit, color: pureWhite),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert, color: pureWhite),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: accentYellow, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: darkBlack.withValues(alpha: 0.2),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 58,
                  backgroundColor: primaryBlue.withValues(alpha: 0.1),
                  child: Icon(Icons.person, size: 60, color: primaryBlue),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: accentYellow,
                    shape: BoxShape.circle,
                    border: Border.all(color: pureWhite, width: 2),
                  ),
                  child: Icon(Icons.verified, color: darkBlack, size: 20),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            'Jean DUPONT',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: darkBlack,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Directeur Sportif',
            style: TextStyle(
              fontSize: 16,
              color: primaryBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('15', 'Années\nd\'expérience'),
              _buildStatCard('8', 'Clubs\ndirigés'),
              _buildStatCard('12', 'Certifications'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: pureWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: darkBlack.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: darkBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: pureWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: darkBlack.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: primaryBlue,
              unselectedLabelColor: darkBlack.withOpacity(0.6),
              indicatorColor: accentYellow,
              indicatorWeight: 3,
              tabs: [
                Tab(icon: Icon(Icons.person), text: 'Profil'),
                Tab(icon: Icon(Icons.work), text: 'Parcours'),
                Tab(icon: Icon(Icons.assignment), text: 'Missions'),
                Tab(icon: Icon(Icons.folder), text: 'Documents'),
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPersonalInfoTab(),
                _buildCareerTab(),
                _buildResponsibilitiesTab(),
                _buildDocumentsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoTab() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Informations Personnelles', [
              _buildInfoRow(Icons.person, 'Nom complet', 'Jean DUPONT'),
              _buildInfoRow(Icons.cake, 'Date de naissance', '15 Mars 1978'),
              _buildInfoRow(Icons.flag, 'Nationalité', 'Française'),
            ]),
            SizedBox(height: 20),
            _buildInfoCard('Coordonnées', [
              _buildInfoRow(
                Icons.location_on,
                'Adresse',
                '123 Av. du Stade, 75016 Paris',
              ),
              _buildInfoRow(Icons.phone, 'Téléphone', '+33 1 23 45 67 89'),
              _buildInfoRow(Icons.email, 'Email', 'j.dupont@club.fr'),
            ]),
            SizedBox(height: 20),
            _buildInfoCard('Diplômes & Certifications', [
              _buildInfoRow(
                Icons.school,
                'Master Management Sportif',
                'INSEP - 2002',
              ),
              _buildInfoRow(Icons.verified, 'Licence UEFA Pro', 'UEFA - 2005'),
              _buildInfoRow(
                Icons.business,
                'MBA Sports Business',
                'CDES - 2008',
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCareerTab() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Parcours Professionnel',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkBlack,
              ),
            ),
            SizedBox(height: 15),
            _buildCareerItem(
              'FC Barcelona',
              'Directeur Sportif',
              '2020 - Présent',
              'Gestion du recrutement et supervision du budget sportif de 150M€',
              true,
            ),
            _buildCareerItem(
              'Manchester United',
              'Directeur Adjoint',
              '2017 - 2020',
              'Assistance à la direction sportive, focus sur le recrutement jeunes',
              false,
            ),
            _buildCareerItem(
              'AC Milan',
              'Responsable Recrutement',
              '2014 - 2017',
              'Coordination des scouts et analyse des joueurs internationaux',
              false,
            ),
            _buildCareerItem(
              'Olympique de Marseille',
              'Scout en Chef',
              '2010 - 2014',
              'Développement du réseau de détection en Europe et Afrique',
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsibilitiesTab() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildResponsibilitySection(
              'Recrutement & Mutations',
              Icons.group_add,
              [
                'Analyse et sélection des cibles de recrutement',
                'Négociation avec les clubs et agents',
                'Validation des profils sportifs et financiers',
                'Supervision des mutations estivales et hivernales',
              ],
            ),
            _buildResponsibilitySection(
              'Gestion Contractuelle',
              Icons.description,
              [
                'Suivi des contrats joueurs et staff',
                'Négociations de prolongations',
                'Gestion des clauses et bonus',
                'Relations avec les instances juridiques',
              ],
            ),
            _buildResponsibilitySection(
              'Budget & Finance',
              Icons.account_balance,
              [
                'Supervision du budget sportif (150M€)',
                'Optimisation de la masse salariale',
                'Respect du Fair-Play Financier',
                'Reporting mensuel à la direction',
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Documents Clés',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkBlack,
              ),
            ),
            SizedBox(height: 15),
            _buildDocumentItem(
              'Contrat de Travail',
              'Contrat principal - Valide jusqu\'en 2026',
              Icons.assignment,
              'PDF',
            ),
            _buildDocumentItem(
              'Feuille de Route 2024',
              'Objectifs et stratégie pour la saison',
              Icons.map,
              'PDF',
            ),
            _buildDocumentItem(
              'Rapport Technique Q1',
              'Analyse performance premier trimestre',
              Icons.analytics,
              'PDF',
            ),
            _buildDocumentItem(
              'Budget Prévisionnel',
              'Prévisions mercato été 2024',
              Icons.account_balance_wallet,
              'XLSX',
            ),
            _buildDocumentItem(
              'Certifications UEFA',
              'Licences et formations continues',
              Icons.verified,
              'PDF',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryBlue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 20, color: primaryBlue),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: darkBlack.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(color: darkBlack, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerItem(
    String club,
    String position,
    String period,
    String description,
    bool isCurrent,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isCurrent ? accentYellow.withOpacity(0.1) : pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrent ? accentYellow : primaryBlue.withOpacity(0.2),
          width: isCurrent ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  club,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkBlack,
                  ),
                ),
              ),
              if (isCurrent)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentYellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Actuel',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: darkBlack,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            '$position • $period',
            style: TextStyle(color: primaryBlue, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: darkBlack.withOpacity(0.7), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsibilitySection(
    String title,
    IconData icon,
    List<String> responsibilities,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryBlue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: primaryBlue, size: 20),
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkBlack,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ...responsibilities.map(
            (resp) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: accentYellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      resp,
                      style: TextStyle(
                        color: darkBlack.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(
    String title,
    String description,
    IconData icon,
    String type,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryBlue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: primaryBlue, size: 24),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkBlack,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: darkBlack.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accentYellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              type,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: darkBlack,
              ),
            ),
          ),
          SizedBox(width: 10),
          Icon(Icons.download, color: primaryBlue, size: 20),
        ],
      ),
    );
  }
}
