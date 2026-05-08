import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../providers/auth_view_model.dart';
import '../../widgets/loading_overlay.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, auth, _) {
        return LoadingOverlay(
          isLoading: auth.isLoading,
          child: Scaffold(
            appBar: AppBar(title: const Text('Create account')),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    TextFormField(controller: _name, validator: (v) => Validators.required(v, 'Name'), decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person_outline))),
                    const SizedBox(height: 12),
                    TextFormField(controller: _email, validator: Validators.email, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline))),
                    const SizedBox(height: 12),
                    TextFormField(controller: _password, validator: Validators.password, obscureText: true, decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline))),
                    const SizedBox(height: 12),
                    TextFormField(controller: _phone, validator: (v) => Validators.required(v, 'Phone'), decoration: const InputDecoration(labelText: 'Phone', prefixIcon: Icon(Icons.phone_outlined))),
                    const SizedBox(height: 12),
                    TextFormField(controller: _address, validator: (v) => Validators.required(v, 'Address'), maxLines: 2, decoration: const InputDecoration(labelText: 'Address', prefixIcon: Icon(Icons.home_outlined))),
                    const SizedBox(height: 18),
                    if (auth.error != null) Text(auth.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    FilledButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        final ok = await auth.register(_name.text, _email.text, _password.text, _phone.text, _address.text);
                        if (ok && context.mounted) Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
