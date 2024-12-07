import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:gui_notes/views/view.dart';

final appRouter = GoRouter(initialLocation: '/auth/login', routes: [
  GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: HomeView())),
  GoRoute(
      path: '/auth/login',
      pageBuilder: (context, state) => MaterialPage(child: LoginView())),
  GoRoute(
      path: '/auth/register',
      pageBuilder: (context, state) => MaterialPage(child: RegisterView()))
]);
