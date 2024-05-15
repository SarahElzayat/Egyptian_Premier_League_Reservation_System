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

    setState(() {
      fetch = true;
    });
  }

  Future<void> cancelReservation(int id, BuildContext context) async {
    await cancelReservationControler(id, context);
    // pop up dialog if the sucess and another one with the failuer
    // ignore: use_build_context_synchronously
    await getTickets(context);
    // setState(() {});
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
    else {
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
                  title: Text(
                      "${data.reservations![index].homeTeam!.name} vs ${data.reservations![index].awayTeam!.name}"),
                  subtitle: Text(
                      "Stadium: ${data.reservations![index].matchVenue!.name}\nDate: ${data.reservations![index].date!.split('T')[0]}   Time: ${data.reservations![index].time}"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Implement cancellation logic
                      cancelReservation(data.reservations![index].id!, context);
                    },
                    child: Text("Cancel"),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
