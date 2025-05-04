import 'package:flutter/material.dart';

void main() => runApp(CrowdFundingApp());

class CrowdFundingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrowdFunding SuperApp',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem(icon: Icons.category, title: 'Kategori'),
    MenuItem(icon: Icons.favorite, title: 'Donasi Saya'),
    MenuItem(icon: Icons.account_balance_wallet, title: 'Dompet'),
    MenuItem(icon: Icons.people, title: 'Komunitas'),
    MenuItem(icon: Icons.history, title: 'Riwayat'),
    MenuItem(icon: Icons.share, title: 'Bagikan'),
  ];

  final List<Map<String, String>> campaigns = [
    {
      "title": "Bantu Renovasi Sekolah",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc8cqm1FZBs9YGD3rd9gtLpsESsboZS8gLwg&s",
    },
    {
      "title": "Donasi untuk Korban Banjir",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBWCivYOWIZcdlT-YJOmywORVbg6QfZKVAyg&s",
    },
    {
      "title": "Modal Usaha UMKM",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfFpa-HND6Q1p2y8Xy8qdGERcK15rk7Fjpiw&s",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lazismu"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Banner
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ20B5JR1oB4StAQfsYO7O6DgQqAKOhvAJagw&s",
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),

          // Menu Grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: menuItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 3 / 3.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.orange[100],
                    radius: 28,
                    child: Icon(item.icon, color: Colors.orange[700], size: 28),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.title,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 20),

          // List Campaign Populer
          Text(
            "Campaign Populer",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Column(
            children:
                campaigns.map((camp) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            camp['image']!,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            camp['title']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;
  MenuItem({required this.icon, required this.title});
}
