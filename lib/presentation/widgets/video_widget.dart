import 'package:flutter/material.dart';

class VideoWidget extends StatelessWidget {
  final String url;
  const VideoWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              url,
              fit: BoxFit.cover,
              loadingBuilder:
                  (BuildContext _, Widget child, ImageChunkEvent? progress) {
                if (progress == null) {
                  return child;
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                }
              },
              errorBuilder: (BuildContext _, Object a, StackTrace? trace) {
                return const Center(child: Icon(Icons.wifi));
              },
            )),
        Positioned(
          bottom: 0,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            radius: 20,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.volume_off,
                  color: Colors.white,
                  size: 20,
                )),
          ),
        ),
      ],
    );
  }
}
