import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pexel/data/local/menu_items.dart';
import 'package:pexel/data/menu_item.dart';
import 'package:pexel/presentation/controller/main_controller.dart';
import 'package:pexel/presentation/screen/detail_screen.dart';
import 'package:pexel/presentation/widgets/shimmer_loading.dart';
import 'package:pexel/utils/snackbar_util.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with AutomaticKeepAliveClientMixin {

  final MainController _controller = Get.put(MainController());
  final ScrollController _scrollController = ScrollController();
  late Worker errorMessage;

  @override
  void initState() {
    errorMessage = ever(_controller.errorMessage, (value) {
      if (value.isNotEmpty) {
        SnackbarUtils.showSnackBar(context, value);
        _controller.errorMessage.value = "";
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent
          && !_controller.isLoadMore.value) {
        _controller.loadMoreImages();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _controller.refreshData,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _sliverAppbar(),
            Obx(() {
              if (_controller.isRefresh.value) {
                return SliverToBoxAdapter(
                  child: Container(),
                );
              }
              return _controller.isGrid.value ? _gridView() : _listView();
            })
          ],
        ),
      )
    );
  }

  SliverAppBar _sliverAppbar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      backgroundColor: Colors.green,
      actions: [
        PopupMenuButton<MenuItem>(
          iconColor: Colors.white,
          icon: Obx(() {
            return Icon(
                _controller.filterIcon.value
            );
          }),
          onSelected: (value) {
            _controller.changeView(value);
          },
          itemBuilder: (context) => [
            ...MenuItems.menus.map(buildItem),
          ],
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          "Pexel",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        titlePadding: const EdgeInsets.all(16),
        background: Container(
          color: Colors.green,
          child: Image.asset(
            'assets/images/appbar_image.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _gridView() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          if (!_controller.hasMore.value && index == _controller.photos.length) {
            return const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(child: Text("No more data"))
            );
          }
          if (index >= _controller.photos.length) {
            return const ShimmerLoading();
          }
          return AspectRatio(
            aspectRatio: 9 / 16,
            child: _image(index: index),
          );
        },
        childCount: _controller.photos.length + (_controller.isLoadMore.value ? 3 : 0) + (!_controller.hasMore.value ? 1 : 0),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 9 / 16
      ),
    );
  }

  Widget _listView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          if (!_controller.hasMore.value && index == _controller.photos.length) {
            return const SizedBox(
                width: double.infinity,
                height: 100,
                child: Center(child: Text("No more data"))
            );
          }
          if (index == _controller.photos.length) {
            return const Padding(
              padding: EdgeInsets.all(8),
              child: ShimmerLoading(height: 100),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _image(index: index, shimmerHeight: 400),
          );
        },
        childCount: _controller.photos.length + (_controller.isLoadMore.value ? 1 : 0) + (!_controller.hasMore.value ? 1 : 0),
      ),
    );
  }

  Widget _image({
    required int index,
    double shimmerHeight = double.infinity
}) {
    final data = _controller.photos[index];
    return InkWell(
      onTap: () {
        Get.to(DetailScreen(
          photosDto: data,
        ));
      },
      child: CachedNetworkImage(
        imageUrl: data.imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) => ShimmerLoading(height: shimmerHeight,),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
      )
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
    value: item,
    child: Row(
      children: [
        Icon(
          item.icon
        ),
        const SizedBox(width: 10,),
        Text(item.text)
      ],
    )
  );

  @override
  bool get wantKeepAlive => true;
}
