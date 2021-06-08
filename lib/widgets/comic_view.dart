import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:preload_page_view/preload_page_view.dart';

class ComicView extends StatefulWidget {
  /// Construct a gallery with static items through a list of [PhotoViewGalleryPageOptions].
  const ComicView({
    Key key,
    @required this.pageOptions,
    this.loadingBuilder,
    this.loadFailedChild,
    this.backgroundDecoration,
    this.gaplessPlayback = false,
    this.reverse = false,
    this.pageController,
    this.onPageChanged,
    this.scaleStateChangedCallback,
    this.enableRotation = false,
    this.scrollPhysics,
    this.scrollDirection = Axis.horizontal,
    this.customSize,
  })  : itemCount = null,
        builder = null,
        assert(pageOptions != null),
        super(key: key);

  /// Construct a gallery with dynamic items.
  ///
  /// The builder must return a [PhotoViewGalleryPageOptions].
  const ComicView.builder({
    Key key,
    @required this.itemCount,
    @required this.builder,
    this.loadingBuilder,
    this.loadFailedChild,
    this.backgroundDecoration,
    this.gaplessPlayback = false,
    this.reverse = false,
    this.pageController,
    this.onPageChanged,
    this.scaleStateChangedCallback,
    this.enableRotation = false,
    this.scrollPhysics,
    this.scrollDirection = Axis.horizontal,
    this.customSize,
  })  : pageOptions = null,
        assert(itemCount != null),
        assert(builder != null),
        super(key: key);

  /// A list of options to describe the items in the gallery
  final List<PhotoViewGalleryPageOptions> pageOptions;

  /// The count of items in the gallery, only used when constructed via [PhotoViewGallery.builder]
  final int itemCount;

  /// Called to build items for the gallery when using [PhotoViewGallery.builder]
  final PhotoViewGalleryBuilder builder;

  /// [ScrollPhysics] for the internal [PageView]
  final ScrollPhysics scrollPhysics;

  /// Mirror to [PhotoView.loadingBuilder]
  final LoadingBuilder loadingBuilder;

  /// Mirror to [PhotoView.loadFailedChild]
  final Widget loadFailedChild;

  /// Mirror to [PhotoView.backgroundDecoration]
  final Decoration backgroundDecoration;

  /// Mirror to [PhotoView.gaplessPlayback]
  final bool gaplessPlayback;

  /// Mirror to [PageView.reverse]
  final bool reverse;

  /// An object that controls the [PageView] inside [PhotoViewGallery]
  final PreloadPageController pageController;

  /// An callback to be called on a page change
  final PhotoViewGalleryPageChangedCallback onPageChanged;

  /// Mirror to [PhotoView.scaleStateChangedCallback]
  final ValueChanged<PhotoViewScaleState> scaleStateChangedCallback;

  /// Mirror to [PhotoView.enableRotation]
  final bool enableRotation;

  /// Mirror to [PhotoView.customSize]
  final Size customSize;

  /// The axis along which the [PageView] scrolls. Mirror to [PageView.scrollDirection]
  final Axis scrollDirection;

  bool get _isBuilder => builder != null;

  @override
  State<StatefulWidget> createState() {
    return _ComicViewState();
  }
}

class _ComicViewState extends State<ComicView> {
  PreloadPageController _controller;

  @override
  void initState() {
    _controller = widget.pageController ?? PreloadPageController();
    super.initState();
  }

  void scaleStateChangedCallback(PhotoViewScaleState scaleState) {
    if (widget.scaleStateChangedCallback != null) {
      widget.scaleStateChangedCallback(scaleState);
    }
  }

  int get actualPage {
    return _controller.hasClients ? _controller.page.floor() : 0;
  }

  int get itemCount {
    if (widget._isBuilder) {
      return widget.itemCount;
    }
    return widget.pageOptions.length;
  }

  @override
  Widget build(BuildContext context) {
    // Enable corner hit test
    return PhotoViewGestureDetectorScope(
      axis: widget.scrollDirection,
      child: PreloadPageView.builder(
        reverse: widget.reverse,
        controller: _controller,
        onPageChanged: widget.onPageChanged,
        itemCount: itemCount,
        itemBuilder: _buildItem,
        scrollDirection: widget.scrollDirection,
        physics: widget.scrollPhysics,
        preloadPagesCount: 4,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final pageOption = _buildPageOption(context, index);
    final isCustomChild = pageOption.child != null;

    final PhotoView photoView = isCustomChild
        ? PhotoView.customChild(
            key: ObjectKey(index),
            child: pageOption.child,
            childSize: pageOption.childSize,
            backgroundDecoration: widget.backgroundDecoration,
            controller: pageOption.controller,
            scaleStateController: pageOption.scaleStateController,
            customSize: widget.customSize,
            heroAttributes: pageOption.heroAttributes,
            scaleStateChangedCallback: scaleStateChangedCallback,
            enableRotation: widget.enableRotation,
            initialScale: pageOption.initialScale,
            minScale: pageOption.minScale,
            maxScale: pageOption.maxScale,
            scaleStateCycle: pageOption.scaleStateCycle,
            onTapUp: pageOption.onTapUp,
            onTapDown: pageOption.onTapDown,
            gestureDetectorBehavior: pageOption.gestureDetectorBehavior,
            tightMode: pageOption.tightMode,
            filterQuality: pageOption.filterQuality,
            basePosition: pageOption.basePosition,
            disableGestures: pageOption.disableGestures,
          )
        : PhotoView(
            key: ObjectKey(index),
            imageProvider: pageOption.imageProvider,
            loadingBuilder: widget.loadingBuilder,
            loadFailedChild: widget.loadFailedChild,
            backgroundDecoration: widget.backgroundDecoration,
            controller: pageOption.controller,
            scaleStateController: pageOption.scaleStateController,
            customSize: widget.customSize,
            gaplessPlayback: widget.gaplessPlayback,
            heroAttributes: pageOption.heroAttributes,
            scaleStateChangedCallback: scaleStateChangedCallback,
            enableRotation: widget.enableRotation,
            initialScale: pageOption.initialScale,
            minScale: pageOption.minScale,
            maxScale: pageOption.maxScale,
            scaleStateCycle: pageOption.scaleStateCycle,
            onTapUp: pageOption.onTapUp,
            onTapDown: pageOption.onTapDown,
            gestureDetectorBehavior: pageOption.gestureDetectorBehavior,
            tightMode: pageOption.tightMode,
            filterQuality: pageOption.filterQuality,
            basePosition: pageOption.basePosition,
            disableGestures: pageOption.disableGestures,
          );

    return ClipRect(
      child: photoView,
    );
  }

  PhotoViewGalleryPageOptions _buildPageOption(
      BuildContext context, int index) {
    if (widget._isBuilder) {
      return widget.builder(context, index);
    }
    return widget.pageOptions[index];
  }
}
