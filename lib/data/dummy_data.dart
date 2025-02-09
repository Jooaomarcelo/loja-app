import '../models/product.dart';

final dummyProducts = [
  Product(
    id: 'p1',
    name: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    imagesUrl: [
      'https://img.irroba.com.br/fit-in/600x600/filters:format(webp):fill(fff):quality(80)/stillosb/catalog/produtos/camiseta-lisa/camiseta-stillos-brother-lisa-vermelho-frente.jpg',
      'https://img.irroba.com.br/fit-in/600x600/filters:format(webp):fill(fff):quality(80)/stillosb/catalog/produtos/camiseta-lisa/camiseta-stillos-brother-lisa-vermelho-verso.jpg',
      '',
    ],
  ),
  Product(
    id: 'p2',
    name: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    imagesUrl: [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      '',
      '',
    ],
  ),
  Product(
    id: 'p3',
    name: 'Yellow Scarf',
    description: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    imagesUrl: [
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      '',
      '',
    ],
  ),
  Product(
    id: 'p4',
    name: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    imagesUrl: [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      '',
      '',
    ],
  ),
];
