import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum IsAuthenticated { authenticated, notAtuthenticated, cancelled, badRequest }

class TransactionAuthDialog extends StatefulWidget {
  const TransactionAuthDialog({Key? key, required this.onConfirm})
      : super(key: key);

  final Function(String password) onConfirm;

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        controller: _passwordController,
        decoration: InputDecoration(border: OutlineInputBorder()),
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        style: TextStyle(
          fontSize: 64.0,
          letterSpacing: 24,
        ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, IsAuthenticated.cancelled);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final Response response =
                await widget.onConfirm(_passwordController.text);
            switch (response.statusCode) {
              case 200:
                return Navigator.pop(context, IsAuthenticated.authenticated);
              case 401:
                return Navigator.pop(
                    context, IsAuthenticated.notAtuthenticated);
              case 400:
                return Navigator.pop(context, IsAuthenticated.badRequest);
              default:
                print(response.statusCode.toString());
                return Navigator.pop(context);
            }
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
