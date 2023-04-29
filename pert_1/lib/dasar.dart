//membuat fungsi
// String intro(String name, String kelas, int angkatan) {
//   return "Halo namaku $name dari kelas $kelas angkatan $angkatan";
//   //variabel ditengah string langsung dipanggil dengan $ diikuti nama variabel
// }

//null safety
String intro(String firstName, String? lastName, String kelas, int angkatan) {
  if (lastName != null) {
    return "Halo namaku $firstName $lastName dari kelas $kelas angkatan $angkatan";
  } else {
    return "Halo namaku $firstName dari kelas $kelas angkatan $angkatan";
  }
  //variabel ditengah string langsung dipanggil dengan $ diikuti nama variabel
}

void main() {
  //inisialisasi variabel
  int a = 2;
  String name;
  bool isLogin;
  double b = 1.2;
}
