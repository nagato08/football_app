import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/colors.dart';

// Modèles pour le dashboard présidentiel
class ClubMetrics {
  final int totalPlayers;
  final int totalStaff;
  final double monthlyRevenue;
  final double monthlyExpenses;
  final int seasonTickets;
  final double averageAttendance;
  final int currentPosition;
  final int totalPoints;
  final int matchesPlayed;
  final int matchesWon;
  final int matchesDrawn;
  final int matchesLost;

  ClubMetrics({
    required this.totalPlayers,
    required this.totalStaff,
    required this.monthlyRevenue,
    required this.monthlyExpenses,
    required this.seasonTickets,
    required this.averageAttendance,
    required this.currentPosition,
    required this.totalPoints,
    required this.matchesPlayed,
    required this.matchesWon,
    required this.matchesDrawn,
    required this.matchesLost,
  });

  double get profit => monthlyRevenue - monthlyExpenses;
  double get winRate =>
      matchesPlayed > 0 ? (matchesWon / matchesPlayed) * 100 : 0;
}

class Alert {
  final String title;
  final String message;
  final AlertType type;
  final DateTime date;
  final bool isRead;

  Alert({
    required this.title,
    required this.message,
    required this.type,
    required this.date,
    this.isRead = false,
  });
}

enum AlertType { info, warning, critical, success }

class DashboardPresident extends StatefulWidget {
  const DashboardPresident({super.key});

  @override
  State<DashboardPresident> createState() => _DashboardPresidentState();
}

class _DashboardPresidentState extends State<DashboardPresident> {
  int _selectedPeriod = 0;
  final List<String> _periods = ['Mois', 'Trimestre', 'Année'];

  // Données simulées
  final ClubMetrics _metrics = ClubMetrics(
    totalPlayers: 28,
    totalStaff: 15,
    monthlyRevenue: 125000.0,
    monthlyExpenses: 98000.0,
    seasonTickets: 8500,
    averageAttendance: 12500,
    currentPosition: 3,
    totalPoints: 45,
    matchesPlayed: 18,
    matchesWon: 13,
    matchesDrawn: 6,
    matchesLost: 2,
  );

  final List<Alert> _alerts = [
    Alert(
      title: 'Renouvellement de contrat',
      message: 'Le contrat de l\'attaquant principal expire dans 3 mois',
      type: AlertType.warning,
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Alert(
      title: 'Sponsor majeur',
      message: 'Nouveau contrat de sponsoring signé - +25% de revenus',
      type: AlertType.success,
      date: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Alert(
      title: 'Blessure importante',
      message: 'Le milieu de terrain titulaire absent 6-8 semaines',
      type: AlertType.critical,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Alert(
      title: 'Performance financière',
      message: 'Objectifs de revenus dépassés ce mois-ci',
      type: AlertType.success,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryBlue, Color(0xFF2A3F85)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Dashboard Présidentiel',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: accentYellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
              onPressed: () => _showNotifications(context),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeHeader(),
            const SizedBox(height: 24),
            _buildKeyMetricsGrid(),
            const SizedBox(height: 24),
            _buildPerformanceSection(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildFinancialChart()),
                const SizedBox(width: 20),
                Expanded(child: _buildAttendanceChart()),
              ],
            ),
            const SizedBox(height: 24),
            _buildAlertsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryBlue, Color(0xFF2A3F85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.sports_soccer,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bienvenue, Président',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Vue d\'ensemble de votre club - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeaderMetric(
                'Position',
                '${_metrics.currentPosition}e',
                Icons.emoji_events,
              ),
              const SizedBox(width: 50),
              _buildHeaderMetric(
                'Points',
                '${_metrics.totalPoints}',
                Icons.star,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: accentYellow, size: 24),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildKeyMetricsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildMetricCard(
          title: 'Effectif',
          value: '${_metrics.totalPlayers}',
          icon: Icons.people,
          color: primaryBlue,
        ),
        _buildMetricCard(
          title: 'Revenus',
          value: '${_metrics.monthlyRevenue.toStringAsFixed(0)}€',
          icon: Icons.trending_up,
          color: Colors.green,
        ),
        _buildMetricCard(
          title: 'Billetterie',
          value: '${_metrics.seasonTickets}',
          icon: Icons.confirmation_number,
          color: Colors.orange,
        ),
        _buildMetricCard(
          title: 'Performance',
          value: '${_metrics.winRate.toStringAsFixed(0)}%',
          icon: Icons.sports_soccer,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const Spacer(),
              Icon(Icons.more_vert, color: Colors.grey[400], size: 20),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Performance Sportive',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildPerformanceItem(
                  'Matchs joués',
                  '${_metrics.matchesPlayed}',
                  Icons.sports,
                  primaryBlue,
                ),
              ),
              Expanded(
                child: _buildPerformanceItem(
                  'Victoires',
                  '${_metrics.matchesWon}',
                  Icons.emoji_events,
                  Colors.green,
                ),
              ),
              Expanded(
                child: _buildPerformanceItem(
                  'Nuls',
                  '${_metrics.matchesDrawn}',
                  Icons.remove,
                  Colors.orange,
                ),
              ),
              Expanded(
                child: _buildPerformanceItem(
                  'Défaites',
                  '${_metrics.matchesLost}',
                  Icons.trending_down,
                  Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: _metrics.totalPoints / 54, // 18 matchs * 3 points max
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(primaryBlue),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Text(
            '${_metrics.totalPoints} points sur 54 possibles',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildFinancialChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Évolution Financière',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 3),
                      const FlSpot(2, 4),
                      const FlSpot(4, 2),
                      const FlSpot(6, 5),
                      const FlSpot(8, 4),
                      const FlSpot(10, 6),
                    ],
                    isCurved: true,
                    color: primaryBlue,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: primaryBlue.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildChartLegend('Revenus', Colors.green),
              _buildChartLegend('Dépenses', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Affluence des Matchs',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(toY: 8, color: accentYellow)],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(toY: 12, color: accentYellow)],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(toY: 10, color: accentYellow)],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(toY: 15, color: accentYellow)],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [BarChartRodData(toY: 13, color: accentYellow)],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [BarChartRodData(toY: 16, color: accentYellow)],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Moyenne: ${_metrics.averageAttendance.toStringAsFixed(0)} spectateurs',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildAlertsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Alertes & Notifications',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ..._alerts.take(3).map((alert) => _buildAlertItem(alert)),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Alert alert) {
    Color alertColor;
    IconData alertIcon;

    switch (alert.type) {
      case AlertType.info:
        alertColor = Colors.blue;
        alertIcon = Icons.info;
        break;
      case AlertType.warning:
        alertColor = Colors.orange;
        alertIcon = Icons.warning;
        break;
      case AlertType.critical:
        alertColor = Colors.red;
        alertIcon = Icons.error;
        break;
      case AlertType.success:
        alertColor = Colors.green;
        alertIcon = Icons.check_circle;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: alertColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: alertColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: alertColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(alertIcon, color: alertColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alert.message,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatTimeAgo(alert.date),
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          if (!alert.isRead)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: alertColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return 'Il y a ${difference.inDays} jour${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'Il y a ${difference.inHours} heure${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'Il y a ${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'À l\'instant';
    }
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const Text('Centre de notifications à implémenter'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _navigateToFinances(BuildContext context) {
    // Navigation vers la page des finances
    Navigator.pushNamed(context, '/finances');
  }
}
