import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class CertFormPage extends StatefulWidget {
  const CertFormPage({super.key});

  @override
  State<CertFormPage> createState() => _CertFormPageState();
}

class _CertFormPageState extends State<CertFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _yearController;

  String _courseName = "";
  String _publisher = "";
  String _verifLink = "";
  String _yearPublished = "";

  @override
  void initState() {
    super.initState();
    _yearPublished = DateTime.now().year.toString();
    _yearController = TextEditingController(text: _yearPublished);
  }

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Form Tambah Sertifikasi')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Cert Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Course",
                    labelText: "Course",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _courseName = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama course tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Publisher ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Penerbit",
                    labelText: "Penerbit",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _publisher = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama penerbit tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Year Published ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _yearController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Tahun terbit",
                    labelText: "Tahun",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now(),
                    );
                    setState(() {
                      _yearPublished = pickedDate!.year.toString();
                      _yearController.text = _yearPublished;
                    });
                  },
                ),
              ),

              // === Verification Link ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Link Verifikasi (opsional)",
                    labelText: "Link Verifikasi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _verifLink = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value != null) {
                      final uri = Uri.tryParse(value);
                      if (uri == null ||
                          !uri.hasScheme ||
                          uri.host.isEmpty ||
                          (uri.scheme != 'http' && uri.scheme != 'https')) {
                        return "Link tidak valid!";
                      }
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Sertifikasi berhasil ditambahkan!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Course: $_courseName'),
                                    Text('Penerbit: $_publisher'),
                                    Text('Tahun Terbit: $_yearPublished'),
                                    if (_verifLink.trim().isNotEmpty)
                                      Text('Tautan: $_verifLink'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
