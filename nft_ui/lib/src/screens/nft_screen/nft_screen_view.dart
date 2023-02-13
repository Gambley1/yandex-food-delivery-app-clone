import 'package:flutter/material.dart';
import 'package:nft_ui/src/animations/fade_animation.dart';
import 'package:nft_ui/src/screens/widgets/blur_container.dart';

class NFTScreenView extends StatelessWidget {
  const NFTScreenView({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: image,
                  child: Image.asset(image),
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: FadeAnimation(
                    intervalStart: 0.1,
                    child: BlurContainer(
                      child: Container(
                        width: 160,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(.1),
                        ),
                        child: const Text(
                          'Digital NFT  Art',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: FadeAnimation(
                intervalStart: 0.3,
                child: Text(
                  'Monkey #241',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: FadeAnimation(
                intervalStart: 0.35,
                child: Text(
                  'Owned by Chris',
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 24,
              ),
              child: FadeAnimation(
                intervalStart: 0.4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _InfoTile(
                      title: '2d 3h 14sec',
                      subtitle: 'Remaining Time',
                    ),
                    _InfoTile(
                      title: '18.9 ETH',
                      subtitle: 'Highest Bid',
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: FadeAnimation(
                intervalStart: 0.6,
                child: Container(
                  height: 52,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xff3000ff),
                  ),
                  child: const Text(
                    'Place Bid',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.white54),
        ),
      ],
    );
  }
}
