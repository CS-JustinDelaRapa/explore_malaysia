import 'package:explore_malaysia/models/statistics.dart';
import 'package:explore_malaysia/store/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:explore_malaysia/store/app_state.dart';
import 'package:video_player/video_player.dart';
import 'package:explore_malaysia/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://explore.com.my/video/Malaysia-4K%20%281%29.mp4'),
    )..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0);
        setState(() {});
      });
    
    // Fetch statistics when screen loads
    StoreProvider.of<AppState>(context, listen: false)
        .dispatch(fetchStatistics());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.blackWithOpacity(0.5),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  const Column(
                    children: [
                      Text(
                        'Explore Malaysia',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          fontFamily: 'TanAegean',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'List. Seek. Explore',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: AppColors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: StoreConnector<AppState, PropertyStatistics>(
                      converter: (store) => store.state.statistics,
                      builder: (context, statistics) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: _buildStatistic(
                                '${statistics.totalProperties}',
                                'Properties Available',
                              ),
                            ),
                            Flexible(
                              child: _buildStatistic(
                                '${statistics.totalApartments}',
                                'Apartments',
                              ),
                            ),
                            Flexible(
                              child: _buildStatistic(
                                '${statistics.totalHouses}',
                                'Houses',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Find Your Dream Home in Malaysia's Freshest Developments",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.push('/search'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 16,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text(
                          'Discover',
                          style: TextStyle(
                            color: AppColors.primary,
                          ),                        
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistic(String value, String label) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryWithOpacity(0.15),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
