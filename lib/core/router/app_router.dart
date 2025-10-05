import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_app/core/theme/app_colors.dart';
import 'package:hotel_app/core/theme/theme_provider.dart';
import 'package:hotel_app/core/widgets/custom_nav_icon.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_app/features/bookings/view/bookings_screen.dart';
import 'package:hotel_app/features/home/view/home_screen.dart';
import 'package:hotel_app/features/messages/view/messages_screen.dart';
import 'package:hotel_app/features/profile/view/profile_screen.dart';
import 'package:hotel_app/features/splash/view/splash_screen.dart';
import 'package:hotel_app/features/onboarding/view/onboarding_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainAppShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: const HomeScreen()),
        ),
        GoRoute(
          path: '/bookings',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: const BookingsScreen()),
        ),
        GoRoute(
          path: '/messages',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: const MessagesScreen()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: const ProfileScreen()),
        ),
      ],
    ),
  ],
);

class MainAppShell extends ConsumerWidget {
  final Widget child;

  const MainAppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getIndex(location);
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: isDarkMode ? Colors.grey[400] : Colors.grey,
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/bookings');
              break;
            case 2:
              context.go('/messages');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: CustomNavIcon(
              activeIconPath: 'assets/icons/home-active.png',
              inactiveIconPath: 'assets/icons/home.png',
              isActive: currentIndex == 0,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: CustomNavIcon(
              activeIconPath: 'assets/icons/document-active.png',
              inactiveIconPath: 'assets/icons/document.png',
              isActive: currentIndex == 1,
            ),
            label: "My Bookings",
          ),
          BottomNavigationBarItem(
            icon: CustomNavIcon(
              activeIconPath: 'assets/icons/chat-active.png',
              inactiveIconPath: 'assets/icons/chat.png',
              isActive: currentIndex == 2,
            ),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: CustomNavIcon(
              activeIconPath: 'assets/icons/user-active.png',
              inactiveIconPath: 'assets/icons/user.png',
              isActive: currentIndex == 3,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  /// Helper function for BottomNav index
  int _getIndex(String location) {
    switch (location) {
      case '/home':
        return 0;
      case '/bookings':
        return 1;
      case '/messages':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }
}
