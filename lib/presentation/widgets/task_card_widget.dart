import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';

enum TaskStatus { newTask, progressTask, completedTask, cancelledTask }

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key, required this.status, required this.title, required this.subtitle, required this.date, required this.index,
  });

  final TaskStatus status;
  final String title;
  final String subtitle;
  final List date;
  final int index;

  Color _getChipColor (){
    late Color color;
    switch(status){
      case TaskStatus.newTask:
        color = AppColor.blueColor;
      case TaskStatus.progressTask:
        color = AppColor.purpleColor;
      case TaskStatus.completedTask:
        color = AppColor.greenColor;
      case TaskStatus.cancelledTask:
        color = AppColor.redColor;
    }
    return color;
  }

  String _getStatus (){
    late String st;
    switch(status){
      case TaskStatus.newTask:
        st = "New";
      case TaskStatus.progressTask:
        st = "Progress";
      case TaskStatus.completedTask:
        st = "Completed";
      case TaskStatus.cancelledTask:
        st = "Cancelled";
    }
    return st;
  }

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
                    _getStatus(),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: _getChipColor(),
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