import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pexel/data/dto/photos_dto.dart';
import 'package:pexel/presentation/widgets/shimmer_loading.dart';
import 'package:url_launcher/link.dart';

class DetailScreen extends StatefulWidget {

  final PhotosDto photosDto;

  const DetailScreen({
    super.key,
    required this.photosDto
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Detail Photo",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
        ),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: widget.photosDto.imageOriginalUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) => const ShimmerLoading(height: 400,),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20,),
          _photographerSection(),
          const SizedBox(height: 10,),
          _imageUrlSection(),
          const SizedBox(height: 10,),
          _description(),
          const SizedBox(height: 120,),
        ],
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        widget.photosDto.description
      ),
    );
  }

  Widget _photographerSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
          widget.photosDto.photographer
      )
    );
  }

  Widget _imageUrlSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Link(
        uri: Uri.parse(widget.photosDto.imageUrl),
        target: LinkTarget.defaultTarget,
        builder: (context, openLink) => GestureDetector(
          onTap: openLink,
          child: Text(
            widget.photosDto.imageUrl,
            style: const TextStyle(
              color: Colors.blue
            ),
          )
        ),
      ),
    );
  }
}
