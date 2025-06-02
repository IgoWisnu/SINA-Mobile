class WaktuFormatter {
  /// Mengubah format waktu dari 'HH.mm.ss' menjadi 'HH.mm'
  static String format(String waktu) {
    final parts = waktu.split(':');
    if (parts.length >= 2) {
      return '${parts[0]}:${parts[1]}';
    }
    return waktu;
  }
}
