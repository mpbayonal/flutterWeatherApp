import 'package:flutter/material.dart';

/// Private class __AlertDialog
/// cannot use
class __AlertDialog extends StatefulWidget {
  final String title, message, positiveText, negativeText, neutralText;
  final Function positiveAction, negativeAction, neutralAction;
  final bool showNeutralButton;
  final TextAlign textAlign;

  __AlertDialog({
    required this.title,
    required this.message,
    required this.showNeutralButton,
    required this.neutralText,
    required this.neutralAction,
    required this.positiveText,
    required this.positiveAction,
    required this.negativeText,
    required this.negativeAction,
    required this.textAlign,
  });

  @override
  __AlertDialogState createState() => __AlertDialogState();
}

class __AlertDialogState extends State<__AlertDialog> {
  bool _confirmDeleteAction = false;
  late double _screenWidth;

  var _dialogIcon;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  _positiveActionPerform() {
    Navigator.of(context).pop(); // To close the dialog
  }

  _getPositiveButtonColor() {
    var color = Theme.of(context).accentColor;
    return color;
  }

  _positiveButton(BuildContext context) {
    if (widget.positiveText != null && widget.positiveAction != null) {
      return FlatButton(
        onPressed: _positiveActionPerform,
        child: Text(
          widget.positiveText,
          style: TextStyle(
            color: _getPositiveButtonColor(),
          ),
        ),
      );
    }
    return SizedBox();
  }

  _negativeButton(BuildContext context) {
    if (widget.negativeText != null && widget.negativeAction != null) {
      return FlatButton(
        onPressed: () {
          Navigator.of(context).pop(); // To close the dialog
          widget.negativeAction();
        },
        child: Text(
          widget.negativeText,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      );
    }
    return SizedBox();
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: _screenWidth >= 600 ? 500 : _screenWidth,
          padding: EdgeInsets.only(
            top: 45.0 + 16.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          margin: EdgeInsets.only(top: 55.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(80.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              if (widget.title.isNotEmpty)
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              SizedBox(height: 16.0),
              Flexible(
                fit: FlexFit.loose,
                child: SingleChildScrollView(
                  child: Text(
                    widget.message,
                    textAlign: widget.textAlign == null
                        ? TextAlign.center
                        : widget.textAlign,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Generic dialog function
dialog(
  BuildContext context,
  String title,
  String message,
  bool showNeutralButton,
  bool closeOnBackPress, {
  required String neutralText,
  required Function neutralAction,
  required String positiveText,
  required Function positiveAction,
  required String negativeText,
  required Function negativeAction,
  textAlign: TextAlign.center,
}) {
  return showDialog(
      barrierDismissible: closeOnBackPress,
      context: context,
      builder: (BuildContext context) {
        return __AlertDialog(
          title: title,
          message: message,
          showNeutralButton: showNeutralButton,
          neutralText: neutralText,
          neutralAction: neutralAction,
          positiveText: positiveText,
          positiveAction: positiveAction,
          negativeText: negativeText,
          negativeAction: negativeAction,
          textAlign: textAlign,
        );
      });
}
