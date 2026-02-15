import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> history;
  final Function(Map<String, dynamic>) onRouteClicked;

  const HistoryPage({
    super.key,
    required this.history,
    required this.onRouteClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.green,
            width: 3,
          ),
        ),
        title: Center(
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,
            height: 35,
          ),
        ),
      ),
      body: history.isEmpty
          ? const Center(
              child: Text("No history yet.",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  )))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final route = history[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.history, color: Colors.green),
                    title: Text("${route['startName']} ➝ ${route['endName']}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      onRouteClicked(route);
                    },
                  ),
                );
              },
            ),
    );
  }
}
