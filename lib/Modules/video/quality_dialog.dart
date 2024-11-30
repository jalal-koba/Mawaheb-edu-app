import 'package:flutter/material.dart'; 
import 'package:talents/Modules/Youtube/youtube_cubit.dart';

class QualityDialog extends StatelessWidget {
  const QualityDialog({super.key,
    required List<MyVideo> videos,
    required int selected,
  })  : _videos = videos,
        _selected = selected;

  final List<MyVideo> _videos;
  final int _selected;

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = Theme.of(context).primaryColor;

    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        final video = _videos[index].value;
        return ListTile(
          dense: true,
          title: Row(
            children: [
              if (video == _selected)
                Icon(
                  Icons.check,
                  size: 20.0,
                  color: selectedColor,
                )
              else
                Container(width: 20.0),
              const SizedBox(width: 16.0),
              Text(_videos[index].quality),
            ],
          ),
          selected: video == _selected,
          onTap: () {
            Navigator.of(context).pop(video);
          },
        );
      },
      itemCount: _videos.length,
    );
  }
}