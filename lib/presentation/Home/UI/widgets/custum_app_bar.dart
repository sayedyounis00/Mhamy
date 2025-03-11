import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustumAppBar extends StatelessWidget {
  const CustumAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMMM d').format(now);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sayed Tasks',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                formattedDate,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          GestureDetector(
            child: const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white24,
              child: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
            ),
            onTap: (){} 
          
          ),
        ],
      ),
    );
  }
}
