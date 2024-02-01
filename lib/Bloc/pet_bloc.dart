import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_app_bloc/pet.dart';

// Events
abstract class PetEvent {}

class SearchPetsEvent extends PetEvent {
  final String query;

  SearchPetsEvent({required this.query});
}

class AdoptPetEvent extends PetEvent {
  final Pet adoptedPet;

  AdoptPetEvent({required this.adoptedPet});
}



// States
abstract class PetState {}

class PetsLoadedState extends PetState {
  final List<Pet> pets;

  PetsLoadedState(this.pets);
}

class AdoptedPetsLoadedState extends PetState {
  List<Pet> adoptedPets;

  AdoptedPetsLoadedState(this.adoptedPets);
}

// BLoC

class PetBloc extends Bloc<PetEvent, PetState> {
  late List<Pet> _pets;
  late List<Pet> _adoptedPets;

  PetBloc() : super(PetsLoadedState(List.from([]))) {
    _pets = [
      Pet(
          id: '1',
          name: 'Buddy',
          category: 'Cat',
          age: 3,
          price: 100.0,
          imageAssetPath: 'assets/buddy_image.jpg',
          adoptionDate: null),
      Pet(
          id: '2',
          name: 'Fluffy',
          category: 'Dog',
          age: 5,
          price: 50.0,
          imageAssetPath: 'assets/fluffy_image.jpg'),
      Pet(
          id: '3',
          name: 'Chetak',
          category: 'Horse',
          age: 5,
          price: 599.0,
          imageAssetPath: 'assets/chetak_image.jpg'),
      Pet(
          id: '4',
          name: 'Devil',
          category: 'Dog',
          age: 5,
          price: 299.0,
          imageAssetPath: 'assets/devil_image.jpg'),
      Pet(
          id: '5',
          name: 'Goldy',
          category: 'Fish',
          age: 3,
          price: 10.0,
          imageAssetPath: 'assets/goldy_image.jpg'),
      Pet(
          id: '6',
          name: 'Jacky',
          category: 'Dog',
          age: 5,
          price: 50.0,
          imageAssetPath: 'assets/jacky_image.jpg'),
      Pet(
          id: '7',
          name: 'Kachua',
          category: 'Turtle',
          age: 3,
          price: 100.0,
          imageAssetPath: 'assets/kachua_image.jpg'),
      Pet(
          id: '8',
          name: 'Kitty',
          category: 'Cat',
          age: 5,
          price: 50.0,
          imageAssetPath: 'assets/kitty_images.jpg'),
      Pet(
          id: '9',
          name: 'Lily',
          category: 'Dog',
          age: 3,
          price: 100.0,
          imageAssetPath: 'assets/lilly_image.jpg'),
      Pet(
          id: '10',
          name: 'Mitthu',
          category: 'Bird',
          age: 5,
          price: 50.0,
          imageAssetPath: 'assets/mitthu_image.jpg'),
      Pet(
          id: '11',
          name: 'Buddy',
          category: 'Cat',
          age: 3,
          price: 100.0,
          imageAssetPath: 'assets/buddy_image.jpg'),
      Pet(
          id: '12',
          name: 'Rabby',
          category: 'Rabit',
          age: 5,
          price: 50.0,
          imageAssetPath: 'assets/rabby.jpg'),
      Pet(
          id: '13',
          name: 'Radha',
          category: 'Cow',
          age: 3,
          price: 100.0,
          imageAssetPath: 'assets/Radha_image.jpg'),
      Pet(
          id: '14',
          name: 'Sheero',
          category: 'Dog',
          age: 5,
          price: 50.0,
          imageAssetPath: 'assets/sheero_image.jpg'),
      Pet(
          id: '15',
          name: 'Shera',
          category: 'Tiger',
          age: 3,
          price: 5000.0,
          imageAssetPath: 'assets/shera_image.jpg'),
      // Pet(
      //     id: '16',
      //     name: 'Fluffy',
      //     category: 'Dog',
      //     age: 5,
      //     price: 50.0,
      //     imageAssetPath: 'assets/fluffy_image.jpg'),

      // Add more pets
    ];
    _adoptedPets = [];
    // on((event, emit) => PetsLoadedState(List.from(_pets)));
    emit(PetsLoadedState(List.from(_pets)));
    //todo 1
    // on<AdoptPetEvent>(
    //         (event, emit) => emit(AdoptedPetsLoadedState(_adoptedPets)));
  }

  @override
  Stream<PetState> mapEventToState(PetEvent event) async* {
    if (event is AdoptPetEvent) {
      // Update both _adoptedPets and _pets lists
      _adoptedPets.add(event.adoptedPet);
      // _pets.removeWhere((existingPet) => existingPet.id == event.adoptedPet.id);

      // Emit the updated state for _adoptedPets if on the history page
      if (state is AdoptedPetsLoadedState) {
        yield AdoptedPetsLoadedState(List.from(_adoptedPets));
      } else {
        // Emit the updated state for _pets if on the home page
        yield PetsLoadedState(List.from(_pets));
      }
    } else if (event is SearchPetsEvent) {
      final List<Pet> filteredPets = _pets
          .where((pet) =>
      pet.name.toLowerCase().contains(event.query.toLowerCase()) ||
          pet.category.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      // Emit the filtered pets based on the current page
      if (state is AdoptedPetsLoadedState) {
        yield AdoptedPetsLoadedState(filteredPets);
      } else {
        yield PetsLoadedState(filteredPets);
      }
    }
  }

  void adoptPet(Pet pet) {
    add(AdoptPetEvent(adoptedPet: pet));
  }
}
