// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/weather_controller.dart';
//
// class HistoricalComparison extends StatelessWidget {
//   const HistoricalComparison({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<WeatherController>();
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.2),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Historical Comparison',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   if (controller.currentWeather.value != null) {
//                     final lastYear = DateTime.now().subtract(const Duration(days: 365));
//                     final dateStr = '${lastYear.year}-${lastYear.month.toString().padLeft(2, '0')}-${lastYear.day.toString().padLeft(2, '0')}';
//                     controller.loadHistoricalWeather(
//                       controller.currentWeather.value!.city,
//                       dateStr,
//                     );
//                   }
//                 },
//                 icon: const Icon(Icons.refresh, color: Colors.white),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//
//           Obx(() {
//             if (controller.historicalWeather.value == null) {
//               return const Text(
//                 'Tap refresh to compare with last year',
//                 style: TextStyle(color: Colors.white70),
//               );
//             }
//
//             final current = controller.currentWeather.value!;
//             final historical = controller.historicalWeather.value!;
//             final tempDiff = current.tempC - historical.tempC;
//
//             return Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Today',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         Text(
//                           '${current.tempC.round()}°C',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         const Text(
//                           'Last Year',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         Text(
//                           '${historical.tempC.round()}°C',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: tempDiff > 0 ? Colors.red.withValues(alpha: 0.3) : Colors.blue.withValues(alpha: 0.3),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         tempDiff > 0 ? Icons.trending_up : Icons.trending_down,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         '${tempDiff.abs().toStringAsFixed(1)}°C ${tempDiff > 0 ? 'warmer' : 'cooler'} than last year',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }