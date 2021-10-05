import 'package:bytebank_final/screens/contact_list.dart';
import 'package:bytebank_final/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ColorFiltered(
                child: Image.asset('images/bytebank_logo.png'),
                colorFilter:
                    ColorFilter.mode(Colors.amber[600]!, BlendMode.lighten),
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _DashboardTile(
                    tileIcon: Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                    ),
                    tileLabel: 'Transferir',
                    onClick: () => _dashboardNavigator(context, ContactList()),
                  ),
                  _DashboardTile(
                    tileIcon: Icon(
                      Icons.history,
                      color: Colors.white,
                    ),
                    tileLabel: 'Histórico',
                    onClick: () =>
                        _dashboardNavigator(context, TransactionsList()),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _dashboardNavigator(context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}

class _DashboardTile extends StatelessWidget {
  final String? tileLabel;
  final Icon? tileIcon;
  final Function? onClick;

  const _DashboardTile({
    Key? key,
    this.tileLabel,
    this.tileIcon,
    @required this.onClick,
  })  : assert(tileIcon != null),
        assert(onClick != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          color: Theme.of(context).colorScheme.primary,
          child: InkWell(
            onTap: () => onClick!(),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 100,
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  tileIcon!,
                  Text(tileLabel!,
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ],
              ),
            ),
          )),
    );
  }
}
