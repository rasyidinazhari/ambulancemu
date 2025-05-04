import 'package:flutter/material.dart';
import 'dart:async';

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

class MenuItem {
  final IconData icon;
  final String title;
  MenuItem({required this.icon, required this.title});
}

class Campaign {
  final String title;
  final String imageUrl;
  final String description;
  final int targetAmount;
  final int currentAmount;
  final int donors;

  Campaign({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.targetAmount,
    required this.currentAmount,
    required this.donors,
  });
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

  final List<Campaign> campaigns = [
    Campaign(
      title: "Bantu Renovasi Sekolah",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc8cqm1FZBs9YGD3rd9gtLpsESsboZS8gLwg&s",
      description:
          "Ayo bantu renovasi sekolah di daerah terpencil agar anak-anak bisa belajar dengan nyaman.",
      targetAmount: 100000000,
      currentAmount: 45000000,
      donors: 120,
    ),
    Campaign(
      title: "Donasi untuk Korban Banjir",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBWCivYOWIZcdlT-YJOmywORVbg6QfZKVAyg&s",
      description:
          "Banjir bandang melanda daerah selatan, ribuan keluarga butuh bantuan segera.",
      targetAmount: 150000000,
      currentAmount: 80000000,
      donors: 220,
    ),
    Campaign(
      title: "Modal Usaha UMKM",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfFpa-HND6Q1p2y8Xy8qdGERcK15rk7Fjpiw&s",
      description:
          "Banjir bandang melanda daerah selatan, ribuan keluarga butuh bantuan segera.",
      targetAmount: 150000000,
      currentAmount: 80000000,
      donors: 220,
    ),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ20B5JR1oB4StAQfsYO7O6DgQqAKOhvAJagw&s",
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
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
          Text(
            "Campaign Populer",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Column(
            children:
                campaigns.map((camp) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CampaignDetailPage(campaign: camp),
                        ),
                      );
                    },
                    child: Card(
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
                              camp.imageUrl,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              camp.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
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

class CampaignDetailPage extends StatefulWidget {
  final Campaign campaign;

  const CampaignDetailPage({required this.campaign});

  @override
  _CampaignDetailPageState createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> {
  late int currentAmount;
  late int donors;
  late double progress;

  @override
  void initState() {
    super.initState();
    currentAmount = widget.campaign.currentAmount;
    donors = widget.campaign.donors;
    progress = currentAmount / widget.campaign.targetAmount;

    // Simulasi update real-time setiap 5 detik
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted && currentAmount < widget.campaign.targetAmount) {
        setState(() {
          currentAmount += 100000; // Simulasi tambahan donasi
          donors += 1;
          progress = currentAmount / widget.campaign.targetAmount;
          if (currentAmount > widget.campaign.targetAmount) {
            currentAmount = widget.campaign.targetAmount;
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.campaign.title)),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.campaign.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Text(
            widget.campaign.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(widget.campaign.description),
          SizedBox(height: 20),
          Text(
            "Statistik Donasi (Realtime)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 10,
          ),
          SizedBox(height: 10),
          Text(
            "Terkumpul: Rp $currentAmount / Rp ${widget.campaign.targetAmount}",
          ),
          Text("Donatur: $donors orang"),
          Text("Pencapaian: ${(progress * 100).toStringAsFixed(1)}%"),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Fitur donasi coming soon!')),
              );
            },
            icon: Icon(Icons.volunteer_activism),
            label: Text("Donasi Sekarang"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 12),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
