import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/Lib/DateFormatter.dart';
import 'package:sina_mobile/View/Murid/DetailMateriMurid.dart';
import 'package:sina_mobile/View/TugasDetail.dart';

class ItemTugasMurid extends StatelessWidget {
  final String judul;
  final DateTime upload_date;
  final DateTime tenggat;
  final VoidCallback onTap;
  final String status;

  const ItemTugasMurid({
    super.key,
    required this.judul,
    required this.upload_date,
    required this.tenggat,
    required this.onTap,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(judul, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("20/28")
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(Icons.arrow_upward_outlined),
                  const SizedBox(width: 5),
                  Text(DateFormatter.format(upload_date)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      const SizedBox(width: 5),
                      Text(DateFormatter.format(tenggat)),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Tugas", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              if (status.toLowerCase() == "done") ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        "Sudah Dikumpul",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}