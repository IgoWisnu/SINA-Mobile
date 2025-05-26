import 'package:flutter/material.dart';
import 'package:html/parser.dart'; // Untuk parse HTML
import 'package:sina_mobile/Model/Berita.dart';
import 'package:sina_mobile/View/Lib/DateFormatter.dart';

class CardPengumuman extends StatefulWidget {
  final VoidCallback Action;
  final Berita berita;

  const CardPengumuman({super.key, required this.Action, required this.berita});

  @override
  State<CardPengumuman> createState() => _CardPengumumanState();
}

class _CardPengumumanState extends State<CardPengumuman> {
  String baseImageUrl = 'http://sina.pnb.ac.id:3000/Upload/berita/';

  /// Membersihkan HTML dan memotong isi hingga `limit` karakter
  String stripHtmlAndLimit(String htmlText, int limit) {
    final document = parse(htmlText);
    final String parsedString = parse(document.body?.text).documentElement?.text ?? '';
    if (parsedString.length <= limit) {
      return parsedString;
    } else {
      return parsedString.substring(0, limit) + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.Action,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      '$baseImageUrl${widget.berita.foto}',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'lib/asset/image/SINA.png',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.berita.judul,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  stripHtmlAndLimit(widget.berita.isi, 100),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    DateFormatter.format(widget.berita.createdAt),
                    style: const TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}