import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.heading);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content);
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  IconAndDetail(this.icon, this.detail, this.colorIcon, {Key? key})
      : super(key: key);
  final IconData icon;
  final String detail;
  final Color colorIcon;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [Icon(icon), const SizedBox(width: 8), Text(detail)],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final String child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        // style: OutlinedButton.styleFrom(
        //     side: BorderSide(color: Theme.of(context).colorScheme.primary)),
        onPressed: onPressed,
        child: Text(child),
      );
}
