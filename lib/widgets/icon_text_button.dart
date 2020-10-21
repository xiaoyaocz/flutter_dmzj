import 'package:flutter/material.dart';

class IconTextButton extends StatefulWidget {
  final Icon icon;
  final String title;
  final Function onTap;
  IconTextButton(this.icon, this.title, this.onTap, {Key key})
      : super(key: key);

  _IconTextButtonState createState() => _IconTextButtonState();
}

class _IconTextButtonState extends State<IconTextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.icon,
              Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(widget.title))
            ],
          ),
        ),
      )),
    );
  }
}
