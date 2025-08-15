import 'package:flutter/material.dart';

class PlayerProfilePage extends StatefulWidget {
  const PlayerProfilePage({super.key});

  @override
  _PlayerProfilePageState createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour les champs de texte
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nationaliteController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _contactUrgenceController =
      TextEditingController();
  final TextEditingController _tailleController = TextEditingController();
  final TextEditingController _poidsController = TextEditingController();
  final TextEditingController _numeroMaillotController =
      TextEditingController();
  final TextEditingController _numeroLicenceController =
      TextEditingController();

  DateTime? _dateNaissance;
  DateTime? _dateInscription;
  String _postePrincipal = 'Attaquant';
  final List<String> _postesSecondaires = [];
  String _piedFort = 'Droit';
  String _statut = 'Amateur';
  String _typeContrat = 'CDD';

  // Couleurs du thème
  static const Color primaryBlue = Color(0xFF3852A4);
  static const Color accentYellow = Color(0xFFF8D959);
  static const Color darkColor = Color(0xFF050505);
  static const Color whiteColor = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          'Profil Joueur',
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 24 : 20,
          ),
        ),
        backgroundColor: primaryBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo de profil
              _buildProfilePhoto(isTablet),
              SizedBox(height: isTablet ? 32 : 24),

              // Informations personnelles
              _buildSectionTitle('Informations Personnelles', isTablet),
              _buildPersonalInfoSection(isTablet),
              SizedBox(height: isTablet ? 32 : 24),

              // Informations sportives
              _buildSectionTitle('Informations Sportives', isTablet),
              _buildSportsInfoSection(isTablet),
              SizedBox(height: isTablet ? 32 : 24),

              // Données administratives
              _buildSectionTitle('Données Administratives', isTablet),
              _buildAdminInfoSection(isTablet),
              SizedBox(height: isTablet ? 40 : 32),

              // Boutons d'action
              _buildActionButtons(isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhoto(bool isTablet) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: isTablet ? 150 : 120,
            height: isTablet ? 150 : 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryBlue.withValues(alpha: 0.1),
              border: Border.all(color: primaryBlue, width: 3),
            ),
            child: Icon(
              Icons.person,
              size: isTablet ? 80 : 60,
              color: primaryBlue,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: isTablet ? 40 : 35,
              height: isTablet ? 40 : 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentYellow,
                border: Border.all(color: whiteColor, width: 2),
              ),
              child: Icon(
                Icons.camera_alt,
                size: isTablet ? 20 : 18,
                color: darkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isTablet ? 16 : 12,
        horizontal: isTablet ? 20 : 16,
      ),
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: isTablet ? 20 : 18,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: darkColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _nomController,
                  label: 'Nom',
                  icon: Icons.person_outline,
                  isTablet: isTablet,
                ),
              ),
              SizedBox(width: isTablet ? 20 : 16),
              Expanded(
                child: _buildTextField(
                  controller: _prenomController,
                  label: 'Prénom',
                  icon: Icons.person_outline,
                  isTablet: isTablet,
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildDateField(
            label: 'Date de naissance',
            selectedDate: _dateNaissance,
            onDateSelected: (date) => setState(() => _dateNaissance = date),
            icon: Icons.calendar_today,
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildTextField(
            controller: _nationaliteController,
            label: 'Nationalité',
            icon: Icons.flag_outlined,
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildTextField(
            controller: _adresseController,
            label: 'Adresse',
            icon: Icons.location_on_outlined,
            maxLines: 2,
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildTextField(
            controller: _contactUrgenceController,
            label: 'Contact d\'urgence',
            icon: Icons.emergency_outlined,
            keyboardType: TextInputType.phone,
            isTablet: isTablet,
          ),
        ],
      ),
    );
  }

  Widget _buildSportsInfoSection(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: darkColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDropdownField(
            label: 'Poste principal',
            value: _postePrincipal,
            items: ['Gardien', 'Défenseur', 'Milieu', 'Attaquant'],
            onChanged: (value) => setState(() => _postePrincipal = value!),
            icon: Icons.sports_soccer,
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildMultiSelectField(
            label: 'Postes secondaires',
            selectedItems: _postesSecondaires,
            allItems: ['Gardien', 'Défenseur', 'Milieu', 'Attaquant'],
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildDropdownField(
            label: 'Pied fort',
            value: _piedFort,
            items: ['Droit', 'Gauche', 'Les deux'],
            onChanged: (value) => setState(() => _piedFort = value!),
            icon: Icons.directions_run,
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 20 : 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _tailleController,
                  label: 'Taille (cm)',
                  icon: Icons.height,
                  keyboardType: TextInputType.number,
                  isTablet: isTablet,
                ),
              ),
              SizedBox(width: isTablet ? 20 : 16),
              Expanded(
                child: _buildTextField(
                  controller: _poidsController,
                  label: 'Poids (kg)',
                  icon: Icons.fitness_center,
                  keyboardType: TextInputType.number,
                  isTablet: isTablet,
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildTextField(
            controller: _numeroMaillotController,
            label: 'Numéro de maillot préféré',
            icon: Icons.sports_football_rounded,
            keyboardType: TextInputType.number,
            isTablet: isTablet,
          ),
        ],
      ),
    );
  }

  Widget _buildAdminInfoSection(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: darkColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTextField(
            controller: _numeroLicenceController,
            label: 'Numéro de licence',
            icon: Icons.badge_outlined,
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildDateField(
            label: 'Date d\'inscription',
            selectedDate: _dateInscription,
            onDateSelected: (date) => setState(() => _dateInscription = date),
            icon: Icons.date_range,
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildDropdownField(
            label: 'Statut',
            value: _statut,
            items: ['Amateur', 'Professionnel'],
            onChanged: (value) => setState(() => _statut = value!),
            icon: Icons.work_outline,
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 20 : 16),
          _buildDropdownField(
            label: 'Type de contrat',
            value: _typeContrat,
            items: ['CDD', 'CDI', 'Stagiaire', 'Bénévole'],
            onChanged: (value) => setState(() => _typeContrat = value!),
            icon: Icons.description_outlined,
            isTablet: isTablet,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isTablet = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(fontSize: isTablet ? 16 : 14, color: darkColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: primaryBlue, fontSize: isTablet ? 16 : 14),
        prefixIcon: Icon(icon, color: primaryBlue, size: isTablet ? 24 : 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryBlue.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 16 : 12,
          vertical: isTablet ? 16 : 12,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ce champ est requis';
        }
        return null;
      },
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
    required IconData icon,
    bool isTablet = false,
  }) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: primaryBlue,
                  onPrimary: whiteColor,
                  onSurface: darkColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 16 : 12,
          vertical: isTablet ? 16 : 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: primaryBlue.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryBlue, size: isTablet ? 24 : 20),
            SizedBox(width: isTablet ? 16 : 12),
            Expanded(
              child: Text(
                selectedDate != null
                    ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                    : label,
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: selectedDate != null ? darkColor : primaryBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
    bool isTablet = false,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      style: TextStyle(fontSize: isTablet ? 16 : 14, color: darkColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: primaryBlue, fontSize: isTablet ? 16 : 14),
        prefixIcon: Icon(icon, color: primaryBlue, size: isTablet ? 24 : 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryBlue.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 16 : 12,
          vertical: isTablet ? 16 : 12,
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
    );
  }

  Widget _buildMultiSelectField({
    required String label,
    required List<String> selectedItems,
    required List<String> allItems,
    bool isTablet = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 16 : 14,
            color: primaryBlue,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allItems.map((item) {
            final isSelected = selectedItems.contains(item);
            return FilterChip(
              label: Text(
                item,
                style: TextStyle(
                  fontSize: isTablet ? 14 : 12,
                  color: isSelected ? whiteColor : primaryBlue,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedItems.add(item);
                  } else {
                    selectedItems.remove(item);
                  }
                });
              },
              backgroundColor: whiteColor,
              selectedColor: primaryBlue,
              checkmarkColor: whiteColor,
              side: BorderSide(color: primaryBlue),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isTablet) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: isTablet ? 56 : 48,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _saveProfile();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              foregroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
            child: Text(
              'Enregistrer le profil',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: isTablet ? 16 : 12),
        SizedBox(
          width: double.infinity,
          height: isTablet ? 56 : 48,
          child: OutlinedButton(
            onPressed: () {
              _resetForm();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryBlue,
              side: BorderSide(color: primaryBlue, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Réinitialiser',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _saveProfile() {
    // Logique de sauvegarde du profil
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profil enregistré avec succès !'),
        backgroundColor: primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _nomController.clear();
      _prenomController.clear();
      _nationaliteController.clear();
      _adresseController.clear();
      _contactUrgenceController.clear();
      _tailleController.clear();
      _poidsController.clear();
      _numeroMaillotController.clear();
      _numeroLicenceController.clear();
      _dateNaissance = null;
      _dateInscription = null;
      _postePrincipal = 'Attaquant';
      _postesSecondaires.clear();
      _piedFort = 'Droit';
      _statut = 'Amateur';
      _typeContrat = 'CDD';
    });
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _nationaliteController.dispose();
    _adresseController.dispose();
    _contactUrgenceController.dispose();
    _tailleController.dispose();
    _poidsController.dispose();
    _numeroMaillotController.dispose();
    _numeroLicenceController.dispose();
    super.dispose();
  }
}
