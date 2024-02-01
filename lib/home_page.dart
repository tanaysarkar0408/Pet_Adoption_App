//todo lastAttempt
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app_bloc/Bloc/pet_bloc.dart';
import 'package:pet_app_bloc/details_page.dart';
import 'package:pet_app_bloc/history_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetBloc, PetState>(
        // cubit: widget.petBloc,
        builder: (context, state) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'P E T  A D O P T I O N',
                    style: GoogleFonts.akatab(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                  //   SizedBox(
                  //   width: double.infinity,
                  //   child: CarouselSlider.builder(
                  //     itemCount: snapshot.data!.length,
                  //     options: CarouselOptions(
                  //       height: 300,
                  //       autoPlay: true,
                  //       viewportFraction: 0.55,
                  //       enlargeCenterPage: true,
                  //       pageSnapping: true,
                  //       autoPlayCurve: Curves.fastOutSlowIn,
                  //       autoPlayAnimationDuration: const Duration(seconds: 1),
                  //     ),
                  //     itemBuilder: (context, itemIndex, pageViewIndex) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => DetailsScreen(
                  //                 movie: snapshot.data[itemIndex],
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.circular(12),
                  //           child: SizedBox(
                  //             height: 300,
                  //             width: 200,
                  //             child: Image.network(
                  //               filterQuality: FilterQuality.high,
                  //               fit: BoxFit.cover,
                  //               '${Constants.imagePath}${snapshot.data[itemIndex].posterPath}',
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[900],
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              // Dispatch a SearchPetsEvent to the PetBloc
                              BlocProvider.of<PetBloc>(context)
                                  .add(SearchPetsEvent(query: value));
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search by name or category',
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<PetBloc, PetState>(
                          builder: (context, state) {
                            print('HomePage state is $state');
                            if (state is PetsLoadedState) {
                              return ListView.builder(
                                itemCount: state.pets.length,
                                itemBuilder: (context, index) {
                                  final pet = state.pets[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    child: Card(
                                      surfaceTintColor: Colors.greenAccent,
                                      shadowColor: Colors.black,
                                      color: Colors.grey[900],
                                      elevation: 5.0,
                                      child: ListTile(
                                        trailing: Text(pet.isAdopted? 'Already Adopted' : 'Adopt'),
                                        leading: Hero(
                                          tag: 'hero-tag-${pet.id}',
                                          child: CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage:
                                                AssetImage(pet.imageAssetPath),
                                          ),
                                        ),
                                        title: Text(pet.name),
                                        subtitle: Text(pet.category),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                pet: pet,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: BlocProvider.of<PetBloc>(context),
                                    child: HistoryPage(),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Colors.grey.shade500,
                                          Colors.black
                                        ]),
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50)),
                                height:
                                    (MediaQuery.of(context).size.height) / 15,
                                width:
                                    (MediaQuery.of(context).size.width) / 1.2,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'HISTORY',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 28),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
