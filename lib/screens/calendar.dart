import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// Modèle pour un match
class Match {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final DateTime dateTime;
  final String location;
  final String competition;
  final String? score;
  final MatchStatus status;
  final String? notes;

  Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.dateTime,
    required this.location,
    required this.competition,
    this.score,
    this.status = MatchStatus.scheduled,
    this.notes,
  });
}

enum MatchStatus { scheduled, inProgress, completed, cancelled, postponed }

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  late DateTime focusedDate;
  late PageController _pageController;
  int currentMonthIndex = 0;

  // Données simulées des matchs
  final List<Match> matches = [
    Match(
      id: '1',
      homeTeam: 'Équipe A',
      awayTeam: 'Équipe B',
      dateTime: DateTime.now().add(const Duration(days: 2)),
      location: 'Stade Municipal',
      competition: 'Championnat Régional',
      notes: 'Match important pour la qualification',
    ),
    Match(
      id: '2',
      homeTeam: 'Équipe C',
      awayTeam: 'Équipe A',
      dateTime: DateTime.now().add(const Duration(days: 7)),
      location: 'Complexe Sportif',
      competition: 'Coupe de France',
      notes: 'Match de coupe',
    ),
    Match(
      id: '3',
      homeTeam: 'Équipe A',
      awayTeam: 'Équipe D',
      dateTime: DateTime.now().add(const Duration(days: 14)),
      location: 'Stade Municipal',
      competition: 'Championnat Régional',
    ),
    Match(
      id: '4',
      homeTeam: 'Équipe E',
      awayTeam: 'Équipe A',
      dateTime: DateTime.now().add(const Duration(days: 21)),
      location: 'Stade Olympique',
      competition: 'Championnat Régional',
    ),
    Match(
      id: '5',
      homeTeam: 'Équipe A',
      awayTeam: 'Équipe F',
      dateTime: DateTime.now().add(const Duration(days: 28)),
      location: 'Stade Municipal',
      competition: 'Coupe de France',
    ),
  ];

  @override
  void initState() {
    super.initState();
    focusedDate = DateTime.now();
    _pageController = PageController(initialPage: 12); // 12 mois en arrière
    // Initialiser la localisation française pour le formatage des dates
    initializeDateFormatting('fr_FR', null);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Couleurs du thème
  static const Color primaryBlue = Color(0xFF3852A4);
  static const Color secondaryBlue = Color(0xFF2A3F85);
  static const Color accentYellow = Color(0xFFF8D959);
  static const Color darkYellow = Color(0xFFE6C34A);
  static const Color lightBlue = Color(0xFF5A7BC8);
  static const Color backgroundColor = Color(0xFFF5F7FA);
  static const Color cardBackground = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryBlue, secondaryBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Calendrier des Matchs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: accentYellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: () => _showFilterDialog(),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCalendarHeader(),
          _buildCalendarGrid(),
          const SizedBox(height: 16),
          Expanded(child: _buildMatchesList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMatchDialog(),
        backgroundColor: accentYellow,
        child: const Icon(Icons.add, color: primaryBlue),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                currentMonthIndex--;
                selectedDate = DateTime(
                  selectedDate.year,
                  selectedDate.month - 1,
                  1,
                );
              });
            },
            icon: const Icon(Icons.chevron_left, color: primaryBlue),
          ),
          Text(
            DateFormat('MMMM yyyy', 'fr_FR').format(selectedDate),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                currentMonthIndex++;
                selectedDate = DateTime(
                  selectedDate.year,
                  selectedDate.month + 1,
                  1,
                );
              });
            },
            icon: const Icon(Icons.chevron_right, color: primaryBlue),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    );
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // En-têtes des jours
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  'Lun',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Mar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Mer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Jeu',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ven',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sam',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Dim',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Grille des jours
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 42, // 6 semaines * 7 jours
              itemBuilder: (context, index) {
                final dayOffset = index - (firstWeekday - 1);
                final day = dayOffset + 1;

                if (day < 1 || day > daysInMonth) {
                  return Container();
                }

                final date = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  day,
                );
                final hasMatches = matches.any(
                  (match) =>
                      match.dateTime.year == date.year &&
                      match.dateTime.month == date.month &&
                      match.dateTime.day == date.day,
                );
                final isToday =
                    date.year == DateTime.now().year &&
                    date.month == DateTime.now().month &&
                    date.day == DateTime.now().day;
                final isSelected =
                    date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    date.day == selectedDate.day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? accentYellow
                          : isToday
                          ? lightBlue.withOpacity(0.3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: hasMatches
                          ? Border.all(color: primaryBlue, width: 2)
                          : null,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          day.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isToday || isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? primaryBlue
                                : isToday
                                ? primaryBlue
                                : Colors.black87,
                          ),
                        ),
                        if (hasMatches)
                          Positioned(
                            bottom: 2,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: primaryBlue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesList() {
    final selectedDateMatches = matches
        .where(
          (match) =>
              match.dateTime.year == selectedDate.year &&
              match.dateTime.month == selectedDate.month &&
              match.dateTime.day == selectedDate.day,
        )
        .toList();

    if (selectedDateMatches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_soccer_outlined,
              size: 64,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Aucun match programmé pour cette date',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: selectedDateMatches.length,
      itemBuilder: (context, index) {
        final match = selectedDateMatches[index];
        return _buildMatchCard(match);
      },
    );
  }

  Widget _buildMatchCard(Match match) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(match.status).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(match.status),
                    style: TextStyle(
                      color: _getStatusColor(match.status),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  DateFormat('HH:mm', 'fr_FR').format(match.dateTime),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    match.homeTeam,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    match.awayTeam,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    match.location,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.emoji_events, color: Colors.grey[600], size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    match.competition,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
              ],
            ),
            if (match.notes != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.note, color: Colors.grey[600], size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      match.notes!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showMatchDetails(match),
                    icon: const Icon(Icons.info_outline, size: 16),
                    label: const Text('Détails'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryBlue,
                      side: const BorderSide(color: primaryBlue),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _editMatch(match),
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Modifier'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentYellow,
                      foregroundColor: primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(MatchStatus status) {
    switch (status) {
      case MatchStatus.scheduled:
        return Colors.blue;
      case MatchStatus.inProgress:
        return Colors.orange;
      case MatchStatus.completed:
        return Colors.green;
      case MatchStatus.cancelled:
        return Colors.red;
      case MatchStatus.postponed:
        return Colors.purple;
    }
  }

  String _getStatusText(MatchStatus status) {
    switch (status) {
      case MatchStatus.scheduled:
        return 'Programmé';
      case MatchStatus.inProgress:
        return 'En cours';
      case MatchStatus.completed:
        return 'Terminé';
      case MatchStatus.cancelled:
        return 'Annulé';
      case MatchStatus.postponed:
        return 'Reporté';
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrer les matchs'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Tous les matchs'),
              leading: Radio<MatchStatus?>(
                value: null,
                groupValue: null,
                onChanged: (value) {
                  Navigator.of(context).pop();
                },
              ),
            ),
            ...MatchStatus.values.map(
              (status) => ListTile(
                title: Text(_getStatusText(status)),
                leading: Radio<MatchStatus?>(
                  value: status,
                  groupValue: null,
                  onChanged: (value) {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  void _showAddMatchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un match'),
        content: const Text('Fonctionnalité à implémenter'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showMatchDetails(Match match) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${match.homeTeam} vs ${match.awayTeam}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${DateFormat('dd/MM/yyyy HH:mm', 'fr_FR').format(match.dateTime)}',
            ),
            Text('Lieu: ${match.location}'),
            Text('Compétition: ${match.competition}'),
            if (match.notes != null) Text('Notes: ${match.notes}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _editMatch(Match match) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le match'),
        content: const Text('Fonctionnalité à implémenter'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
