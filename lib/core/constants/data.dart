import 'package:watheq_ecommerce/core/constants/assets_refs.dart';

const appName = 'WatheQ';
const appVersion = '0.1.0';

// Note: this could come from a remote database if needed
const List<Map<String, dynamic>> onboardingSlidesData = [
  {
    'image': gif_board_3,
    'title': 'All in one!',
    'subtitle': 'Find all your needs in one place with awesome quality.',
  },
  {
    'image': gif_board_2,
    'title': 'Easy shopping!',
    'subtitle': 'Explore all market products with just few clicks on your phone.',
  },
  {
    'image': gif_board_4,
    'title': 'Exclusive offers!',
    'subtitle': 'Want to save? We have hot offers on variant products that you can win.',
  },
];

// Note: this should be dynamic and come from remote database as the business may add another
// category in the future. They are fixed in the api I use and to make things quick, i just use them here
const List<String> cats = [
  "All",
  "smartphones",
  "laptops",
  "fragrances",
  "skincare",
  "groceries",
  "home-decoration",
  "furniture",
  "tops",
  "womens-dresses",
  "womens-shoes",
  "mens-shirts",
  "mens-shoes",
  "mens-watches",
  "womens-watches",
  "womens-bags",
  "womens-jewellery",
  "sunglasses",
  "automotive",
  "motorcycle",
  "lighting",
];

// ------------------ firebase remote config vars ------------------------- //

bool? showAds;

// ------------------ firebase fcm token ------------------------- //

String fcmtoken = '';