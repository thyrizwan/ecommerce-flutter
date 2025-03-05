import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/common/ui/widgets/my_snack_bar.dart';
import 'package:ecommerce/features/profile/ui/widgets/log_in_widget.dart';
import 'package:ecommerce/features/profile/ui/widgets/log_out_widget.dart';
import 'package:flutter/material.dart';

class ProfileMenuListScreen extends StatefulWidget {
  const ProfileMenuListScreen({super.key});

  static const String name = '/profile-menu-list';

  @override
  State<ProfileMenuListScreen> createState() => _ProfileMenuListScreenState();
}

class _ProfileMenuListScreenState extends State<ProfileMenuListScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _basicTask();
    setState(() {});
  }

  Future<void> _basicTask() async {
    var sharedprefs = SharedPreferenceHelper();
    _isLoggedIn = await sharedprefs.isLoggedIn();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildProfileOverview(),
            // SizedBox(height: 16.0),
            _buildSection('PERSONAL DETAILS', [
              _buildListTile('Personal Information'),
              _buildListTile('Saved Addresses'),
              _buildListTile('Payment Methods'),
              _buildListTile('Order Preferences'),
            ]),
            const SizedBox(height: 16.0),
            _buildSection('GENERAL', [
              _buildListTile('Order History'),
              _buildListTile('Shipping & Delivery'),
              _buildListTile('Returns & Refunds'),
              _buildListTile('Customer Support'),
              _buildListTile('Legal & Policies'),
            ]),
            const SizedBox(height: 16.0),
            Center(
              child: _isLoggedIn ? const LogOutWidget() : const LogInWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOverview() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Total Orders', '56'),
            _buildRow('Membership Level', 'Gold'),
            ListTile(
              title: const Text('Membership Card'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildListTile(String title) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        MySnackBar.show(
            title: 'Under Development',
            type: SnackBarType.info,
            message: '$title is under Development');
      },
    );
  }
}
