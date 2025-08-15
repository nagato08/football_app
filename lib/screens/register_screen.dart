import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dashboardjoueur.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  late TabController _tabController;

  // Controllers pour les champs de texte
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _adresseController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactUrgenceNomController = TextEditingController();
  final _contactUrgenceTelController = TextEditingController();
  final _tailleController = TextEditingController();
  final _poidsController = TextEditingController();
  final _numeroMaillotController = TextEditingController();
  final _numeroLicenceController = TextEditingController();

  // Variables pour les sélections
  DateTime? _dateNaissance;
  String? _nationalite;
  String? _posteId;
  List<String> _postesSecondaires = [];
  String? _piedFort;
  DateTime? _dateInscription;
  String? _statut;
  String? _typeContrat;

  // Options disponibles
  final List<String> _nationalites = [
    'Camerounaise',
    'Française',
    'Ivoirienne',
    'Sénégalaise',
    'Marocaine',
    'Algérienne',
    'Tunisienne',
    'Congolaise',
    'Gabonaise',
    'Malienne'
  ];

  final List<String> _postes = [
    'Gardien',
    'Défenseur central',
    'Défenseur latéral',
    'Milieu défensif',
    'Milieu central',
    'Milieu offensif',
    'Ailier',
    'Attaquant'
  ];

  final List<String> _piedsForte = ['Droit', 'Gauche', 'Ambidextre'];
  final List<String> _statuts = ['Amateur', 'Professionnel'];
  final List<String> _typesContrat = ['CDI', 'CDD', 'Stagiaire', 'Prêt'];

  // Couleurs du thème
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color accentYellow = Color(0xFFFCD34D);
  static const Color lightColor = Color(0xFFF9FAFB);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _dateInscription = DateTime.now();
    _dateNaissance = DateTime.now();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    // Dispose tous les controllers
    _nomController.dispose();
    _prenomController.dispose();
    _adresseController.dispose();
    _telephoneController.dispose();
    _emailController.dispose();
    _contactUrgenceNomController.dispose();
    _contactUrgenceTelController.dispose();
    _tailleController.dispose();
    _poidsController.dispose();
    _numeroMaillotController.dispose();
    _numeroLicenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        title: const Text(
          'Inscription Joueur',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: accentYellow,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(
              icon: Icon(Icons.person),
              text: 'Personnel',
            ),
            Tab(
              icon: Icon(Icons.sports_soccer),
              text: 'Sportif',
            ),
            Tab(
              icon: Icon(Icons.admin_panel_settings),
              text: 'Administratif',
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPersonalSection(),
                  _buildSportsSection(),
                  _buildAdministrativeSection(),
                ],
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalSection() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Informations Personnelles', Icons.person),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _nomController,
                  label: 'Nom *',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le nom est obligatoire';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _prenomController,
                  label: 'Prénom *',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le prénom est obligatoire';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDatePicker(
            label: 'Date de naissance *',
            icon: Icons.calendar_today,
            selectedDate: _dateNaissance,
            onDateSelected: (date) => setState(() => _dateNaissance = date),
            validator: () {
              if (_dateNaissance == null) {
                return 'La date de naissance est obligatoire';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Nationalité *',
            icon: Icons.flag,
            value: _nationalite,
            items: _nationalites,
            onChanged: (value) => setState(() => _nationalite = value),
            validator: (value) {
              if (value == null) {
                return 'La nationalité est obligatoire';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _adresseController,
            label: 'Adresse *',
            icon: Icons.location_on,
            maxLines: 2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'L\'adresse est obligatoire';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _telephoneController,
                  label: 'Téléphone *',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le téléphone est obligatoire';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Contact d\'urgence', Icons.emergency),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _contactUrgenceNomController,
                  label: 'Nom du contact *',
                  icon: Icons.contact_emergency,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le contact d\'urgence est obligatoire';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _contactUrgenceTelController,
                  label: 'Téléphone *',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le téléphone du contact est obligatoire';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSportsSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Informations Sportives', Icons.sports_soccer),
          const SizedBox(height: 20),
          _buildDropdown(
            label: 'Poste principal *',
            icon: Icons.sports,
            value: _posteId,
            items: _postes,
            onChanged: (value) => setState(() => _posteId = value),
            validator: (value) {
              if (value == null) {
                return 'Le poste principal est obligatoire';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildMultiSelectDropdown(
            label: 'Postes secondaires',
            icon: Icons.sports_handball,
            selectedItems: _postesSecondaires,
            availableItems: _postes.where((p) => p != _posteId).toList(),
            onChanged: (items) => setState(() => _postesSecondaires = items),
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Pied fort *',
            icon: Icons.directions_run,
            value: _piedFort,
            items: _piedsForte,
            onChanged: (value) => setState(() => _piedFort = value),
            validator: (value) {
              if (value == null) {
                return 'Le pied fort est obligatoire';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _tailleController,
                  label: 'Taille (cm) *',
                  icon: Icons.height,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La taille est obligatoire';
                    }
                    int? taille = int.tryParse(value);
                    if (taille == null || taille < 140 || taille > 220) {
                      return 'Taille invalide (140-220cm)';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _poidsController,
                  label: 'Poids (kg) *',
                  icon: Icons.monitor_weight,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le poids est obligatoire';
                    }
                    int? poids = int.tryParse(value);
                    if (poids == null || poids < 40 || poids > 120) {
                      return 'Poids invalide (40-120kg)';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _numeroMaillotController,
            label: 'Numéro de maillot préféré',
            icon: Icons.sports_soccer,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                int? numero = int.tryParse(value);
                if (numero == null || numero < 1 || numero > 99) {
                  return 'Numéro invalide (1-99)';
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildAdministrativeSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
              'Données Administratives', Icons.admin_panel_settings),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _numeroLicenceController,
            label: 'Numéro de licence *',
            icon: Icons.badge,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Le numéro de licence est obligatoire';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildDatePicker(
            label: 'Date d\'inscription *',
            icon: Icons.calendar_today,
            selectedDate: _dateInscription,
            onDateSelected: (date) => setState(() => _dateInscription = date),
            validator: () {
              if (_dateInscription == null) {
                return 'La date d\'inscription est obligatoire';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Statut *',
            icon: Icons.person_pin,
            value: _statut,
            items: _statuts,
            onChanged: (value) => setState(() => _statut = value),
            validator: (value) {
              if (value == null) {
                return 'Le statut est obligatoire';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          if (_statut == 'Professionnel')
            _buildDropdown(
              label: 'Type de contrat *',
              icon: Icons.description,
              value: _typeContrat,
              items: _typesContrat,
              onChanged: (value) => setState(() => _typeContrat = value),
              validator: (value) {
                if (_statut == 'Professionnel' && value == null) {
                  return 'Le type de contrat est obligatoire';
                }
                return null;
              },
            ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryBlue, primaryBlue.withOpacity(0.8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: accentYellow, size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildMultiSelectDropdown({
    required String label,
    required IconData icon,
    required List<String> selectedItems,
    required List<String> availableItems,
    required void Function(List<String>) onChanged,
  }) {
    return InkWell(
      onTap: () => _showMultiSelectDialog(
        title: label,
        selectedItems: selectedItems,
        availableItems: availableItems,
        onChanged: onChanged,
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: primaryBlue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryBlue, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        child: Text(
          selectedItems.isEmpty
              ? 'Sélectionner les postes...'
              : selectedItems.join(', '),
          style: TextStyle(
            color: selectedItems.isEmpty ? Colors.grey[600] : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required IconData icon,
    required DateTime? selectedDate,
    required void Function(DateTime) onDateSelected,
    required String? Function() validator,
  }) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ??
              DateTime.now().subtract(const Duration(days: 6570)), // 18 ans
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: primaryBlue,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          onDateSelected(date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: primaryBlue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryBlue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          errorText: validator(),
        ),
        child: Text(
          selectedDate != null
              ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
              : 'Sélectionner une date...',
          style: TextStyle(
            color: selectedDate != null ? Colors.black87 : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_tabController.index > 0)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _tabController.animateTo(_tabController.index - 1);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Précédent'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            if (_tabController.index > 0) const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_tabController.index < 2) {
                    if (_validateCurrentTab()) {
                      _tabController.animateTo(_tabController.index + 1);
                    }
                  } else {
                    _submitForm();
                  }
                },
                icon: Icon(_tabController.index < 2
                    ? Icons.arrow_forward
                    : Icons.check),
                label: Text(_tabController.index < 2 ? 'Suivant' : 'Valider'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateCurrentTab() {
    switch (_tabController.index) {
      case 0:
        return _validatePersonalTab();
      case 1:
        return _validateSportsTab();
      case 2:
        return _validateAdministrativeTab();
      default:
        return false;
    }
  }

  bool _validatePersonalTab() {
    return _nomController.text.isNotEmpty &&
        _prenomController.text.isNotEmpty &&
        _dateNaissance != null &&
        _nationalite != null &&
        _adresseController.text.isNotEmpty &&
        _telephoneController.text.isNotEmpty &&
        _contactUrgenceNomController.text.isNotEmpty &&
        _contactUrgenceTelController.text.isNotEmpty;
  }

  bool _validateSportsTab() {
    return _posteId != null &&
        _piedFort != null &&
        _tailleController.text.isNotEmpty &&
        _poidsController.text.isNotEmpty;
  }

  bool _validateAdministrativeTab() {
    return _numeroLicenceController.text.isNotEmpty &&
        _dateInscription != null &&
        _statut != null &&
        (_statut != 'Professionnel' || _typeContrat != null);
  }

  void _showMultiSelectDialog({
    required String title,
    required List<String> selectedItems,
    required List<String> availableItems,
    required void Function(List<String>) onChanged,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        List<String> tempSelected = List.from(selectedItems);

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(title),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: availableItems.map((item) {
                    return CheckboxListTile(
                      title: Text(item),
                      value: tempSelected.contains(item),
                      activeColor: primaryBlue,
                      onChanged: (checked) {
                        setDialogState(() {
                          if (checked == true) {
                            tempSelected.add(item);
                          } else {
                            tempSelected.remove(item);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Annuler'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onChanged(tempSelected);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Valider'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _validateCurrentTab()) {
      // Ici vous pouvez traiter les données du formulaire
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Inscription réussie !'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      // Navigation vers la page suivante ou retour
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const PlayerHomePage(), // Votre page d'inscription
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez remplir tous les champs obligatoires'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}