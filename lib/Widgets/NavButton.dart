import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBarButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isHighlighted;

  const NavBarButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  State<NavBarButton> createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color:
            widget.isHighlighted
                ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                : _isHovered
                ? Colors.white.withOpacity(0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border:
            widget.isHighlighted
                ? Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            )
                : null,
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color:
              widget.isHighlighted || _isHovered
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}