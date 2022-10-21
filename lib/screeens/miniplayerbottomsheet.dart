import 'package:flutter/material.dart';
import 'package:music_player/shortcuts/shortcuts.dart';

miniplayer_showmodelsheet({required context}) {
  showBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: pink,
              ),
              title: Text('haiiiiiiii'),
              subtitle: Text('artist'),
              trailing: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.skip_previous)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.skip_next))
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
