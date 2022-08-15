import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import '../../common/utility/utility.dart';

class RemoteImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;

  const RemoteImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      height: height,
      width: width,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const CupertinoActivityIndicator(),
      errorWidget: (context, url, error) {
        logger.e("$url failed ${error.toString()}");
        return const Icon(CupertinoIcons.gift_alt);
      },
    );
  }
}
