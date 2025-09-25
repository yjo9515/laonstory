import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/core.dart';

class ReorderableListViewWidget extends StatefulWidget {
  const ReorderableListViewWidget({super.key, required this.images, required this.onReorder, required this.onRemove, this.originImages});

  final List<XFile> images;
  final Function(List<XFile>) onReorder;
  final Function(int) onRemove;
  final List<Resource>? originImages;


  @override
  State<ReorderableListViewWidget> createState() => _ReorderableListViewWidgetState();
}

class _ReorderableListViewWidgetState extends State<ReorderableListViewWidget> {
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    final gridViewKey = GlobalKey();

    return  ReorderableBuilder(
      scrollController: scrollController,
      onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
        for (final orderUpdateEntity in orderUpdateEntities) {
          final image = widget.images.removeAt(orderUpdateEntity.oldIndex);
          widget.images.insert(orderUpdateEntity.newIndex, image);
        }
        widget.onReorder(widget.images);
        setState(() {});
      },
      builder: (children) {
        return GridView(
          shrinkWrap: true,
          key: gridViewKey,
          controller: scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          children: children,
        );
      },
      children: List.generate(
        widget.images.length,
        (index) => Container(
          key: Key(widget.images.elementAt(index).name),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child:
                  Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image:
              FileImage( File(widget.images.elementAt(index).path)),
              fit: BoxFit.cover,
            ),
          ),
                // ) :
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(16),
                //     image: DecorationImage(
                //       image:
                //       FileImage(File(widget.images.elementAt(index).path) ),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                )
              ),
              if (index != 0)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                    child: Text(
                      '${index + 1}',
                      style: context.textTheme.krSubtext2.copyWith(color: white),
                    ),
                  ),
                ),
              if (index == 0)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(28)),
                    child: Text(
                      '대표사진',
                      style: context.textTheme.krSubtext2.copyWith(color: white),
                    ),
                  ),
                ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    widget.onRemove(index);
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                    child: const Icon(Icons.close, color: white, size: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
