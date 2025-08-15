import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MedicalDashboard extends StatefulWidget {
  @override
  _MedicalDashboardState createState() => _MedicalDashboardState();
}

class _MedicalDashboardState extends State<MedicalDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedPlayer = 'Karim Benzema';
  String selectedInjuryType = 'Musculaire';

  // Couleurs du thème
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color accentYellow = Color(0xFFFBBF24);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF1F2937);
  static const Color lightGray = Color(0xFFF3F4F6);
  static const Color dangerRed = Color(0xFFEF4444);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      appBar: AppBar(
        title: Text(
          'Tableau de Bord Médical',
          style: TextStyle(
            color: backgroundWhite,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: primaryBlue,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.medical_services, color: backgroundWhite),
            onPressed: () {
              // Action pour urgence médicale
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: accentYellow,
          labelColor: accentYellow,
          unselectedLabelColor: backgroundWhite.withOpacity(0.7),
          tabs: [
            Tab(icon: Icon(Icons.dashboard), text: 'État Général'),
            Tab(icon: Icon(Icons.person), text: 'Dossier Médical'),
            Tab(icon: Icon(Icons.healing), text: 'Blessures'),
            Tab(icon: Icon(Icons.history), text: 'Historique'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGeneralHealthTab(),
          _buildMedicalRecordTab(),
          _buildInjuryManagementTab(),
          _buildMedicalHistoryTab(),
        ],
      ),
    );
  }

  // Onglet État de santé général
  Widget _buildGeneralHealthTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistiques générales de santé
          Row(
            children: [
              Expanded(
                child: _buildHealthStatCard(
                  'Joueurs Aptes',
                  '18',
                  '/ 22',
                  Icons.check_circle,
                  successGreen,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildHealthStatCard(
                  'Blessés',
                  '3',
                  '/ 22',
                  Icons.local_hospital,
                  dangerRed,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildHealthStatCard(
                  'En Récupération',
                  '1',
                  '/ 22',
                  Icons.trending_up,
                  warningOrange,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildHealthStatCard(
                  'Visites Médicales',
                  '5',
                  'cette semaine',
                  Icons.medical_services,
                  primaryBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Graphique de répartition des états de santé
          Container(
            height: 300,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Répartition État de Santé',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: 18,
                          title: '82%',
                          color: successGreen,
                          radius: 60,
                          titleStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: backgroundWhite,
                          ),
                        ),
                        PieChartSectionData(
                          value: 3,
                          title: '14%',
                          color: dangerRed,
                          radius: 60,
                          titleStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: backgroundWhite,
                          ),
                        ),
                        PieChartSectionData(
                          value: 1,
                          title: '4%',
                          color: warningOrange,
                          radius: 60,
                          titleStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: backgroundWhite,
                          ),
                        ),
                      ],
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegendItem('Aptes', successGreen),
                    _buildLegendItem('Blessés', dangerRed),
                    _buildLegendItem('Récupération', warningOrange),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Alertes médicales urgentes
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: warningOrange, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Alertes Médicales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildMedicalAlert(
                  'Kylian Mbappé',
                  'Blessure musculaire - Retour prévu dans 2 semaines',
                  dangerRed,
                  Icons.local_hospital,
                ),
                _buildMedicalAlert(
                  'Antoine Griezmann',
                  'Visite de contrôle programmée demain',
                  warningOrange,
                  Icons.schedule,
                ),
                _buildMedicalAlert(
                  'Paul Pogba',
                  'Fin de rééducation - Reprise autorisée',
                  successGreen,
                  Icons.check_circle,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Calendrier des visites médicales
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
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
                      'Prochaines Visites',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textBlack,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Voir tout',
                        style: TextStyle(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildUpcomingVisit(
                  '03/08',
                  'Antoine Griezmann',
                  'Contrôle genou',
                ),
                _buildUpcomingVisit('05/08', 'Karim Benzema', 'Bilan sanguin'),
                _buildUpcomingVisit('07/08', 'Paul Pogba', 'Suivi rééducation'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Onglet Dossier Médical Joueur
  Widget _buildMedicalRecordTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Sélection du joueur
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: primaryBlue),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedPlayer,
                isExpanded: true,
                items:
                    [
                      'Karim Benzema',
                      'Kylian Mbappé',
                      'Antoine Griezmann',
                      'Paul Pogba',
                      'N\'Golo Kanté',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPlayer = newValue!;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 24),

          // Informations personnelles et photo
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: primaryBlue,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: backgroundWhite,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedPlayer,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textBlack,
                            ),
                          ),
                          SizedBox(height: 8),
                          _buildInfoRow('Âge', '35 ans'),
                          _buildInfoRow('Taille', '185 cm'),
                          _buildInfoRow('Poids', '81 kg'),
                          _buildInfoRow('Groupe sanguin', 'O+'),
                          _buildInfoRow('Poste', 'Attaquant'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: successGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: successGreen.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: successGreen),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Statut Médical: APTE À JOUER',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Examens médicaux récents
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Examens Médicaux Récents',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                _buildMedicalExam(
                  'Bilan sanguin complet',
                  '15/07/2025',
                  'Normal',
                  successGreen,
                ),
                _buildMedicalExam(
                  'ECG de repos',
                  '15/07/2025',
                  'Normal',
                  successGreen,
                ),
                _buildMedicalExam(
                  'Test d\'effort',
                  '10/07/2025',
                  'Excellent',
                  successGreen,
                ),
                _buildMedicalExam(
                  'Échographie genou',
                  '05/07/2025',
                  'À surveiller',
                  warningOrange,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Vaccinations et allergies
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: backgroundWhite,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vaccinations',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textBlack,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildVaccination('COVID-19', '15/03/2025', true),
                      _buildVaccination('Tétanos', '10/01/2024', true),
                      _buildVaccination('Grippe', '15/10/2024', false),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: backgroundWhite,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Allergies',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textBlack,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildAllergy('Pollen de graminées', 'Modérée'),
                      _buildAllergy('Ibuprofen', 'Sévère'),
                      SizedBox(height: 8),
                      Text(
                        'Aucune allergie alimentaire connue',
                        style: TextStyle(
                          fontSize: 12,
                          color: textBlack.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Médicaments actuels
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Médicaments Actuels',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                _buildMedication(
                  'Complément Vitamine D',
                  '1000 UI/jour',
                  'Préventif',
                ),
                _buildMedication('Omega-3', '2 capsules/jour', 'Récupération'),
                SizedBox(height: 12),
                Center(
                  child: Text(
                    'Aucun traitement médical en cours',
                    style: TextStyle(
                      fontSize: 14,
                      color: successGreen,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Onglet Gestion des Blessures
  Widget _buildInjuryManagementTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Formulaire d'enregistrement de blessure
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nouvelle Blessure',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 20),

                // Sélection joueur et type de blessure
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Joueur',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue),
                          ),
                        ),
                        value: selectedPlayer,
                        items:
                            [
                              'Karim Benzema',
                              'Kylian Mbappé',
                              'Antoine Griezmann',
                              'Paul Pogba',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPlayer = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Type de blessure',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue),
                          ),
                        ),
                        value: selectedInjuryType,
                        items:
                            [
                              'Musculaire',
                              'Articulaire',
                              'Ligamentaire',
                              'Osseuse',
                              'Contusion',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedInjuryType = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Zone corporelle et gravité
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Zone corporelle',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Gravité',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue),
                          ),
                        ),
                        items: ['Légère', 'Modérée', 'Sévère', 'Très sévère']
                            .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            })
                            .toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Date et durée estimée
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Date de blessure',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue),
                          ),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Durée estimée (jours)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Description
                TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description détaillée',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: primaryBlue),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Enregistrer la blessure
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: backgroundWhite,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Enregistrer la Blessure',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Liste des blessures actives
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Blessures Actives',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                _buildActiveInjury(
                  'Kylian Mbappé',
                  'Élongation ischio-jambiers',
                  'Modérée',
                  '8 jours restants',
                  0.6,
                ),
                _buildActiveInjury(
                  'Paul Pogba',
                  'Entorse cheville',
                  'Légère',
                  '3 jours restants',
                  0.8,
                ),
                _buildActiveInjury(
                  'Antoine Griezmann',
                  'Contusion genou',
                  'Légère',
                  '1 jour restant',
                  0.95,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Statistiques des blessures
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Statistiques des Blessures',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildInjuryStatCard(
                        'Total Blessures',
                        '12',
                        'cette saison',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildInjuryStatCard(
                        'Temps Perdu',
                        '245',
                        'jours joueur',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildInjuryStatCard(
                        'Moyenne Récupération',
                        '18',
                        'jours',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildInjuryStatCard(
                        'Récurrence',
                        '2.3',
                        'blessures/joueur',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Onglet Historique Médical
  Widget _buildMedicalHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filtres de recherche
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filtres de Recherche',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Rechercher un joueur',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue),
                          ),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Période',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue),
                          ),
                        ),
                        items:
                            [
                              'Cette saison',
                              'Dernière saison',
                              '2 dernières saisons',
                              'Tout l\'historique',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Graphique d'évolution des blessures
          Container(
            height: 300,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Évolution des Blessures (6 derniers mois)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 3),
                            FlSpot(1, 2),
                            FlSpot(2, 4),
                            FlSpot(3, 1),
                            FlSpot(4, 3),
                            FlSpot(5, 2),
                          ],
                          isCurved: true,
                          color: primaryBlue,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Historique détaillé des blessures
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Historique Détaillé des Blessures',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                _buildHistoryInjury(
                  'Kylian Mbappé',
                  'Élongation ischio-jambiers',
                  '15/07/2025',
                  '22/07/2025',
                  '7 jours',
                  'Modérée',
                ),
                _buildHistoryInjury(
                  'Paul Pogba',
                  'Entorse cheville',
                  '10/07/2025',
                  '25/07/2025',
                  '15 jours',
                  'Légère',
                ),
                _buildHistoryInjury(
                  'Antoine Griezmann',
                  'Contusion genou',
                  '05/07/2025',
                  '08/07/2025',
                  '3 jours',
                  'Légère',
                ),
                _buildHistoryInjury(
                  'Karim Benzema',
                  'Blessure musculaire',
                  '01/06/2025',
                  '15/06/2025',
                  '14 jours',
                  'Modérée',
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Statistiques par type de blessure
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Répartition par Type de Blessure',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                _buildInjuryTypeStat('Musculaire', 8, 0.4),
                _buildInjuryTypeStat('Articulaire', 5, 0.25),
                _buildInjuryTypeStat('Ligamentaire', 4, 0.2),
                _buildInjuryTypeStat('Osseuse', 2, 0.1),
                _buildInjuryTypeStat('Contusion', 1, 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Méthodes utilitaires pour construire les widgets
  Widget _buildHealthStatCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textBlack,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: textBlack.withOpacity(0.7)),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: textBlack.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 14, color: textBlack)),
      ],
    );
  }

  Widget _buildMedicalAlert(
    String playerName,
    String description,
    Color color,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playerName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: textBlack.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingVisit(String date, String playerName, String reason) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              date,
              style: TextStyle(
                fontSize: 12,
                color: backgroundWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playerName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                Text(
                  reason,
                  style: TextStyle(
                    fontSize: 12,
                    color: textBlack.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 14, color: textBlack.withOpacity(0.7)),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalExam(
    String examName,
    String date,
    String result,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  examName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textBlack,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: textBlack.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Text(
              result,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVaccination(String vaccineName, String date, bool isUpToDate) {
    return Row(
      children: [
        Icon(
          isUpToDate ? Icons.check_circle : Icons.warning,
          color: isUpToDate ? successGreen : warningOrange,
          size: 16,
        ),
        SizedBox(width: 8),
        Text(vaccineName, style: TextStyle(fontSize: 14, color: textBlack)),
        Spacer(),
        Text(
          date,
          style: TextStyle(fontSize: 12, color: textBlack.withOpacity(0.6)),
        ),
      ],
    );
  }

  Widget _buildAllergy(String allergen, String severity) {
    return Row(
      children: [
        Icon(Icons.warning, color: warningOrange, size: 16),
        SizedBox(width: 8),
        Text(allergen, style: TextStyle(fontSize: 14, color: textBlack)),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: warningOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: warningOrange.withOpacity(0.3)),
          ),
          child: Text(
            severity,
            style: TextStyle(
              fontSize: 10,
              color: warningOrange,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMedication(
    String medicationName,
    String dosage,
    String purpose,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(Icons.medication, color: primaryBlue, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicationName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textBlack,
                  ),
                ),
                Text(
                  dosage,
                  style: TextStyle(
                    fontSize: 12,
                    color: textBlack.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: primaryBlue.withOpacity(0.3)),
            ),
            child: Text(
              purpose,
              style: TextStyle(
                fontSize: 10,
                color: primaryBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveInjury(
    String playerName,
    String injuryType,
    String severity,
    String timeRemaining,
    double progress,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: primaryBlue,
                child: Text(
                  playerName.split(' ').map((e) => e[0]).join(''),
                  style: TextStyle(
                    color: backgroundWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playerName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textBlack,
                      ),
                    ),
                    Text(
                      injuryType,
                      style: TextStyle(
                        fontSize: 14,
                        color: textBlack.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getSeverityColor(severity).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _getSeverityColor(severity).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  severity,
                  style: TextStyle(
                    fontSize: 12,
                    color: _getSeverityColor(severity),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(successGreen),
                ),
              ),
              SizedBox(width: 12),
              Text(
                timeRemaining,
                style: TextStyle(
                  fontSize: 12,
                  color: textBlack.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInjuryStatCard(String title, String value, String subtitle) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textBlack,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: textBlack.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryInjury(
    String playerName,
    String injuryType,
    String startDate,
    String endDate,
    String duration,
    String severity,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: primaryBlue,
            child: Text(
              playerName.split(' ').map((e) => e[0]).join(''),
              style: TextStyle(
                color: backgroundWhite,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playerName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                Text(
                  injuryType,
                  style: TextStyle(
                    fontSize: 12,
                    color: textBlack.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$startDate - $endDate',
                style: TextStyle(
                  fontSize: 12,
                  color: textBlack.withOpacity(0.6),
                ),
              ),
              Text(
                duration,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: primaryBlue,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getSeverityColor(severity).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _getSeverityColor(severity).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  severity,
                  style: TextStyle(
                    fontSize: 10,
                    color: _getSeverityColor(severity),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInjuryTypeStat(String type, int count, double percentage) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(type, style: TextStyle(fontSize: 14, color: textBlack)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(primaryBlue),
            ),
          ),
          SizedBox(width: 8),
          Text(
            '${(percentage * 100).toInt()}%',
            style: TextStyle(fontSize: 12, color: textBlack.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'légère':
        return successGreen;
      case 'modérée':
        return warningOrange;
      case 'sévère':
        return dangerRed;
      case 'très sévère':
        return Colors.purple;
      default:
        return textBlack;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
