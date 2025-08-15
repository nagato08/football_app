import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PerformanceDashboard extends StatefulWidget {
  const PerformanceDashboard({super.key});

  @override
  _PerformanceDashboardState createState() => _PerformanceDashboardState();
}

class _PerformanceDashboardState extends State<PerformanceDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedPlayerIndex = 0;

  // Couleurs du thème
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color accentYellow = Color(0xFFFBBF24);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF1F2937);
  static const Color lightGray = Color(0xFFF3F4F6);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      appBar: AppBar(
        title: Text(
          'Performances Équipe',
          style: TextStyle(
            color: backgroundWhite,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: primaryBlue,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: accentYellow,
          labelColor: accentYellow,
          unselectedLabelColor: backgroundWhite.withOpacity(0.7),
          tabs: [
            Tab(text: 'Vue d\'ensemble'),
            Tab(text: 'Détail Joueur'),
            Tab(text: 'Saisie Match'),
            Tab(text: 'Comparaison'),
            Tab(text: 'Historique'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildPlayerDetailTab(),
          _buildMatchInputTab(),
          _buildComparisonTab(),
          _buildHistoryTab(),
        ],
      ),
    );
  }

  // Onglet Vue d'ensemble
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistiques générales
          Row(
            children: [
              Expanded(child: _buildStatCard('Matchs Joués', '15', Icons.sports_soccer)),
              SizedBox(width: 12),
              Expanded(child: _buildStatCard('Victoires', '10', Icons.emoji_events)),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard('Buts Marqués', '42', Icons.sports_handball)),
              SizedBox(width: 12),
              Expanded(child: _buildStatCard('Buts Encaissés', '18', Icons.shield)),
            ],
          ),
          SizedBox(height: 24),

          // Graphique des performances
          Container(
            height: 300,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Performances sur 10 matchs',
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
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 3),
                            FlSpot(1, 2),
                            FlSpot(2, 5),
                            FlSpot(3, 1),
                            FlSpot(4, 4),
                            FlSpot(5, 3),
                            FlSpot(6, 6),
                            FlSpot(7, 2),
                            FlSpot(8, 4),
                            FlSpot(9, 5),
                          ],
                          isCurved: true,
                          color: primaryBlue,
                          barWidth: 3,
                          belowBarData: BarAreaData(
                            show: true,
                            color: primaryBlue.withOpacity(0.1),
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Top joueurs
          Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Buteurs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                _buildPlayerRank('Karim Benzema', '12 buts', '1'),
                _buildPlayerRank('Kylian Mbappé', '8 buts', '2'),
                _buildPlayerRank('Antoine Griezmann', '6 buts', '3'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Onglet Détail Joueur
  Widget _buildPlayerDetailTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Sélection joueur
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: backgroundWhite,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: primaryBlue),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: 'Karim Benzema',
                isExpanded: true,
                items: ['Karim Benzema', 'Kylian Mbappé', 'Antoine Griezmann']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Gérer le changement
                },
              ),
            ),
          ),
          SizedBox(height: 24),

          // Photo et infos joueur
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
                CircleAvatar(
                  radius: 50,
                  backgroundColor: primaryBlue,
                  child: Icon(Icons.person, size: 50, color: backgroundWhite),
                ),
                SizedBox(height: 16),
                Text(
                  'Karim Benzema',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                Text(
                  'Attaquant • #9',
                  style: TextStyle(
                    fontSize: 16,
                    color: textBlack.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Statistiques détaillées
          Row(
            children: [
              Expanded(child: _buildDetailStatCard('Buts', '12', Icons.sports_soccer)),
              SizedBox(width: 12),
              Expanded(child: _buildDetailStatCard('Passes', '85%', Icons.trending_up)),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildDetailStatCard('Minutes', '1,250', Icons.access_time)),
              SizedBox(width: 12),
              Expanded(child: _buildDetailStatCard('Cartons', '2', Icons.credit_card)),
            ],
          ),
          SizedBox(height: 24),

          // Graphique radar
          Container(
            height: 300,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Évaluation des Compétences',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: RadarChart(
                    RadarChartData(
                      dataSets: [
                        RadarDataSet(
                          fillColor: primaryBlue.withOpacity(0.2),
                          borderColor: primaryBlue,
                          dataEntries: [
                            RadarEntry(value: 90), // Attaque
                            RadarEntry(value: 75), // Défense
                            RadarEntry(value: 85), // Vitesse
                            RadarEntry(value: 80), // Technique
                            RadarEntry(value: 70), // Physique
                          ],
                        ),
                      ],
                      radarTouchData: RadarTouchData(enabled: false),
                      radarBackgroundColor: Colors.transparent,
                      borderData: FlBorderData(show: false),
                      radarBorderData: BorderSide(color: Colors.transparent),
                      titlePositionPercentageOffset: 0.2,
                      titleTextStyle: TextStyle(
                        color: textBlack,
                        fontSize: 12,
                      ),
                      getTitle: (index, angle) {
                        switch (index) {
                          case 0:
                            return RadarChartTitle(text: 'Attaque');
                          case 1:
                            return RadarChartTitle(text: 'Défense');
                          case 2:
                            return RadarChartTitle(text: 'Vitesse');
                          case 3:
                            return RadarChartTitle(text: 'Technique');
                          case 4:
                            return RadarChartTitle(text: 'Physique');
                          default:
                            return RadarChartTitle(text: '');
                        }
                      },
                      tickCount: 5,
                      ticksTextStyle: TextStyle(
                        color: Colors.transparent,
                        fontSize: 10,
                      ),
                      tickBorderData: BorderSide(color: Colors.grey.withOpacity(0.2)),
                      gridBorderData: BorderSide(color: Colors.grey.withOpacity(0.2)),
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

  // Onglet Saisie Match
  Widget _buildMatchInputTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  'Saisie Statistiques Match',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 24),

                // Informations match
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Équipe adverse',
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
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Date',
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
                  ],
                ),
                SizedBox(height: 16),

                // Score
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Buts marqués',
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
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Buts encaissés',
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
                SizedBox(height: 24),

                Text(
                  'Statistiques par joueur',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),

                // Liste des joueurs avec saisie
                ...List.generate(3, (index) {
                  List<String> players = ['Karim Benzema', 'Kylian Mbappé', 'Antoine Griezmann'];
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
                        Text(
                          players[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textBlack,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Buts',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Passes',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Cartons',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Sauvegarder les statistiques
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
                      'Enregistrer les Statistiques',
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
        ],
      ),
    );
  }

  // Onglet Comparaison
  Widget _buildComparisonTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Sélection des joueurs à comparer
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
                  'Comparaison de Joueurs',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Joueur 1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        value: 'Karim Benzema',
                        items: ['Karim Benzema', 'Kylian Mbappé', 'Antoine Griezmann']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Joueur 2',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        value: 'Kylian Mbappé',
                        items: ['Karim Benzema', 'Kylian Mbappé', 'Antoine Griezmann']
                            .map((String value) {
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

          // Comparaison visuelle
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
                // Profils des joueurs
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: primaryBlue,
                            child: Icon(Icons.person, size: 40, color: backgroundWhite),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Karim Benzema',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: accentYellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'VS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textBlack,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: primaryBlue,
                            child: Icon(Icons.person, size: 40, color: backgroundWhite),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Kylian Mbappé',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),

                // Statistiques comparatives
                _buildComparisonStat('Buts', '12', '8'),
                _buildComparisonStat('Passes réussies', '85%', '78%'),
                _buildComparisonStat('Minutes jouées', '1,250', '1,180'),
                _buildComparisonStat('Tirs cadrés', '68%', '72%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Onglet Historique
  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Graphique évolution
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
                  'Évolution des Performances',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 1),
                            FlSpot(1, 3),
                            FlSpot(2, 2),
                            FlSpot(3, 5),
                            FlSpot(4, 3),
                            FlSpot(5, 4),
                            FlSpot(6, 6),
                            FlSpot(7, 4),
                            FlSpot(8, 5),
                            FlSpot(9, 7),
                            FlSpot(10, 6),
                            FlSpot(11, 8),
                          ],
                          isCurved: true,
                          color: primaryBlue,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: primaryBlue.withOpacity(0.1),
                          ),
                        ),
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 2),
                            FlSpot(1, 1),
                            FlSpot(2, 4),
                            FlSpot(3, 3),
                            FlSpot(4, 2),
                            FlSpot(5, 5),
                            FlSpot(6, 4),
                            FlSpot(7, 6),
                            FlSpot(8, 3),
                            FlSpot(9, 5),
                            FlSpot(10, 7),
                            FlSpot(11, 6),
                          ],
                          isCurved: true,
                          color: accentYellow,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                'M${value.toInt() + 1}',
                                style: TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 1,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withOpacity(0.2),
                            strokeWidth: 1,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem('Buts', primaryBlue),
                    SizedBox(width: 24),
                    _buildLegendItem('Passes décisives', accentYellow),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Historique des matchs
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
                  'Derniers Matchs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textBlack,
                  ),
                ),
                SizedBox(height: 16),
                ...List.generate(5, (index) {
                  List<Map<String, dynamic>> matches = [
                    {'opponent': 'FC Barcelona', 'score': '3-1', 'result': 'V', 'date': '15/07/2025'},
                    {'opponent': 'Real Madrid', 'score': '2-2', 'result': 'N', 'date': '12/07/2025'},
                    {'opponent': 'Liverpool FC', 'score': '1-2', 'result': 'D', 'date': '08/07/2025'},
                    {'opponent': 'AC Milan', 'score': '4-0', 'result': 'V', 'date': '05/07/2025'},
                    {'opponent': 'Chelsea FC', 'score': '2-1', 'result': 'V', 'date': '01/07/2025'},
                  ];

                  Color resultColor = matches[index]['result'] == 'V'
                      ? Colors.green
                      : matches[index]['result'] == 'N'
                      ? accentYellow
                      : Colors.red;

                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: lightGray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: resultColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              matches[index]['result'],
                              style: TextStyle(
                                color: backgroundWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                matches[index]['opponent'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textBlack,
                                ),
                              ),
                              Text(
                                matches[index]['date'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textBlack.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          matches[index]['score'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textBlack,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour les cartes de statistiques
  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
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
              Icon(icon, color: primaryBlue, size: 24),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentYellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: accentYellow, size: 16),
              ),
            ],
          ),
          SizedBox(height: 12),
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
            style: TextStyle(
              fontSize: 14,
              color: textBlack.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour les cartes de statistiques détaillées
  Widget _buildDetailStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryBlue.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryBlue, size: 32),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textBlack,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: textBlack.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour le classement des joueurs
  Widget _buildPlayerRank(String name, String stat, String rank) {
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
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: rank == '1'
                  ? accentYellow
                  : rank == '2'
                  ? Colors.grey[400]
                  : Colors.orange[300],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                rank,
                style: TextStyle(
                  color: backgroundWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textBlack,
              ),
            ),
          ),
          Text(
            stat,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour la comparaison des statistiques
  Widget _buildComparisonStat(String title, String value1, String value2) {
    double val1 = double.tryParse(value1.replaceAll('%', '')) ?? 0;
    double val2 = double.tryParse(value2.replaceAll('%', '')) ?? 0;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textBlack,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: val1 >= val2 ? primaryBlue.withOpacity(0.1) : lightGray,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    value1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: val1 >= val2 ? primaryBlue : textBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: val2 > val1 ? primaryBlue.withOpacity(0.1) : lightGray,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    value2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: val2 > val1 ? primaryBlue : textBlack,
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

  // Widget pour la légende des graphiques
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: textBlack,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}