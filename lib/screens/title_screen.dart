import 'package:flutter/material.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  int _currentIndex = 0;

  // Liste des 3 écrans demandés dans l'énoncé de l'atelier
  final List<Widget> _screens = [
    const EcheancesScreen(),
    const DetailScreen(),
    const FormulaireScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusFlow'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: _screens[_currentIndex],
      // NavigationBar demandée dans l'énoncé du premier écran
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Échéances',
          ),
          NavigationDestination(
            icon: Icon(Icons.description_rounded),
            label: 'Détail',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note_rounded),
            label: 'Formulaire',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 1. ÉCRAN ÉCHÉANCES (Scaffold, ListView.builder, ListTile, FloatingActionButton)
// ==========================================
class EcheancesScreen extends StatelessWidget {
  const EcheancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste d'exemples d'échéances pour les étudiants
    final List<Map<String, String>> echeances = [
      {'titre': 'Rendu Projet Intégrateur', 'date': 'Devant le jury - 15 min'},
      {'titre': 'Atelier Programmation Mobile', 'date': 'Lien GitHub à envoyer'},
      {'titre': 'Examen Base de Données', 'date': 'Lundi à 08:00'},
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: echeances.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notification_important, color: Colors.redAccent),
            title: Text(echeances[index]['titre']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(echeances[index]['date']!),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// ==========================================
// 2. ÉCRAN DÉTAIL (Column, Card, FilledButton "Marquer comme fait")
// ==========================================
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Détail de la tâche',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  SizedBox(height: 12),
                  Text('Module : Programmation Mobile (Flutter)', style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Text('Description : Finaliser l\'atelier des trois écrans de CampusFlow, s\'assurer de l\'absence d\'erreurs et pousser le code sur le dépôt GitHub.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tâche marquée comme faite !')),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Marquer comme fait'),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3. ÉCRAN FORMULAIRE (Form, TextFormField, validator, SnackBar)
// ==========================================
class FormulaireScreen extends StatefulWidget {
  const FormulaireScreen({super.key});

  @override
  State<FormulaireScreen> createState() => _FormulaireScreenState();
}

class _FormulaireScreenState extends State<FormulaireScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ajouter une échéance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Intitulé de l\'échéance',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer un titre valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Échéance "${_titleController.text}" ajoutée !')),
                  );
                  _titleController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Valider le formulaire'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}