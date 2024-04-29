import 'dart:convert';

void main() {
  // Data transkrip mahasiswa dalam bentuk JSON
  String transkripJson = '''
  {
    "nama": "Nurul Izzah",
    "mata_kuliah": [
      {
        "kode": "PM109",
        "nama": "Pemrograman Mobile",
        "sks": 3,
        "nilai": "A"
      },
      {
        "kode": "TK102",
        "nama": "Tata Kelola Teknologi Informasi",
        "sks": 4,
        "nilai": "A-"
      },
      {
        "kode": "IMK103",
        "nama": "Interaksi Manusia Komputer",
        "sks": 3,
        "nilai": "A"
      }
    ]
  }
  ''';

  // Decode JSON menjadi Map
  Map<String, dynamic> transkripMap = jsonDecode(transkripJson);

  // Menghitung IPK
  double ipk = hitungIPK(transkripMap['mata_kuliah']);
  
  // Menampilkan hasil
  print("Nama: ${transkripMap['nama']}");
  print("IPK: ${ipk.toStringAsFixed(2)}");
}

// Fungsi untuk menghitung IPK berdasarkan transkrip mata kuliah
double hitungIPK(List<dynamic> mataKuliah) {
  double totalSKS = 0;
  double totalBobot = 0;

  for (var matkul in mataKuliah) {
    int sks = matkul['sks'];
    String nilai = matkul['nilai'];

    // Menghitung bobot berdasarkan nilai
    double bobot;
    if (nilai == 'A') {
      bobot = 4.0;
    } else if (nilai == 'A-') {
      bobot = 3.7;
    } else if (nilai == 'B+') {
      bobot = 3.3;
    } else if (nilai == 'B') {
      bobot = 3.0;
    } else if (nilai == 'B-') {
      bobot = 2.7;
    } else if (nilai == 'C+') {
      bobot = 2.3;
    } else if (nilai == 'C') {
      bobot = 2.0;
    } else if (nilai == 'C-') {
      bobot = 1.7;
    } else if (nilai == 'D') {
      bobot = 1.0;
    } else {
      bobot = 0.0;
    }

    // Menambahkan total SKS dan bobot nilai
    totalSKS += sks;
    totalBobot += (sks * bobot);
  }

  // Menghitung IPK
  double ipk = totalBobot / totalSKS;
  return ipk;
}
