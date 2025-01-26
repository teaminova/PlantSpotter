import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'PlantSpotter',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(0xFF6B8E58),
                    ),
                  ),
                  const SizedBox(height: 200),
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      onPressed: () => context.push('/journal'),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Set the border radius
                        ),
                      ),
                      child: const Text('My Journal'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      onPressed: () => context.push('/community'),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Set the border radius
                        ),
                      ),
                      child: const Text('Community'),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: Transform.translate(
                offset: const Offset(3.0, 0.0),
                child: const Icon(Icons.logout),
              ),
              onPressed: () => context.push('/login'),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF6B8E58),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
