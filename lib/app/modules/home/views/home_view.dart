import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ai_web_analyzer/app/modules/home/controller/home_view_ctl.dart';
import 'package:ai_web_analyzer/app/utills/size_config.dart';

class HomeView extends GetView<HomeViewCTL> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Scraper',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1A73E8),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.contact_support, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A73E8), Color(0xFF6C5CE7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Extract Data Smarter, Faster',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'AI-powered website scraping made simple and efficient.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 24, right: 12),
                        // padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child:

                                  //      GestureDetector(
                                  //   onTap: () {
                                  //     FocusScope.of(context)
                                  //         .unfocus(); // Remove focus when tapping outside
                                  //   },
                                  //   child: Container(
                                  //     padding:
                                  //         const EdgeInsets.symmetric(horizontal: 10),
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.black, // Background color
                                  //       borderRadius: BorderRadius.circular(10),
                                  //     ),
                                  //     child: Row(
                                  //       children: [
                                  //         const Icon(Icons.search,
                                  //             color: Colors.white70), // Search icon
                                  //         Expanded(
                                  //           child: TextField(
                                  //             cursorColor: Colors.white,
                                  //             controller: controller.searchController,
                                  //             style: const TextStyle(
                                  //                 color: Colors.white),
                                  //             decoration: const InputDecoration(
                                  //               hintText: 'Enter webpage URL...',
                                  //               hintStyle:
                                  //                   TextStyle(color: Colors.white70),
                                  //               border: InputBorder
                                  //                   .none, // Remove underline
                                  //               enabledBorder: InputBorder.none,
                                  //               focusedBorder: InputBorder.none,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // )

                                  TextField(
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.go,
                                controller: controller.searchController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: 'Enter webpage URL...',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none,
                                ),
                                // selectionControls:
                                //     CustomTextSelectionControls(),
                                onSubmitted: (value) {
                                controller.goToUrl(context);
                                 
                                 
                                  // Get.snackbar(
                                  //   'Search Initiated',
                                  //   'Scraping data from ${controller.searchController.text}',
                                  //   snackPosition: SnackPosition.BOTTOM,
                                  //   backgroundColor: const Color(0xFF1A73E8),
                                  //   colorText: Colors.white,
                                  // );
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                  Icons.keyboard_double_arrow_right_rounded,
                                  color: Colors.white),
                              // icon: const Icon(Icons.search, color: Colors.white),
                              onPressed: () {
                                controller.goToUrl(context);
                                // Get.snackbar(
                                //   'Search Initiated',
                                //   'Scraping data from ${controller.searchController.text}',
                                //   snackPosition: SnackPosition.BOTTOM,
                                //   backgroundColor: const Color(0xFF1A73E8),
                                //   colorText: Colors.white,
                                // );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () async {
                          ClipboardData? clipboardData =
                              await Clipboard.getData(Clipboard.kTextPlain);
                          if (clipboardData != null &&
                              clipboardData.text != null) {
                            controller.searchController.text =
                                clipboardData.text!; // Set text to controller
                            controller.searchController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset:
                                      controller.searchController.text.length),
                            ); // Move cursor to the end
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: const Text(
                            'Paste URL',
                            style: TextStyle(
                                color: Color(0xFF1A73E8),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                height: 1),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Features Section
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  FeatureCard(
                    title: 'Fast & Accurate',
                    description:
                        'Get precise data in seconds with our AI algorithms.',
                  ),
                  SizedBox(height: 20),
                  FeatureCard(
                    title: 'Easy to Use',
                    description:
                        'No technical skills required. Just paste the URL and go!',
                  ),
                  SizedBox(height: 20),
                  FeatureCard(
                    title: 'Secure & Reliable',
                    description:
                        'Your data is safe with our encrypted processes.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A73E8),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
