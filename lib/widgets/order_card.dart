import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onCancel;
  final VoidCallback? onTrack;

  const OrderCard({
    super.key,
    required this.order,
    this.onCancel,
    this.onTrack,
  });

  static const Color primaryPink = Color(0xFFFF3155);

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;

    int hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'pm' : 'am';

    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;

    return '$day/$month/$year $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final product = order.firstProduct;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.image,
              width: 90,
              height: 100,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const SizedBox(
                  width: 90,
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: primaryPink,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stack) {
                return Container(
                  width: 90,
                  height: 100,
                  color: const Color(0xFFF1F1F1),
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      order.formatPrice(order.subtotal),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  _formatDate(order.date),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xff888888),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  '${order.itemsCount} item${order.itemsCount > 1 ? 's' : ''}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xff888888),
                  ),
                ),

                const SizedBox(height: 10),

                if (onCancel != null || onTrack != null)
                  Row(
                    children: [
                      if (onCancel != null)
                        Expanded(
                          child: SizedBox(
                            height: 28,
                            child: ElevatedButton(
                              onPressed: onCancel,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryPink,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),

                      if (onCancel != null && onTrack != null)
                        const SizedBox(width: 8),

                      if (onTrack != null)
                        Expanded(
                          child: SizedBox(
                            height: 28,
                            child: ElevatedButton(
                              onPressed: onTrack,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryPink,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Track Driver',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                if (order.status == OrderStatus.completed)
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: primaryPink,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Order delivered',
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryPink,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (order.status == OrderStatus.cancelled)
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cancel_outlined,
                          color: primaryPink,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Order Cancelled',
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryPink,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}