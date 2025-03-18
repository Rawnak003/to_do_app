import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key, required this.title, required this.subtitle, required this.date, required this.status, required this.index, required this.chipColor,
  });

  final String title;
  final String subtitle;
  final List<String> date;
  final String status;
  final int index;
  final Color chipColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.whiteColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18,fontWeight: FontWeight.w600),),
            Text(subtitle),
            Text("Date: ${date[index]}"),
            Row(
              children: [
                Chip(
                  label: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: chipColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide.none,
                  ),
                ),
                const Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit,)),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: AppColor.primaryColor,)),
              ],
            )
          ],
        ),
      ),
    );
  }
}