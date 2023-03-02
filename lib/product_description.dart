import 'package:flutter/material.dart';
import 'reusable_appbar.dart';

class ProductDescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ProductDescriptionpage();
  }
}

class ProductDescriptionpage extends StatefulWidget {
  const ProductDescriptionpage({Key? key}) : super(key: key);

  @override
  State<ProductDescriptionpage> createState() => _ProductDescriptionpageState();
}

class _ProductDescriptionpageState extends State<ProductDescriptionpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ReusableAppBar(),
        ],
      ),
    );
  }
}
