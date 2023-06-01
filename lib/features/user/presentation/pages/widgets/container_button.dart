import 'package:flutter/material.dart';

class ContainerButton extends StatefulWidget {
  final double? height;
  final double?width;
  final Color? fillColor;
  final double? borderWidth;
  final String? text;
  final Color? borderColor;
  final bool? isBorder;
  final TextStyle? textStyle;

  const ContainerButton(
      {Key? key, this.height, this.width, this.fillColor, this.borderWidth, this.text, this.borderColor, this.isBorder, this.textStyle,})
      : super(key: key);

  @override
  State<ContainerButton> createState() => _ContainerButtonState();
}

class _ContainerButtonState extends State<ContainerButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:widget.height??50,
      width: widget.width??MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.fillColor,
        border: widget.isBorder==true
            ? Border.all(
          width: widget.borderWidth!,
          color: widget.borderColor!,
        )
            : null,
      ),
      child: Center(child: Text("${widget.text}",style: widget.textStyle,)),
    );
  }
}
