import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

class MyHomePageScreen extends StatelessWidget {
  MyHomePageScreen({super.key});

  final String npm = "2506544990";
  final String nama = "Elvis";
  final String kelas = "PBP B";
  final Color authColor = Colors.greenAccent[700]!;

  final List<ItemHomepage> auth = [
    ItemHomepage("Login", Icons.login),
    ItemHomepage("Logout", Icons.logout),
  ];

  final List<ItemHomepage> items = [
    ItemHomepage("Lihat Proyek", Icons.folder),
    ItemHomepage.colorTambah("Tambah Proyek", Icons.add_circle),
    ItemHomepage("Lihat Sertifikasi", Icons.folder),
    ItemHomepage.colorTambah("Tambah Sertifikasi", Icons.add_circle),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur visual dasar halaman (AppBar, Body, SnackBar).
    return Scaffold(
      // AppBar menampilkan bar bagian atas halaman aplikasi.
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),
      // Body halaman utama dengan padding di sekelilingnya.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Baris horizontal untuk menampilkan 3 InfoCard secara sejajar.
            Row(
              children: [
                Expanded(child: InfoCard(title: 'NPM', content: npm)),
                const SizedBox(width: 8),
                Expanded(child: InfoCard(title: 'Name', content: nama)),
                const SizedBox(width: 8),
                Expanded(child: InfoCard(title: 'Class', content: kelas)),
              ],
            ),

            const SizedBox(height: 16.0),

            // Bagian tengah: pesan sambutan dan kisi tombol menu portofolio.
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: auth.map((ItemHomepage item) {
                        return SizedBox(
                          width: 110,
                          height: 110,
                          child: ItemCard(item, color: authColor),
                        );
                      }).toList(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 10,
                      children: items.map((ItemHomepage item) {
                        return SizedBox(
                          width: 200,
                          height: 70,
                          child: ItemCard(
                            item,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  // Kartu informasi yang menampilkan judul (title) dan isi (content).
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  Color? color;

  ItemHomepage(this.name, this.icon);

  ItemHomepage.colorTambah(this.name, this.icon)
    : color = Colors.redAccent[400];

  ItemHomepage.customColor(this.name, this.icon, this.color);
}
