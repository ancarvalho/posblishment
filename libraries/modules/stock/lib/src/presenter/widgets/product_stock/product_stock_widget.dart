import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product_stock.dart';

class ProductStockWidget extends StatelessWidget {
  final ProductStock productStock;
  const ProductStockWidget({super.key, required this.productStock});

  @override
  Widget build(BuildContext context) {
    return Card(
       
      child: SizedBox(
        height: Sizes.height(context)/12,
        child: Padding(
          padding:  EdgeInsets.all(Sizes.dp10(context)),
          child: Stack(
            alignment: AlignmentDirectional.center,
            
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productStock.name,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    productStock.totalAvailable.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
