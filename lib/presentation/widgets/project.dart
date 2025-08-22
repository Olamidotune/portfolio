// Project Data Model

import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;
  final String fullDescription;
  final List<String> techStack;
  final List<Color> gradientColors;
  final Widget icon;
  final String demoType;
  final bool hasDemo;
  final String? demoUrl;
  final String? codeUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final List<String> features;
  final List<String> technicalDetails;
  final List<String> challenges;

  const Project({
    required this.title,
    required this.description,
    required this.fullDescription,
    required this.techStack,
    required this.gradientColors,
    required this.icon,
    required this.demoType,
    this.appStoreUrl,
    this.playStoreUrl,
    this.hasDemo = true,
    this.demoUrl,
    this.codeUrl,
    this.features = const [],
    this.technicalDetails = const [],
    this.challenges = const [],
  });
}

// Sample Data
List<Project> sampleProjects = [
  Project(
    title: 'Exchanger 101',
    description:
        'Exchanger101 is a secure mobile platform that lets users in Nigeria instantly convert gift cards and cryptocurrencies like Bitcoin and USDT to cash at competitive rates. Available on Android and iOS, it offers real-time rates, zero withdrawal fees, and 24/7 support, delivering a fast and seamless exchange experience.',
    fullDescription:
        'Exchanger101 is a secure mobile platform that lets users in Nigeria instantly convert gift cards and cryptocurrencies like Bitcoin and USDT to cash at competitive rates. Available on Android and iOS, it offers real-time rates, zero withdrawal fees, and 24/7 support, delivering a fast and seamless exchange experience.',
    techStack: ['Flutter', 'Bloc', 'Firebase', 'Rest API'],
    gradientColors: [Color(0xFF667eea), Color(0xFF764ba2)],
    icon: Image.asset('assets/images/x101logo.png'),
    demoType: 'Live Demo',
    demoUrl: 'https://www.youtube.com/@Exchanger101x',
    appStoreUrl: 'https://apps.apple.com/ng/app/exchanger101/id1586118217',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.exchanger101.app&hl=en',
    codeUrl: null,
    features: [
      'Push notifications',
      'Real-time exchange rates',
      'Secure and authentication transactions with biometric authentication',
      '24/7 customer support',
      'Sell gift cards and cryptocurrencies',
      'Leaderboard',
      'Fast and secure transactions',
      'Referral program',
    ],
    technicalDetails: [
      'State Management: Implemented BLoC + Freezed for predictable and immutable state handling',
      'UI: Built responsive UI with custom widgets and animations using Flutter',
      'API Integration: Integrated with REST APIs using Dio, with interceptors for logging, retries, and error handling',
      'Security: Secured API calls with token-based authentication, encrypted local storage, and biometric authentication (Face ID / Fingerprint) for login and withdrawals',
      'Performance: Used pagination + lazy loading for transaction history and exchange records',
    ],
    challenges: [
      'Withdrawal security: Added biometric authentication (Face ID / Fingerprint) as a second factor on top of token-based auth',
      'Large transaction histories: Optimized with pagination, lazy loading, and efficient list rendering',
      'Async state consistency: Ensured predictable flow with BLoC + Freezed',
      'User engagement: Implemented leaderboard, referral program, and analytics tracking to boost retention',
    ],
  ),
  Project(
    title: 'Astrotwig',
    description:
        'Astrotwig is The First Seamless, Social - Audio Streaming platform. Astrotwig Combines Top Notch Audio Streaming Experience with Social Networking and interaction. Connect to Music Like Never Before.',
    fullDescription:
        'Astrotwig is The First Seamless, Social - Audio Streaming platform. Astrotwig Combines Top Notch Audio Streaming Experience with Social Networking and interaction. Connect to Music Like Never Before.',
    techStack: ['Flutter', 'Riverpod', 'Rest API'],
    gradientColors: [Color(0xFF11998e), Color(0xFF38ef7d)],
    icon: Image.asset('assets/images/astro_logo.png'),
    demoType: 'Case Study',
    demoUrl: 'https://www.youtube.com/watch?v=QbIJRD8HrFU',
    appStoreUrl: 'https://apps.apple.com/ng/app/astrotwig/id6476610398',
    playStoreUrl:
        'https://play.google.com/store/search?q=Astrotwig&c=apps&hl=en',
    codeUrl: null,
    features: [
      'Music Streaming: Play and discover songs across genres',
      'Social Feed (Tweegs): Vertical feed for music discovery and social interaction',
      'Astropod: Temporary music posts (like stories) for quick sharing',
      'Astrodeck: Virtual listening parties where friends enjoy tracks together',
      'User Profiles: Follow other users, view playlists, and track activity',
      'Playlists: Create, share, and manage personal playlists',
      'Engagement: Like, comment, and share songs within the community',
      'Cross-Platform: Available on Android and iOS',
    ],
    technicalDetails: [
      'State Management: Riverpod for reactive programming and dependency injection',
      'UI: Built with Flutter, leveraging custom widgets and animations for a smooth user experience',
      'API Integration: RESTful APIs for music data, user profiles, and social interactions',
      'Security: Token-based authentication with JWT for secure user sessions',
    ],
    challenges: [
      'Real-time updates: Implemented WebSockets for live notifications and social interactions',
      'Scalability: Designed APIs to handle high traffic and concurrent users',
      'User engagement: Created features like Astropod and Astrodeck to enhance social interaction',
      'Cross-platform consistency: Ensured a uniform experience across Android and iOS',
    ],
  ),
  Project(
    title: 'Weather Dashboard',
    description:
        'Beautiful weather app with location-based forecasts, interactive maps, and custom animations.',
    fullDescription:
        'An open-source weather application showcasing modern Flutter development practices and beautiful UI design.',
    techStack: ['Flutter', 'Riverpod', 'API Integration', 'Maps'],
    gradientColors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
    icon: Image.asset('assets/images/go.png'),
    demoType: 'Open Source',
    demoUrl: 'https://your-weather-demo.com',
    codeUrl: 'https://github.com/yourusername/weather-dashboard',
    features: [
      'Location-based weather forecasts',
      'Interactive weather maps',
      'Weather alerts and notifications',
      'Multiple location management',
      'Dark/light theme support',
      'Accessibility features',
    ],
    technicalDetails: [
      'State Management: Riverpod for reactive programming',
      'API: OpenWeatherMap API integration',
      'Maps: Google Maps integration',
      'Storage: Shared preferences and Hive',
    ],
    challenges: [
      'API rate limiting: Implemented intelligent caching and request batching',
      'Location accuracy: Used fused location provider for better precision',
      'Accessibility: Ensured screen reader compatibility and high contrast support',
    ],
  ),
];
