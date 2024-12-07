import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';

import 'package:gui_notes/blocs/register_cubit/register_cubit.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: RegisterViewContent(
        formKey: _formKey,
        focusNode: _focusNode,
      ),
    );
  }
}

class RegisterViewContent extends StatelessWidget {
  const RegisterViewContent({
    required this.formKey,
    required this.focusNode,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;

  void _clearErrors() {
    Future.delayed(const Duration(seconds: 4), () {
      formKey.currentState?.validate();
    });
  }

  void _onRegister(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<RegisterCubit>().register();
    } else {
      _clearErrors();
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
                'Sign up',
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
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            focusNode: focusNode,
                            onChanged: (value) =>
                                context.read<RegisterCubit>().updateName(value),
                            decoration: InputDecoration(
                                labelText: 'Name',
                                hintText: 'Enter your name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                )),
                            validator: RequiredValidator(
                                errorText: 'Name is required'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => context
                                .read<RegisterCubit>()
                                .updateLastName(value),
                            decoration: InputDecoration(
                              labelText: 'Last name',
                              hintText: 'Enter your last name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            validator: RequiredValidator(
                                errorText: 'Last name is required'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      onChanged: (value) =>
                          context.read<RegisterCubit>().updateEmail(value),
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
                          context.read<RegisterCubit>().updatePassword(value),
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
                      onPressed: () => _onRegister(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        fixedSize: const Size(350, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Text(
                        'Sign up',
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
                          onPressed: () => context.go('/auth/login'),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              splashFactory: NoSplash.splashFactory,
                              overlayColor: Colors.transparent),
                          child: const Text(
                            'Already have an account?',
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
