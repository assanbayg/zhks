// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/features/reports/data/report.dart';

class HouseWorkReportSlider extends StatefulWidget {
  final MonthlyReportDetail reportDetail;
  const HouseWorkReportSlider({super.key, required this.reportDetail});

  @override
  State<HouseWorkReportSlider> createState() => _HouseWorkReportSliderState();
}

class _HouseWorkReportSliderState extends State<HouseWorkReportSlider> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final item = widget.reportDetail.houseWorkReports[index];
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.reportDetail.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(item.photos.first, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(item.title, style: Theme.of(context).textTheme.titleMedium),
          Text(item.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: index > 0 ? () => setState(() => index--) : null,
                icon: const Icon(Icons.arrow_back),
              ),
              Text(
                '${index + 1}/${widget.reportDetail.houseWorkReports.length}',
              ),
              IconButton(
                onPressed:
                    index < widget.reportDetail.houseWorkReports.length - 1
                        ? () => setState(() => index++)
                        : null,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
