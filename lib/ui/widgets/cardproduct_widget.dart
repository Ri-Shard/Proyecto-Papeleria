import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/product_model.dart';

class CardProduct extends StatefulWidget {
  final Producto product;
  final Color colorAccent;

  const CardProduct({Key? key,required this.product, this.colorAccent = Colors.deepPurple}) : super(key: key);

  @override
  _CardProductState createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct>
    with SingleTickerProviderStateMixin {
  Color colorFond = Colors.cyan.shade100.withOpacity(0.1);

  late double _scale;

  late AnimationController _controller;

  /// FUNCTION
  void _tapDown(TapDownDetails details) => _controller.forward();
  void _tapUp(TapUpDetails details) => _controller.reverse();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return Transform.scale(
      scale: _scale,
      child: Card(
        elevation: 10.0,
        clipBehavior: Clip.antiAlias,
        color: colorFond.withOpacity(0.5),
        margin: const EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: GestureDetector(
          onTapDown: _tapDown,
          onTapUp: _tapUp,
          onTap: () {},
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.image,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
                placeholder: (context, url) => Container(
                  color: Colors.grey,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.star,
                                size: 16,
                                color: widget.colorAccent.withOpacity(0.7)),
                            Text(widget.product.name,
                                style: TextStyle(
                                    color: widget.colorAccent.withOpacity(0.5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  _buildContentInfo(obj: widget.product),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
    Card _buildContentInfo({required var obj}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            width: double.infinity,
            decoration:
                BoxDecoration(color: Colors.grey.shade200.withOpacity(0.3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text("\$" + widget.product.price,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end),
              ],
            ),
          ),
        ),
      ),
    );
  }
    }