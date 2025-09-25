import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/core.dart';

class FileDTO {
  FileDTO({this.xfile, this.networkImagePath,});
  XFile? xfile;
  String? networkImagePath;
}

class EditReorderableListViewWidget extends StatefulWidget {
  const EditReorderableListViewWidget({Key? key, required this.images, required this.onReorder, required this.onRemove, this.originImages}) : super(key: key);

  final List<FileDTO> images;
  final Function(List<FileDTO>) onReorder;
  final Function(int) onRemove;
  final List<Resource>? originImages;


  @override
  State<EditReorderableListViewWidget> createState() => _ReorderableListViewWidgetState();
}

class _ReorderableListViewWidgetState extends State<EditReorderableListViewWidget> {
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
      children:widget.images.isEmpty?
      List.empty(): List.generate(
        widget.images.length,
            (index) => Container(
          key: widget.images[index].networkImagePath != null && widget.images[index].networkImagePath!.isNotEmpty
              ? Key(widget.images[index].networkImagePath!.toString())
              : widget.images[index].xfile != null && widget.images[index].xfile!.path != null
              ? Key(widget.images[index].xfile!.path!)
              : UniqueKey(),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: widget.images[index].networkImagePath != null &&
                    widget.images[index].networkImagePath!.isNotEmpty
                    ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage('$imageUrl${widget.images[index].networkImagePath}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : widget.images[index].xfile != null && widget.images[index].xfile!.path != null
                    ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: FileImage(File(widget.images[index].xfile!.path!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Container(),
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
