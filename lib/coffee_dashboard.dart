import 'package:flutter/material.dart';
import 'coffee.dart';

class CoffeeDashboard extends StatefulWidget {
  const CoffeeDashboard({super.key});

  @override
  State<CoffeeDashboard> createState() => _CoffeeDashboardState();
}

class _CoffeeDashboardState extends State<CoffeeDashboard> {
  // 1. Ephemeral State: Our list of coffees loaded with test data
  final List<Coffee> _coffees = [
    Coffee(
      id: '1',
      name: 'Ethiopia Gagio',
      roaster: 'Trader Joes',
      roastLevel: 'Light',
      process: 'Washed',
      brews: 1,
      notes: 'Bright, blueberry up front, a little thin at the end.',
    ),
    Coffee(
      id: '2',
      name: 'test 2',
      roaster: 'b and b',
      roastLevel: 'Light',
      process: 'washed',
      brews: 0,
      notes: 'notes test 2',
    ),
  ];

  // 2. Form Controllers: These read the text typed into the inputs
  final _nameController = TextEditingController();
  final _roasterController = TextEditingController();
  final _processController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedRoast = 'Light';
  final List<String> _roastOptions = ['Light', 'Medium', 'Dark'];

  // Tracks if we are editing an existing coffee or adding a new one
  String? _editingCoffeeId;

  // Maps roast levels to specific colors for the card banners
  Color _getRoastColor(String roast) {
    switch (roast.toLowerCase()) {
      case 'light': return const Color(0xFFD4A373); // Golden brown
      case 'medium': return const Color(0xFFA0522D); // Sienna
      case 'dark': return const Color(0xFF3E2723); // Dark brown
      default: return const Color(0xFFD4A373);
    }
  }

  // 3. Add Method: Grabs values from controllers, updates state, and clears form
  // Populates the form with existing coffee data
  void _startEdit(Coffee coffee) {
    setState(() {
      _editingCoffeeId = coffee.id;
      _nameController.text = coffee.name;
      _roasterController.text = coffee.roaster;
      _selectedRoast = _roastOptions.contains(coffee.roastLevel) ? coffee.roastLevel : 'Light';
      _processController.text = coffee.process;
      _notesController.text = coffee.notes;
    });
  }

  // Handles both creating new coffees and updating existing ones
  void _saveCoffee() {
    if (_nameController.text.isEmpty) return;

    setState(() {
      final newCoffee = Coffee(
        id: _editingCoffeeId ?? DateTime.now().toString(),
        name: _nameController.text,
        roaster: _roasterController.text,
        roastLevel: _selectedRoast,
        process: _processController.text,
        notes: _notesController.text,
      );

      if (_editingCoffeeId == null) {
        // Add new
        _coffees.add(newCoffee);
      } else {
        // Update existing
        final index = _coffees.indexWhere((c) => c.id == _editingCoffeeId);
        if (index != -1) _coffees[index] = newCoffee;
        _editingCoffeeId = null; // Exit edit mode
      }
    });

    // Clear the form
    _nameController.clear();
    _roasterController.clear();
    _processController.clear();
    _notesController.clear();
    _selectedRoast = 'Light';
  }

  // 4. Delete Method
  void _deleteCoffee(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Coffee'),
          content: const Text('Are you sure you want to delete this coffee?'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _coffees.removeWhere((coffee) => coffee.id == id);
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(foregroundColor: const Color(0xFFD32F2F)),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }


  // UI Build method goes here (Step 3)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EFE6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E2723),
        title: const Text('Pour Overs', style: TextStyle(color: Color(0xFFD4A373), fontWeight: FontWeight.bold)),
      ),
      // SingleChildScrollView allows the screen to scroll if the form or list gets too long
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            const Text(
              'Coffees',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, fontFamily: 'Georgia', color: Color(0xFF2D2323)),
            ),
            const SizedBox(height: 8),
            const Text(
              "The beans you've bought, so you know what's in the cupboard and how you brewed it.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 32),

            // Coffee Cards Grid (Wrap automatically handles moving to the next line on smaller screens)
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _coffees.map((coffee) => _buildCoffeeCard(coffee)).toList(),
            ),
            const SizedBox(height: 48),

            // Add Coffee Form
            _buildAddForm(),
          ],
        ),
      ),
    );
  }

  // --- UI HELPER METHODS ---

  Widget _buildCoffeeCard(Coffee coffee) {
    return Container(
      width: 250,
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          // Uses the dynamic color helper here
          top: BorderSide(color: _getRoastColor(coffee.roastLevel), width: 4),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(coffee.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Georgia')),
          Text(coffee.roaster, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),

          _buildDetailRow('Roast', coffee.roastLevel),
          _buildDetailRow('Process', coffee.process),
          _buildDetailRow('Brews', coffee.brews.toString()),
          const SizedBox(height: 12),

          Expanded(
            child: Text(
              coffee.notes,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
              overflow: TextOverflow.fade,
            ),
          ),

          // Updated bottom row for Edit and Delete
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => _startEdit(coffee),
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF3E2723)),
                child: const Text('Edit'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () => _deleteCoffee(coffee.id),
                style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD32F2F),
                    side: const BorderSide(color: Color(0xFFD32F2F)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                ),
                child: const Text('Delete'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey))),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAddForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('- Add a coffee', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF4A3B32))),
          const SizedBox(height: 24),

          // Wrap allows the form to reflow cleanly on mobile emulators or desktop windows
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(width: 200, child: _buildInput('Coffee', _nameController)),
              SizedBox(width: 200, child: _buildInput('Roaster', _roasterController)),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Roast Level', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedRoast,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      ),
                      items: _roastOptions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                      onChanged: (v) => setState(() => _selectedRoast = v!),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 200, child: _buildInput('Process', _processController)),
            ],
          ),
          const SizedBox(height: 16),

          _buildInput('Coffee notes', _notesController, maxLines: 3),
          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: _saveCoffee,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E2723),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
            ),
            // Dynamic text label
            child: Text(_editingCoffeeId == null ? 'Save Coffee' : 'Update Coffee'),
          )
        ],
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}