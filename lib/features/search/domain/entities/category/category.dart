import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;


  const Category({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id];
}
List<Category> categories = [
    const Category(id: '1', name: 'backgrounds'),
    const Category(id: '2', name: 'fashion'),
    const Category(id: '3', name: 'nature'),
    const Category(id: '4', name: 'science'),
    const Category(id: '5', name: 'education'),
    const Category(id: '6', name: 'feelings'),
    const Category(id: '7', name: 'health'),
    const Category(id: '8', name: 'people'),
    const Category(id: '9', name: 'religion'),
    const Category(id: '10', name: 'places'),
    const Category(id: '11', name: 'animals'),
    const Category(id: '12', name: 'industry'),
    const Category(id: '13', name: 'computer'),
    const Category(id: '14', name: 'food'),
    const Category(id: '15', name: 'sports'),
    const Category(id: '16', name: 'transportation'),
    const Category(id: '17', name: 'travel'),
    const Category(id: '18', name: 'buildings'),
    const Category(id: '19', name: 'business'),
    const Category(id: '20', name: 'music'),
  ];
