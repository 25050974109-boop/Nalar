import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/nalar_theme.dart';
import 'core/widgets/nalar_bottom_navigation.dart';
import 'providers/app_provider.dart';
import 'features/home/home_screen.dart';
import 'features/learning/module_list_screen.dart';
import 'features/simulations/simulation_selector_screen.dart';
import 'features/video/video_list_screen.dart';
import 'features/menu/menu_screen.dart';

class NalarApp extends StatelessWidget {
  const NalarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NALAR',
      debugShowCheckedModeBanner: false,
      theme: NalarTheme.lightTheme,
      home: const MainWrapperScreen(),
    );
  }
}

class MainWrapperScreen extends StatelessWidget {
  const MainWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    final List<Widget> screens = [
      const HomeScreen(),
      const ModuleListScreen(),
      const SimulationSelectorScreen(),
      const VideoListScreen(),
      const MenuScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: provider.currentBottomNavIndex,
        children: screens,
      ),
      bottomNavigationBar: NalarBottomNavigation(
        currentIndex: provider.currentBottomNavIndex,
        onTap: (index) => provider.setBottomNavIndex(index),
      ),
    );
  }
}
