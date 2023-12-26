import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';
import 'package:web_frontend/src/controller/authentication.dart';
import 'package:web_frontend/src/controller/match.dart';
import 'package:web_frontend/src/controller/reservation.dart';
import '../models/match.dart';

import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

double size = 50;

class MatchInfoScreen extends StatefulWidget {
  int id;
  MatchInfoScreen({super.key, required this.id});

  @override
  State<MatchInfoScreen> createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen> {
  // create instance of match and but dummy data in it
  Match match = Match();
  int num_vacant_seats = 0;
  int num_booked_seats = 0;
  List<List<int>> reservasions = [];
  int dimension1 = 0;
  int dimension2 = 0;

  Timer? _timer;

  void _startTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      getMatch(context);
    });
  }

  Future<void> getMatch(BuildContext context) async {
    Map<String, Object> out = await getMatchDetails(widget.id ?? 1, context);
    setState(() {
      if (out['sucess'] == true) {
        match = out['match'] as Match;
        num_vacant_seats = out['num_vacant_seats'] as int;
        num_booked_seats = out['num_booked_seats'] as int;
        var li;
        reservasions = [];
        for (li in out['reserved_tickets'] as List<dynamic>) {
          reservasions.add([]);
          for (var i in li) {
            reservasions[reservasions.length - 1].add(i as int);
          }
        }
        dimension1 = out['dimension1'] as int;
        dimension2 = out['dimension2'] as int;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMatch(context);
    _startTimer(context);
  }

  @override
  void dispose() {
    _timer?.cancel(); // Always cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<Map<String, String>?> _showInputDialog(BuildContext context) async {
    String fieldOne = '';
    String fieldTwo = '';

    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'card number'),
                onChanged: (value) => fieldOne = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'PIN'),
                onChanged: (value) => fieldTwo = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context)
                    .pop({'card_number': fieldOne, 'PIN': fieldTwo});
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (match.id == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Match Details'),
        ),
        body: const Center(
          child: const CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBarComponent(
        context,
        title: "Match Details",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Match Information',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        matchDetailRow(
                            'Date:', match.date!.split('T')[0] ?? ""),
                        matchDetailRow('Time:', match.time ?? ""),
                        matchDetailRow(
                            'Main Referee:', match.mainReferee ?? ""),
                        matchDetailRow('Linesman 1:', match.linesmen1 ?? ""),
                        matchDetailRow('Linesman 2:', match.linesmen2 ?? ""),
                        matchDetailRow(
                            'Home Team:', match.homeTeam!.name ?? ""),
                        matchDetailRow(
                            'Away Team:', match.awayTeam!.name ?? ""),
                        matchDetailRow('Venue:', match.matchVenue!.name ?? ""),
                        matchDetailRow(
                            'num_vacant_seats:', num_vacant_seats.toString()),
                        matchDetailRow(
                            'num_booked_seats:', num_booked_seats.toString()),
                      ],
                    ),
                  ),
                ),
                // create the gird
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Container(
                    child: TwoDimensionalGridView(
                      diagonalDragBehavior: DiagonalDragBehavior.free,
                      delegate: TwoDimensionalChildBuilderDelegate(
                          maxXIndex: dimension2 - 1,
                          maxYIndex: dimension1 - 1,
                          builder:
                              (BuildContext context, ChildVicinity vicinity) {
                            bool resered = false;
                            // if the curent seat appear in the reserved list

                            for (var i in reservasions) {
                              if (i[1] == (vicinity.xIndex + 1) &&
                                  i[0] == (vicinity.yIndex + 1)) {
                                resered = true;
                                break;
                              }
                            }
                            return Container(
                              color: resered ? Colors.red : Colors.amber[50],
                              height: size,
                              width: size,
                              child: ElevatedButton(
                                onPressed: resered
                                    ? null
                                    : () async {
                                        bool ch = await check_login();
                                        if (!ch) {
                                          Navigator.pushNamed(
                                              context, '/login');
                                          return;
                                        }
                                        final result =
                                            await _showInputDialog(context);
                                        reserved_ticket({
                                          'card_number':
                                              result!['card_number'] ??
                                                  "1234567891234567",
                                          'PIN': result!['PIN'] ?? '123',
                                          'matchId': widget.id,
                                          'seat_row': vicinity.yIndex + 1,
                                          'seat_column': vicinity.xIndex + 1,
                                        }, context);
                                        // navigate to the reservation screen with the number in dim1 and dim2
                                      },
                                child: const Text(""),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TwoDimensionalGridView extends TwoDimensionalScrollView {
  const TwoDimensionalGridView({
    super.key,
    super.primary,
    super.mainAxis = Axis.vertical,
    super.verticalDetails = const ScrollableDetails.vertical(),
    super.horizontalDetails = const ScrollableDetails.horizontal(),
    required TwoDimensionalChildBuilderDelegate delegate,
    super.cacheExtent,
    super.diagonalDragBehavior = DiagonalDragBehavior.none,
    super.dragStartBehavior = DragStartBehavior.start,
    super.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);

  @override
  Widget buildViewport(
    BuildContext context,
    ViewportOffset verticalOffset,
    ViewportOffset horizontalOffset,
  ) {
    return TwoDimensionalGridViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalDetails.direction,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalDetails.direction,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildBuilderDelegate,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
    );
  }
}

class TwoDimensionalGridViewport extends TwoDimensionalViewport {
  const TwoDimensionalGridViewport({
    super.key,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required TwoDimensionalChildBuilderDelegate super.delegate,
    required super.mainAxis,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
  });

  @override
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) {
    return RenderTwoDimensionalGridViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildBuilderDelegate,
      childManager: context as TwoDimensionalChildManager,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderTwoDimensionalGridViewport renderObject,
  ) {
    renderObject
      ..horizontalOffset = horizontalOffset
      ..horizontalAxisDirection = horizontalAxisDirection
      ..verticalOffset = verticalOffset
      ..verticalAxisDirection = verticalAxisDirection
      ..mainAxis = mainAxis
      ..delegate = delegate
      ..cacheExtent = cacheExtent
      ..clipBehavior = clipBehavior;
  }
}

class RenderTwoDimensionalGridViewport extends RenderTwoDimensionalViewport {
  RenderTwoDimensionalGridViewport({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required TwoDimensionalChildBuilderDelegate delegate,
    required super.mainAxis,
    required super.childManager,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);

  @override
  void layoutChildSequence() {
    final double horizontalPixels = horizontalOffset.pixels;
    final double verticalPixels = verticalOffset.pixels;
    final double viewportWidth = viewportDimension.width + cacheExtent;
    final double viewportHeight = viewportDimension.height + cacheExtent;
    final TwoDimensionalChildBuilderDelegate builderDelegate =
        delegate as TwoDimensionalChildBuilderDelegate;

    final int maxRowIndex = builderDelegate.maxYIndex!;
    final int maxColumnIndex = builderDelegate.maxXIndex!;

    final int leadingColumn = math.max((horizontalPixels / size).floor(), 0);
    final int leadingRow = math.max((verticalPixels / size).floor(), 0);
    final int trailingColumn = math.min(
      ((horizontalPixels + viewportWidth) / size).ceil(),
      maxColumnIndex,
    );
    final int trailingRow = math.min(
      ((verticalPixels + viewportHeight) / size).ceil(),
      maxRowIndex,
    );

    double xLayoutOffset = (leadingColumn * size) - horizontalOffset.pixels;
    for (int column = leadingColumn; column <= trailingColumn; column++) {
      double yLayoutOffset = (leadingRow * size) - verticalOffset.pixels;
      for (int row = leadingRow; row <= trailingRow; row++) {
        final ChildVicinity vicinity =
            ChildVicinity(xIndex: column, yIndex: row);
        final RenderBox child = buildOrObtainChildFor(vicinity)!;
        child.layout(constraints.loosen());

        // Subclasses only need to set the normalized layout offset. The super
        // class adjusts for reversed axes.
        parentDataOf(child).layoutOffset = Offset(xLayoutOffset, yLayoutOffset);
        yLayoutOffset += size;
      }
      xLayoutOffset += size;
    }

    // Set the min and max scroll extents for each axis.
    final double verticalExtent = size * (maxRowIndex + 1);
    verticalOffset.applyContentDimensions(
      0.0,
      clampDouble(
          verticalExtent - viewportDimension.height, 0.0, double.infinity),
    );
    final double horizontalExtent = size * (maxColumnIndex + 1);
    horizontalOffset.applyContentDimensions(
      0.0,
      clampDouble(
          horizontalExtent - viewportDimension.width, 0.0, double.infinity),
    );
    // Super class handles garbage collection too!
  }
}

Widget matchDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Text(value),
      ],
    ),
  );
}
