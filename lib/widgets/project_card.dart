import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/cert_form.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  final Color color;

  const ItemCard(this.item, {super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
    return Material(
      // Menggunakan warna sekunder dari skema tema aplikasi.
      color: (item.color != null) ? item.color : color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Aksi ketika kartu ditekan oleh pengguna.
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );

          // Navigate ke halaman yang sesuai
          if (item.name == "Tambah Proyek") {
            if (!await ensureLoggedIn(context)) return;
            if (!context.mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProjectFormPage()),
            );
          } else if (item.name == "Tambah Sertifikasi") {
            if (!await ensureLoggedIn(context)) return;
            if (!context.mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CertFormPage()),
            );
          } else if (item.name == "Logout") {
            if (isLoggedIn) context.read<AuthState>().logout();
          } else if (item.name == "Login") {
            if (!isLoggedIn) await ensureLoggedIn(context);
          } else if (item.name == "Lihat Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProjectListScreen(),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
