import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/pdf.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  int _selectedIndex = 0;

  final List<Map<String, String>> katalogItems = [
    {
      'name': 'T-Shirt',
      'image': 'assets_images/shirtt.jpeg',
      'price': 'Rp.100000',
      'desc': 'Kaos santai bahan adem cocok untuk aktivitas harian.'
    },
    {
      'name': 'Dress',
      'image': 'assets_images/dress.jpeg',
      'price': 'Rp.150000',
      'desc': 'Dress elegan untuk tampilan feminin di berbagai acara.'
    },
    {
      'name': 'Jacket',
      'image': 'assets_images/jacket.jpeg',
      'price': 'Rp.100000',
      'desc': 'Jaket tebal cocok untuk musim dingin atau bepergian malam.'
    },
    {
      'name': 'Jeans',
      'image': 'assets_images/jeans.jpeg',
      'price': 'Rp.100000',
      'desc': 'Celana jeans modis cocok untuk gaya kasual sehari-hari.'
    },
    {
      'name': 'Skirt',
      'image': 'assets_images/skirt.jpeg',
      'price': 'Rp.80000',
      'desc': 'Rok simple dengan potongan elegan dan feminim.'
    },
    {
      'name': 'Outer Kimono',
      'image': 'assets_images/outer.jpeg',
      'price': 'Rp.95000',
      'desc': 'Outer kimono flowy yang stylish dan nyaman dipakai.'
    },
    {
      'name': 'Blouse',
      'image': 'assets_images/blouse.jpeg',
      'price': 'Rp.120000',
      'desc': 'Blouse casual dengan potongan modern dan trendy.'
    },
    {
      'name': 'Hodie',
      'image': 'assets_images/hodie.jpeg',
      'price': 'Rp.140000',
      'desc': 'Hoodie hangat dan nyaman untuk tampilan santai.'
    },
    {
      'name': 'Cardigan',
      'image': 'assets_images/cardigan.jpeg',
      'price': 'Rp.130000',
      'desc': 'Cardigan rajut yang ringan untuk cuaca sejuk.'
    },
    {
      'name': 'Kemeja Flanel',
      'image': 'assets_images/kemeja.jpeg',
      'price': 'Rp.110000',
      'desc': 'Kemeja flanel hangat dengan motif kotak klasik.'
    },
    {
      'name': 'Blouse Lengan Panjang',
      'image': 'assets_images/blose.jpeg',
      'price': 'Rp.120000',
      'desc': 'Blouse panjang elegan untuk suasana formal maupun santai.'
    },
    {
      'name': 'Gamis Casual',
      'image': 'assets_images/gamis.jpeg',
      'price': 'Rp.160000',
      'desc': 'Gamis longgar dan nyaman cocok untuk sehari-hari.'
    },
    {
      'name': 'Tunik',
      'image': 'assets_images/tunik.jpeg',
      'price': 'Rp.130000',
      'desc': 'Tunik simple cocok untuk dipadukan dengan celana panjang.'
    },
    {
      'name': 'Kemeja Lengan Panjang',
      'image': 'assets_images/kemejaa.jpeg',
      'price': 'Rp.110000',
      'desc': 'Kemeja formal untuk tampilan rapi dan profesional.'
    },
    {
      'name': 'Kaftan Modern',
      'image': 'assets_images/kaftan.jpeg',
      'price': 'Rp.150000',
      'desc': 'Kaftan elegan dengan aksen modern untuk acara spesial.'
    },
    {
      'name': 'Long Dress',
      'image': 'assets_images/dres.jpeg',
      'price': 'Rp.140000',
      'desc': 'Long dress flowy dengan desain feminin dan lembut.'
    },
    {
      'name': 'Setelan Rok Panjang & Atasan Lengan Panjang',
      'image': 'assets_images/rok.jpeg',
      'price': 'Rp.170000',
      'desc': 'Setelan anggun dengan bahan nyaman dan adem.'
    },
    {
      'name': 'Setelan Baju Basket',
      'image': 'assets_images/basket.jpeg',
      'price': 'Rp.140000',
      'desc': 'Set olahraga basket yang ringan dan menyerap keringat.'
    },
    {
      'name': 'Seragam Pramuka',
      'image': 'assets_images/seragam.jpeg',
      'price': 'Rp.180000',
      'desc': 'Seragam pramuka lengkap untuk siswa dan siswi.'
    },
    {
      'name': 'Piyama',
      'image': 'assets_images/piyama.jpeg',
      'price': 'Rp.100000',
      'desc': 'Piyama lembut untuk tidur nyenyak dan nyaman.'
    },
    {
      'name': 'Kulot',
      'image': 'assets_images/kulot.jpeg',
      'price': 'Rp.90000',
      'desc': 'Celana kulot longgar dan stylish cocok untuk santai.'
    },
  ];

  final List<Map<String, dynamic>> cartItems = [];
  final List<Map<String, dynamic>> selectedItems = [];

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addToCart(Map<String, String> item) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (element) => element['name'] == item['name'],
        orElse: () => {},
      );
      if (existingItem.isNotEmpty) {
        existingItem['quantity'] += 1;
      } else {
        cartItems.add({
          'name': item['name'],
          'image': item['image'],
          'price': item['price'],
          'desc': item['desc'],
          'quantity': 1,
          'selected': false,
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['name']} ditambahkan ke keranjang!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget _buildCatalogPage() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Catalog Produk Fashion',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.pink[700],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              itemCount: katalogItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.45,
              ),
              itemBuilder: (context, index) {
                final item = katalogItems[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                item['image'] ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 6,
                            bottom: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.local_offer,
                                      color: Colors.pinkAccent, size: 14),
                                  const SizedBox(width: 3),
                                  Text(
                                    "Best Price",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] ?? '',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.pink,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item['price'] ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              item['desc'] ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey[800],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                icon: const Icon(Icons.add_shopping_cart,
                                    color: Colors.pinkAccent),
                                onPressed: () {
                                  _addToCart(item);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartPage() {
    if (cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined,
                size: 60, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              "Keranjang belanja kosong",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: Image.asset(
                    item['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['price']),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                if (item['quantity'] > 1) {
                                  item['quantity'] -= 1;
                                } else {
                                  cartItems.removeAt(index);
                                  selectedItems.remove(item);
                                }
                              });
                            },
                          ),
                          Text(item['quantity'].toString()),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                item['quantity'] += 1;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: item['selected'] ?? false,
                        onChanged: (value) {
                          setState(() {
                            item['selected'] = value;
                            if (value!) {
                              selectedItems.add(item);
                            } else {
                              selectedItems.remove(item);
                            }
                          });
                        },
                        activeColor: Colors.pinkAccent,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            cartItems.removeAt(index);
                            selectedItems.remove(item);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (selectedItems.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaymentPage(selectedItems: selectedItems),
                  ),
                );
              },
              child: Text(
                "Checkout (${selectedItems.length})",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildCatalogPage(),
      _buildCartPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Toko Baju'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pinkAccent,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Katalog"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Keranjang"),
        ],
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  const PaymentPage({super.key, required this.selectedItems});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedPaymentMethod = 'Dana';

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  int getTotalPrice() {
    return widget.selectedItems.fold(0, (sum, item) {
      int price = int.tryParse(
              item['price'].toString().replaceAll(RegExp(r'[^0-9]'), '')) ??
          0;
      int quantity = item['quantity'] ?? 1;
      return sum + (price * quantity);
    });
  }

  Future<void> _openMaps() async {
    final address = _addressController.text;
    final url =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$address');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _generateReceipt() async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('TOKO BAJU',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('Struk Pembayaran',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),
              pw.Text('Nama: ${_nameController.text}'),
              pw.Text('Alamat: ${_addressController.text}'),
              pw.Text('No. Telp: ${_phoneController.text}'),
              pw.Text('Metode Pembayaran: $_selectedPaymentMethod'),
              pw.SizedBox(height: 20),
              pw.Text('Detail Pembelian:',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              ...widget.selectedItems.map((item) {
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('${item['name']} (${item['quantity']}x)'),
                    pw.Text(item['price']),
                  ],
                );
              }).toList(),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Rp${getTotalPrice()}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Center(
                child: pw.Text('Terima kasih telah berbelanja!',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informasi Pembeli',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan nama lengkap';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Alamat Pengiriman',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.location_on),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.map),
                    onPressed: _openMaps,
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan alamat pengiriman';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan nomor telepon';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Nomor telepon hanya boleh berisi angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Metode Pembayaran',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.payment),
                ),
                items: <String>['Dana', 'OVO', 'Gopay', 'Transfer Bank', 'COD']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPaymentMethod = newValue!;
                  });
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Ringkasan Pesanan',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      ...widget.selectedItems.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${item['name']} (${item['quantity']}x)'),
                              Text(item['price']),
                            ],
                          ),
                        );
                      }).toList(),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold)),
                          Text('Rp${getTotalPrice()}',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _generateReceipt();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuccessPage(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Bayar Sekarang',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("Pesanan Berhasil"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            Text(
              "Pembayaran Berhasil!",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Terima kasih telah berbelanja di Toko Baju kami",
              style: GoogleFonts.poppins(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text(
                "Kembali ke Beranda",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
