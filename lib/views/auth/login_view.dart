import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

import 'package:gui_notes/blocs/login_cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: LoginViewContent(
        formKey: _formKey,
        focusNode: _focusNode,
      ),
    );
  }
}

class LoginViewContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;

  const LoginViewContent({
    required this.formKey,
    required this.focusNode,
    super.key,
  });

  void _onLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<LoginCubit>().login();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign in',
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) =>
                          context.read<LoginCubit>().updateEmail(value),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Email is required'),
                        EmailValidator(errorText: 'Invalid email'),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      onChanged: (value) =>
                          context.read<LoginCubit>().updatePassword(value),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '*******',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Password is required'),
                        MinLengthValidator(6,
                            errorText:
                                'Password must be at least 6 characters long'),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _onLogin(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        fixedSize: const Size(350, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => context.go('/auth/register'),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: Colors.transparent),
                          child: const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
