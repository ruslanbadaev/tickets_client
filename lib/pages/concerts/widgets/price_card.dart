import 'package:flutter/material.dart';
import 'package:xl/xl.dart';

import '../../../models/marker.dart';
import '../../../models/price.dart';
import '../../../utils/constants/colors.dart';

class PriceCardWidget extends StatefulWidget {
  final MarkerModel price;
  final MarkerModel? selectedPrice;
  final Function(MarkerModel) selectPrice;
  final Function(MarkerModel) onDeletePrice;

  const PriceCardWidget({
    Key? key,
    required this.price,
    required this.selectedPrice,
    required this.selectPrice,
    required this.onDeletePrice,
  }) : super(key: key);

  @override
  State<PriceCardWidget> createState() => _PriceCardWidgetState();
}

class _PriceCardWidgetState extends State<PriceCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            widget.selectPrice(widget.price);
          },
          child: Card(
            elevation: 5,
            child: Row(
              children: [
                const SizedBox(width: 12),
                Column(
                  children: [
                    Text(
                      widget.price.name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    if (widget.price.price != null && widget.price.price != '')
                      Row(
                        children: [
                          const Text(
                            'Цена: ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            widget.price.price ?? '?',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(width: 42),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                  child: Container(
                    height: 64,
                    width: 64,
                    color: widget.price.color,
                    child: widget.price == widget.selectedPrice
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 32,
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            widget.onDeletePrice(widget.price);
          },
          child: const Card(
            elevation: 5,
            child: SizedBox(
              height: 64,
              width: 64,
              child: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
