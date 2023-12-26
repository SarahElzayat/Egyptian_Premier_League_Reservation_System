import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';
import '../models/ticket.dart';
import '../controller/reservation.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  tickets data = tickets();
  bool fetch = false;
  Future<void> getTickets(BuildContext context) async {
    data = await get_my_tickets(context);
    print(tickets);
    setState(() {
      fetch = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTickets(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!fetch)
      return Scaffold(
        appBar: AppBarComponent(
          context,
          index: 5,
          title: "Tickets",
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    else
      return Scaffold(
        appBar: AppBarComponent(
          context,
          index: 5,
          title: "Tickets",
        ),
        body: Center(
          child: ListView.builder(
            itemCount: data.reservations!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(data.reservations![index].matchId.toString()),
                  subtitle: Text(data.reservations![index].id.toString()),
                  trailing: Text(data.reservations![index].matchId.toString()),
                ),
              );
            },
          ),
        ),
      );
  }
}
