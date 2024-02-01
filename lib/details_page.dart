//todo last
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app_bloc/Bloc/pet_bloc.dart';
import 'package:pet_app_bloc/pet.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailsPage extends StatefulWidget {
  final Pet pet;

  DetailsPage({required this.pet});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int currentIndex = 0;
  final confettiController = ConfettiController(duration: const Duration(seconds:1));
  bool isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    confettiController.addListener(() {
      setState(() {
        isPlaying = confettiController.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetBloc, PetState>(
      builder: (context, state) => BlocBuilder<PetBloc, PetState>(
        builder: (context, state) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: GestureDetector(
                      onTap: () {
                        // state as PetsLoadedState;
                        // BlocProvider.of<PetBloc>(context)
                        //     .loadPet(widget.pet);
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                    backgroundColor: Colors.grey[800],
                    expandedHeight: 500,
                    pinned: true,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'So this is :- ${widget.pet.name}',
                          style: GoogleFonts.belleza(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      background: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhotoViewer(
                                  images: [widget.pet.imageAssetPath],
                                  index: currentIndex,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'hero-tag-${widget.pet.id}',
                            child: Image.asset(
                              widget.pet.imageAssetPath,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'D E T A I L S',
                            style: GoogleFonts.akatab(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(8),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 150,
                                  width: 100,
                                  child: Card(
                                    color: Colors.cyan[200],
                                    elevation: 20,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.cake_outlined),
                                          const Text(
                                            'Age :',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            '${widget.pet.age} years',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: 100,
                                  child: Card(
                                    color: Colors.amber[200],
                                    elevation: 20,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                              Icons.price_change_outlined),
                                          const Text(
                                            'Price :',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            '\$${widget.pet.price}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  width: 100,
                                  child: Card(
                                    color: Colors.greenAccent,
                                    elevation: 20,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18.0),
                                            child: Text(
                                              'Is ${widget.pet.name} adopted :',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            widget.pet.isAdopted ? 'Yes' : 'No',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              color: Colors.black,
                              width: (MediaQuery.of(context).size.width) / 1.5,
                              height: (MediaQuery.of(context).size.height) / 15,
                              child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<PetBloc>(context)
                                      .adoptPet(widget.pet);
                                  print('Pressed');
                                  print("When pressed state is $state");
                                  //toggle isAdopt
                                  setState(() {
                                    widget.pet.isAdopted =
                                        !widget.pet.isAdopted;
                                  });
                                  if(widget.pet.isAdopted){
                                    if (isPlaying) {
                                      confettiController.stop();
                                    } else {
                                      confettiController.play();
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(22.0),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      return widget.pet.isAdopted
                                          ? Colors.grey
                                          : Colors.blue;
                                    },
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: Text(widget.pet.isAdopted
                                    ? '${widget.pet.name} Adopted'
                                    : 'Adopt ${widget.pet.name}'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ConfettiWidget(
              numberOfParticles: 50,
              maxBlastForce: 100,
              emissionFrequency: 0.05,
              minBlastForce: 5.0,
              confettiController: confettiController,
              shouldLoop: false,
              blastDirectionality: BlastDirectionality.explosive,
            )
          ],
        ),
      ),
    );
  }
}

class PhotoViewer extends StatelessWidget {
  final List<String> images;
  final int index;

  PhotoViewer({required this.images, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: AssetImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(initialPage: index),
      ),
    );
  }
}
