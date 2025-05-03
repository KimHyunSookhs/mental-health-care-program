import 'package:flutter/material.dart';
import 'package:mental_health_care/data/model/you_tube.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/ui/color_style.dart';

class MiniYouTubeCard extends StatelessWidget {
  final YouTube youTube;

  const MiniYouTubeCard({super.key, required this.youTube});

  Future<void> _launchYouTubeUrl(BuildContext context) async {
    final url = 'https://www.youtube.com/watch?v=${youTube.youTubeId}';
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('유튜브를 열 수 없습니다.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('링크 열기에 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _launchYouTubeUrl(context),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://img.youtube.com/vi/${youTube.youTubeId}/0.jpg',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    youTube.title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '${youTube.duration}분',
                        style: TextStyle(color: ColorStyle.darkerGrey),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.circle,
                        size: 6,
                        color: ColorStyle.darkerGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        youTube.category,
                        style: TextStyle(color: ColorStyle.darkerGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
