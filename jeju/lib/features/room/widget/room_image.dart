import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/core.dart';
import '../bloc/room_detail_bloc.dart';
import '../bloc/room_state.dart';

class RoomImageWidget extends StatelessWidget {
  const RoomImageWidget({super.key, this.room, this.imageList});

  final Room? room;
  final List<XFile>? imageList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'roomImage',
          child: CarouselSlider(
              items:
              imageList != null
                  ? imageList
                      ?.map((e) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(e.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ))
                      .toList()
                  :
              room?.imageList.isEmpty ?? true
                      ? [
                          CachedNetworkImage(
                              imageUrl: 'https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}',
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return Container(
                                  height: 500,
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: white,
                                  ),
                                );
                              }),
                          CachedNetworkImage(
                              imageUrl: 'https://picsum.photos/${Random().nextInt(100) + 1920}/${Random().nextInt(100) + 1080}',
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return Container(
                                  height: 500,
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: white,
                                  ),
                                );
                              }),
                        ]
                      : room?.imageList
                          .map((e) => CachedNetworkImage(
                              imageUrl: '$imageUrl${e.path}',
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return Container(
                                  height: 500,
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: white,
                                  ),
                                );
                              }))
                          .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                initialPage: 0,
                aspectRatio: 428 / 480,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                scrollDirection: Axis.horizontal,
              )),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  IconButton(
                    splashRadius: 24,
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.pop();
                    },
                    icon: const SvgImage('assets/icons/ic_arrow_back.svg'),
                  ),
                  BlocBuilder<RoomDetailBloc, RoomDetailState>(
                  builder: (context, state) {
                      return Container(
                        child: Row(
                          children: [
                            IconButton(onPressed: (){

                            }, icon: Icon(Icons.report_outlined)),
                            IconButton(onPressed: (){}, icon: Icon(Icons.share_outlined)),
                            IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined
                            ))
                          ],
                        ),
                      );
                  },),
                ],
              )
            ),
          ),
        ),
      ],
    );
  }
}
