import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final bool isMobile;

  const HeroSection({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 16 : 40,
      ),
      child:
      isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(context),
          const SizedBox(height: 40),
          _buildIntroText(context),
        ],
      )
          : Row(
        children: [
          Expanded(flex: 3, child: _buildIntroText(context)),
          Expanded(flex: 2, child: _buildAvatar(context)),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Center(
      child: Container(
        width: isMobile ? 200 : 300,
        height: isMobile ? 200 : 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset('Assets/Skills/pranav.jpeg', fit: BoxFit.fill),
        ),
      ),
    );
  }

  Widget _buildIntroText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hello, I\'m',
          style: TextStyle(fontSize: isMobile ? 18 : 24, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          'Pranav',
          style: TextStyle(
            fontSize: isMobile ? 40 : 60,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Flutter Developer',
          style: TextStyle(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Based in Calicut, I specialize in creating beautiful, responsive, and user-friendly mobile applications using Flutter.',
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: Colors.grey[300],
            height: 1.5,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'View Projects',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Contact Me'),
            ),
          ],
        ),
      ],
    );
  }
}