import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/validators.dart';
import '../../providers/auth_view_model.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _sent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recover access', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                const Text('Enter your email and Firebase Auth will send a reset link.'),
                const SizedBox(height: 24),
                TextFormField(controller: _email, validator: Validators.email, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    final ok = await context.read<AuthViewModel>().forgotPassword(_email.text);
                    if (ok) setState(() => _sent = true);
                  },
                  child: const Text('Send reset link'),
                ),
                if (_sent) const Padding(padding: EdgeInsets.only(top: 16), child: Text('Reset link sent. Please check your inbox.')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
