import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;

class DataPreviewCardPage extends StatelessWidget {
  const DataPreviewCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ds.AppScaffold(
      title: 'Data Preview Card',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(context, 'Basic Data Preview Card', children: [
            ds.DataPreviewCard(
              title: 'Total Revenue',
              value: '\$124,500',
              valueLabel: 'Current',
              lottieTitle: 'Growth',
              lottieWidget: _buildMockLottie(Icons.trending_up),
            ),
          ]),
          _section(context, 'Card with Custom Styling', children: [
            ds.DataPreviewCard(
              title: 'Active Users',
              value: '8,432',
              valueLabel: 'Today',
              lottieTitle: 'Online',
              lottieWidget: _buildMockLottie(Icons.people),
              backgroundColor: Colors.blue.withValues(alpha: 0.1),
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              valueStyle: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.blue,
              ),
            ),
          ]),
          _section(context, 'Multiple Cards Grid', children: [
            GridView.count(
              crossAxisCount: context.isWindowCompact ? 1 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                ds.DataPreviewCard(
                  title: 'Orders',
                  value: '1,234',
                  valueLabel: 'Total',
                  lottieTitle: 'Today',
                  lottieWidget: _buildMockLottie(Icons.shopping_cart),
                ),
                ds.DataPreviewCard(
                  title: 'Conversion',
                  value: '3.2%',
                  valueLabel: 'Rate',
                  lottieTitle: 'Trend',
                  lottieWidget: _buildMockLottie(Icons.show_chart),
                ),
                ds.DataPreviewCard(
                  title: 'Bounce Rate',
                  value: '42%',
                  valueLabel: 'Current',
                  lottieTitle: 'Status',
                  lottieWidget: _buildMockLottie(Icons.analytics),
                ),
                ds.DataPreviewCard(
                  title: 'Session Time',
                  value: '4m 32s',
                  valueLabel: 'Average',
                  lottieTitle: 'Duration',
                  lottieWidget: _buildMockLottie(Icons.access_time),
                ),
              ],
            ),
          ]),
          _section(context, 'Compact Variant', children: [
            const ds.DataPreviewCardCompact(
              title: 'Downloads',
              value: '45,678',
              icon: Icon(Icons.download, color: Colors.green),
            ),
            const SizedBox(height: 8),
            const ds.DataPreviewCardCompact(
              title: 'Uploads',
              value: '12,345',
              icon: Icon(Icons.upload, color: Colors.orange),
            ),
            const SizedBox(height: 8),
            const ds.DataPreviewCardCompact(
              title: 'Storage Used',
              value: '78%',
              icon: Icon(Icons.storage, color: Colors.purple),
            ),
          ]),
          _section(context, 'Card Without Lottie', children: [
            ds.DataPreviewCard(
              title: 'Server Status',
              value: 'Operational',
              valueLabel: 'Status',
              backgroundColor: Colors.green.withValues(alpha: 0.1),
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              valueStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ]),
          _section(context, 'With Custom Border Radius', children: [
            ds.DataPreviewCard(
              title: 'Temperature',
              value: '24°C',
              valueLabel: 'Room',
              lottieTitle: 'Climate',
              lottieWidget: _buildMockLottie(Icons.thermostat),
              borderRadius: 24,
              padding: const EdgeInsets.all(20),
            ),
          ]),
          _section(context, 'Financial Data Example', children: [
            ds.DataPreviewCard(
              title: 'Portfolio Value',
              value: '\$1.2M',
              valueLabel: 'Total',
              lottieTitle: '+12.5%',
              lottieWidget: _buildMockLottie(Icons.account_balance),
              backgroundColor: Colors.green.withValues(alpha: 0.08),
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              valueStyle: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              lottieTitleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildMockLottie(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 32,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _section(BuildContext context, String title,
      {required List<Widget> children}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
