import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/colors.dart';

// Modèles pour les finances
class Transaction {
  final String id;
  final String description;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final String category;
  final String? notes;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
    this.notes,
  });
}

enum TransactionType { income, expense }

class BudgetCategory {
  final String name;
  final double allocated;
  final double spent;
  final Color color;

  BudgetCategory({
    required this.name,
    required this.allocated,
    required this.spent,
    required this.color,
  });

  double get remaining => allocated - spent;
  double get percentageUsed => (spent / allocated) * 100;
}

class FinancesPage extends StatefulWidget {
  const FinancesPage({super.key});

  @override
  State<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  int _selectedIndex = 0;
  final List<String> _tabs = [
    'Vue d\'ensemble',
    'Transactions',
    'Budget',
    'Rapports',
  ];

  // Données simulées
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      description: 'Sponsor principal',
      amount: 50000.0,
      type: TransactionType.income,
      date: DateTime.now().subtract(const Duration(days: 5)),
      category: 'Sponsors',
    ),
    Transaction(
      id: '2',
      description: 'Achat équipements',
      amount: 2500.0,
      type: TransactionType.expense,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: 'Équipements',
    ),
    Transaction(
      id: '3',
      description: 'Billets matchs',
      amount: 8000.0,
      type: TransactionType.income,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Billetterie',
    ),
    Transaction(
      id: '4',
      description: 'Salaire coach',
      amount: 3500.0,
      type: TransactionType.expense,
      date: DateTime.now(),
      category: 'Salaires',
    ),
  ];

  final List<BudgetCategory> _budgetCategories = [
    BudgetCategory(
      name: 'Salaires',
      allocated: 150000.0,
      spent: 120000.0,
      color: Colors.red,
    ),
    BudgetCategory(
      name: 'Équipements',
      allocated: 50000.0,
      spent: 35000.0,
      color: Colors.blue,
    ),
    BudgetCategory(
      name: 'Transport',
      allocated: 30000.0,
      spent: 18000.0,
      color: Colors.green,
    ),
    BudgetCategory(
      name: 'Marketing',
      allocated: 25000.0,
      spent: 15000.0,
      color: Colors.orange,
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
          'Gestion Financière',
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
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () => _showAddTransactionDialog(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: _tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == _selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected ? primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[600],
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildTransactionsTab();
      case 2:
        return _buildBudgetTab();
      case 3:
        return _buildReportsTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    final totalIncome = _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);

    final totalExpenses = _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);

    final balance = totalIncome - totalExpenses;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFinancialSummaryCard(totalIncome, totalExpenses, balance),
          const SizedBox(height: 24),
          _buildChartCard(),
          const SizedBox(height: 24),
          _buildRecentTransactionsCard(),
        ],
      ),
    );
  }

  Widget _buildFinancialSummaryCard(
    double income,
    double expenses,
    double balance,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryBlue, Color(0xFF2A3F85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
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
          const Text(
            'Résumé Financier',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Revenus',
                  '${income.toStringAsFixed(0)}€',
                  Colors.green,
                  Icons.trending_up,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Dépenses',
                  '${expenses.toStringAsFixed(0)}€',
                  Colors.red,
                  Icons.trending_down,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Solde',
                  '${balance.toStringAsFixed(0)}€',
                  balance >= 0 ? Colors.green : Colors.red,
                  Icons.account_balance_wallet,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
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
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildChartCard() {
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
            'Évolution des Finances',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 3),
                      const FlSpot(2.6, 2),
                      const FlSpot(4.9, 5),
                      const FlSpot(6.8, 3.1),
                      const FlSpot(8, 4),
                      const FlSpot(9.5, 3),
                      const FlSpot(11, 4),
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
        ],
      ),
    );
  }

  Widget _buildRecentTransactionsCard() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transactions Récentes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => setState(() => _selectedIndex = 1),
                child: const Text('Voir tout'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._transactions
              .take(3)
              .map((transaction) => _buildTransactionItem(transaction)),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final transaction = _transactions[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: _buildTransactionItem(transaction),
        );
      },
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: transaction.type == TransactionType.income
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            transaction.type == TransactionType.income
                ? Icons.trending_up
                : Icons.trending_down,
            color: transaction.type == TransactionType.income
                ? Colors.green
                : Colors.red,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.description,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                transaction.category,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              Text(
                '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
        ),
        Text(
          '${transaction.type == TransactionType.income ? '+' : '-'}${transaction.amount.toStringAsFixed(0)}€',
          style: TextStyle(
            color: transaction.type == TransactionType.income
                ? Colors.green
                : Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBudgetOverviewCard(),
          const SizedBox(height: 24),
          ..._budgetCategories.map(
            (category) => _buildBudgetCategoryCard(category),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetOverviewCard() {
    final totalAllocated = _budgetCategories.fold(
      0.0,
      (sum, c) => sum + c.allocated,
    );
    final totalSpent = _budgetCategories.fold(0.0, (sum, c) => sum + c.spent);
    final totalRemaining = totalAllocated - totalSpent;

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
            'Vue d\'ensemble du Budget',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildBudgetSummaryItem(
                  'Alloué',
                  '${totalAllocated.toStringAsFixed(0)}€',
                  primaryBlue,
                ),
              ),
              Expanded(
                child: _buildBudgetSummaryItem(
                  'Dépensé',
                  '${totalSpent.toStringAsFixed(0)}€',
                  Colors.orange,
                ),
              ),
              Expanded(
                child: _buildBudgetSummaryItem(
                  'Restant',
                  '${totalRemaining.toStringAsFixed(0)}€',
                  totalRemaining >= 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildBudgetCategoryCard(BudgetCategory category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: category.percentageUsed > 80
                      ? Colors.red.withOpacity(0.1)
                      : category.percentageUsed > 60
                      ? Colors.orange.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${category.percentageUsed.toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: category.percentageUsed > 80
                        ? Colors.red
                        : category.percentageUsed > 60
                        ? Colors.orange
                        : Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: category.spent / category.allocated,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(category.color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dépensé: ${category.spent.toStringAsFixed(0)}€',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              Text(
                'Restant: ${category.remaining.toStringAsFixed(0)}€',
                style: TextStyle(
                  color: category.remaining >= 0 ? Colors.green : Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportCard(
            'Rapport Mensuel',
            'Vue d\'ensemble des finances du mois en cours',
            Icons.calendar_today,
            () {},
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            'Analyse des Dépenses',
            'Détail des dépenses par catégorie',
            Icons.analytics,
            () {},
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            'Prévisions',
            'Projections financières pour les prochains mois',
            Icons.trending_up,
            () {},
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            'Export des Données',
            'Télécharger les rapports au format PDF/Excel',
            Icons.download,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: primaryBlue, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter une Transaction'),
        content: const Text('Fonctionnalité à implémenter'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }
}
