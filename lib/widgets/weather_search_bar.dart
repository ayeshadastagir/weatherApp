import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';

class WeatherSearchBar extends StatelessWidget {
  const WeatherSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search for a city...',
                    hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (controller.searchController.text.isNotEmpty) {
                    controller.loadWeather(controller.searchController.text);
                    controller.searchResults.clear();
                    //close keyboard
                    FocusScope.of(context).unfocus();
                  }
                },
                icon: const Icon(Icons.send, color: Colors.white),
              ),
              IconButton(
                onPressed: controller.loadAutoLocationWeather,
                icon: const Icon(Icons.my_location, color: Colors.white),
              ),
            ],
          ),

          // Search Results
          Obx(() {
            if (controller.searchResults.isEmpty) return const SizedBox.shrink();

            return Container(
              margin: const EdgeInsets.only(top: 8),
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final city = controller.searchResults[index];
                  return ListTile(
                    title: Text(
                      city,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      controller.loadWeather(city.split(',')[0]);
                      controller.searchController.text = city;
                      controller.searchResults.clear();
                      FocusScope.of(context).unfocus();
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}