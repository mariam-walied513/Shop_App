import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/order_tab.dart';
import '../widgets/order_card.dart';
import '../cubits/orders_cubit.dart';
import '../cubits/orders_state.dart';
import '../models/order.dart';
import 'order_details_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int selectedTab = 0;

  static const Color primaryPink = Color(0xFFFF3155);
  static const Color lightPink = Color(0xFFFFC5CF);

  String _getEmptyMessage() {
    if (selectedTab == 0) {
      return "You don't have any\nactive orders at this\ntime";
    } else if (selectedTab == 1) {
      return "You don't have any\ncompleted orders at this\ntime";
    } else {
      return "You don't have any\ncancelled orders at this\ntime";
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OrdersCubit>();
    final state = cubit.state;

    List<Order> currentOrders = [];
    if (state is OrdersLoaded) {
      if (selectedTab == 0) {
        currentOrders = state.activeOrders;
      } else if (selectedTab == 1) {
        currentOrders = state.completedOrders;
      } else {
        currentOrders = state.cancelledOrders;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(
              child: currentOrders.isEmpty
                  ? _buildEmptyState(_getEmptyMessage())
                  : _buildOrdersList(currentOrders, cubit),
            ),
            _buildBottomLine(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'My Orders',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 60),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Row(
        children: [
          Expanded(
            child: OrderTab(
              title: 'Active',
              selected: selectedTab == 0,
              activeColor: primaryPink,
              inactiveColor: lightPink,
              onTap: () => setState(() => selectedTab = 0),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: OrderTab(
              title: 'Completed',
              selected: selectedTab == 1,
              activeColor: primaryPink,
              inactiveColor: lightPink,
              onTap: () => setState(() => selectedTab = 1),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: OrderTab(
              title: 'Cancelled',
              selected: selectedTab == 2,
              activeColor: primaryPink,
              inactiveColor: lightPink,
              onTap: () => setState(() => selectedTab = 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Column(
      children: [
        const Spacer(flex: 34),
        Image.asset(
          'lib/assets/images/Transfer Document icon.png',
          width: 150,
          height: 175,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 18),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: primaryPink,
            fontSize: 24,
            height: 1.08,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(flex: 45),
      ],
    );
  }

  Widget _buildOrdersList(List<Order> orders, OrdersCubit cubit) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(21, 12, 21, 20),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final isActive = order.status == OrderStatus.active;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrderDetailsScreen(order: order),
              ),
            );
          },
          child: OrderCard(
            order: order,
            onCancel: isActive ? () => cubit.cancelOrder(order) : null,
            onTrack: isActive ? () => cubit.completeOrder(order) : null,
          ),
        );
      },
    );
  }

  Widget _buildBottomLine() {
    return Container(
      height: 4,
      width: double.infinity,
      color: const Color(0xFF777777),
    );
  }
}