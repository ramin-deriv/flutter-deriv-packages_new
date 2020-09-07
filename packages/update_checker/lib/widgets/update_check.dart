import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:update_checker/update_bloc.dart';
import 'package:update_checker/update_event.dart';
import 'package:update_checker/update_info.dart';
import 'package:update_checker/update_state.dart';

/// [UpdateCheck] helps in easily integrating logic for checking Updates.
/// You can simply extend this class and override [showOptionalAlert] and
/// [showMandatoryPage] methods. The extended widget can be inserted into
/// application where ever you wish to show the alert.
class UpdateCheck extends StatelessWidget {
  /// Use this widget as parent to any [child] widget
  final Widget child;

  UpdateCheck({this.child});

  /// Use [showOptionalAlert] for showing Optional Alerts
  void showOptionalAlert(BuildContext context, UpdateInfo update) {}

  /// Use [showMandatoryPage] for mandatory updates
  void showMandatoryPage(BuildContext context, UpdateInfo update) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateCheckBloc, UpdateCheckState>(
      builder: (context, state) {
        var bloc = BlocProvider.of<UpdateCheckBloc>(context);
        if (state is UpdateAvailable) {
          UpdateInfo info = state.updateInfo;
          // Returning future to run Task after Rendering is done
          Future.microtask(() {
            if (info.isOptional) {
              showOptionalAlert(context, info);
            } else {
              showMandatoryPage(context, info);
            }
            bloc.add(UpdateCheckMarkSeen());
          });
        }
        return child;
      },
    );
  }
}
