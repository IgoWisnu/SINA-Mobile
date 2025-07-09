import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/Lib/DateFormatter.dart';
import 'package:sina_mobile/View/Murid/DetailMateriMurid.dart';
import 'package:sina_mobile/View/TugasDetailView.dart';

class ItemTugasMurid extends StatelessWidget {
  final Tugas tugas;
  final VoidCallback onTap;

  const ItemTugasMurid({
    super.key,
    required this.tugas,
    required this.onTap
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
                  Text(tugas.namaTugas, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("20/28")
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(Icons.arrow_upward_outlined),
                  const SizedBox(width: 5),
                  Text(DateFormatter.format(tugas.createAt ?? DateTime.now())),
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
                      Text(DateFormatter.format(tugas.tenggatKumpul ?? DateTime.now())),
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
              if (tugas.status.toLowerCase() == "done" && tugas.nilai != null) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                       children: [
                         Icon(Icons.check_circle, color: Colors.green),
                         SizedBox(width: 8),
                         Text(
                           "Sudah Dinilai",
                           style: TextStyle(color: AppColors.blueActive, fontWeight: FontWeight.bold),
                         ),
                       ],
                      ),
                      Text('${tugas.nilai}/100' ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.blueActive),)
                    ],
                  ),
                ),
              ],
              if (tugas.status.toLowerCase() == "done" && tugas.nilai == null) ...[
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