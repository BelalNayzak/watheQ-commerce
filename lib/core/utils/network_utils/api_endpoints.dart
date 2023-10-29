// ---------- app config ----------

const String baseUrl = 'https://dummyjson.com/products';

// Note: in case of we have dev, staging and production environments
// const String devRoute = 'apidev';
// const String stagingRoute = 'apistaging';
// const String productionRoute = 'api';

// ---- auth end points ----

const String getAllItemsEndPoint = '/';
const String getAllCategoriesEndPoint = '/categories/';
const String getItemsByCategoryEndPoint = '/category/'; // ...{cat}
const String searchForProductEndPoint = '/search?q=/'; // ...{keyword}