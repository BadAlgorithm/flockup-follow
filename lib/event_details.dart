import 'package:feather/feather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flockup_follow/ui.dart';

class EventDetails extends StatelessWidget {
  final Map event;

  EventDetails(this.event);

  @override
  Widget build(BuildContext context) {
    var name = get(event, 'name');
    final List<Widget> details = []
      ..addAll(venueSection(context, event))
      ..addAll(overviewSection(context, event));

    return new Scaffold(
      appBar: AppBar(
        title: new Text(name),
      ),
      body: new Column(children: [
        imageOrPlaceholder(event),
        new Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: nonNullWidgets(details),
            ),
          ),
        ),
      ]),
    );
  }
}

List<Widget> overviewSection(context, event) {
  var details = get(event, 'plain_text_description');
  var theme = Theme.of(context).textTheme;

  if (isNotNull(details)) {
    return [
      new Text(
        'OVERVIEW',
        style: theme.body2,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
      ),
      new Text(details),
    ];
  } else {
    return null;
  }
}

List<Widget> venueSection(context, event) {
  var venue = get(event, 'venue');
  var theme = Theme.of(context).textTheme;
  if (isNotNull(venue)) {
    var address = ['address_1', 'city']
        .map((f) => get(venue, f))
        .where(isNotNull)
        .join(", ");
    var spacer = new Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
    );
    return [
      new Text(
        'VENUE',
        style: theme.body2,
      ),
      spacer,
      new Text(get(venue, 'name')),
      new Text(address),
      spacer,
    ];
  } else {
    return null;
  }
}
