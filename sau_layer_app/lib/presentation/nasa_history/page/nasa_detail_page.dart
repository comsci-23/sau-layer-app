import 'package:flutter/material.dart';
import 'package:sau_layer_app/utils/AppColors.dart';
import 'package:sau_layer_data/domain/entities/nasa_layer_data.dart';
import 'package:google_fonts/google_fonts.dart';

class NasaDetailPage extends StatelessWidget {
  final NasaLayerData nasaData;

  const NasaDetailPage({super.key, required this.nasaData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStartColor, AppColors.gradientEndColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                nasaData.title,
                style: GoogleFonts.poppins(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              expandedHeight: 100,
              floating: false,
              pinned: true,
              elevation: 4,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [
                        AppColors.gradientStartColor,
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcOver,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.gradientStartColor,
                          AppColors.gradientEndColor
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: nasaData.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            nasaData.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      nasaData.title,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      nasaData.description,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ID: ${nasaData.id}',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
