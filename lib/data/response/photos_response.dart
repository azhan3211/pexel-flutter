import 'package:pexel/data/response/src_response.dart';

class PhotosResponse {
  final int? id;
  final int? width;
  final int? height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final String? avgColor;
  final SrcResponse? src;
  final bool? liked;
  final String? alt;

  PhotosResponse({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.src,
    this.liked,
    this.alt,
  });

  factory PhotosResponse.fromJson(Map<String, dynamic> json) {
    return PhotosResponse(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      photographer: json['photographer'],
      photographerUrl: json['photographer_url'],
      photographerId: json['photographer_id'],
      avgColor: json['avg_color'],
      src: json['src'] != null ? SrcResponse.fromJson(json['src']) : null,
      liked: json['liked'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'width': width,
      'height': height,
      'url': url,
      'photographer': photographer,
      'photographer_url': photographerUrl,
      'photographer_id': photographerId,
      'avg_color': avgColor,
      'src': src?.toJson(),
      'liked': liked,
      'alt': alt,
    };
  }
}