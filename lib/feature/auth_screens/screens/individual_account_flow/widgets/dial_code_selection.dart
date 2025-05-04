import 'package:flutter/material.dart';

class DialCodeSelectionScreen extends StatefulWidget {
  const DialCodeSelectionScreen({super.key});

  @override
  State<DialCodeSelectionScreen> createState() =>
      _DialCodeSelectionScreenState();
}

class _DialCodeSelectionScreenState extends State<DialCodeSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredCountries = [];
  final List<Map<String, dynamic>> _countries = [
    {'name': 'Afghanistan', 'flag': '🇦🇫', 'code': '+93'},
    {'name': 'Albania', 'flag': '🇦🇱', 'code': '+355'},
    {'name': 'Algeria', 'flag': '🇩🇿', 'code': '+213'},
    {'name': 'American Samoa', 'flag': '🇦🇸', 'code': '+1-684'},
    {'name': 'Andorra', 'flag': '🇦🇩', 'code': '+376'},
    {'name': 'Angola', 'flag': '🇦🇴', 'code': '+244'},
    {'name': 'Anguilla', 'flag': '🇦🇮', 'code': '+1-264'},
    {'name': 'Antigua and Barbuda', 'flag': '🇦🇬', 'code': '+1-268'},
    {'name': 'Argentina', 'flag': '🇦🇷', 'code': '+54'},
    // Add more countries as needed
  ];

  @override
  void initState() {
    super.initState();
    _filteredCountries = List.from(_countries);
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCountries);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCountries = _countries
          .where((country) =>
              country['name'].toLowerCase().contains(query) ||
              country['code'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // Header with progress bar
            Container(
              color: const Color(0xFF121212),
              child: Column(
                children: [
                  // App bar
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),

                  // Progress bar
                  Container(
                    height: 4,
                    width: double.infinity,
                    color: Colors.grey[800],
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.4, // 40% progress
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.purple[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main content
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Title
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Text(
                            'Dial code',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Search bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            prefixIcon:
                                Icon(Icons.search, color: Colors.grey[500]),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Country list with dial codes
                    Expanded(
                      child: ListView.builder(
                        itemCount: _filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = _filteredCountries[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pop(context, country);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      country['flag'],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    country['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    country['code'],
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
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
              ),
            ),

            // Bottom home indicator
            Container(
              width: 134,
              height: 5,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
