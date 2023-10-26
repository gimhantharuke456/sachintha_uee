import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sachintha_uee/components/loading.dart';
import 'package:sachintha_uee/providers/loading_provider.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget secondScreen;
  const LoadingWrapper({super.key, required this.secondScreen});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(builder: (context, value, child) {
      return value.isLoading ? const Loading() : secondScreen;
    });
  }
}
