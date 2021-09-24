import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/dto/account_pageDTO.dart';
import 'package:progetto_piattaforme/dto/all_productsDTO.dart';
import 'package:progetto_piattaforme/dto/checkout_pageDTO.dart';
import 'package:progetto_piattaforme/dto/search_object_page_dto.dart';
import 'package:progetto_piattaforme/pages/account_page.dart';
import 'package:progetto_piattaforme/pages/all_products.dart';
import 'package:progetto_piattaforme/pages/attrezzi_products.dart';
import 'package:progetto_piattaforme/pages/checkout_page.dart';
import 'package:progetto_piattaforme/pages/confermed_order_page.dart';
import 'package:progetto_piattaforme/pages/home_page.dart';
import 'package:progetto_piattaforme/pages/log_in_page.dart';
import 'package:progetto_piattaforme/pages/product_details.dart';
import 'package:progetto_piattaforme/pages/salute_products.dart';
import 'package:progetto_piattaforme/pages/search_object_page.dart';
import 'package:progetto_piattaforme/pages/shopping_cart.dart';
import 'package:progetto_piattaforme/pages/sviluppo_muscolare_products.dart';
import 'package:progetto_piattaforme/pages/user_login_page.dart';

import 'dto/product_details_dto.dart';
import 'dto/shopping_cart_pageDTO.dart';
import 'network/rest_client.dart';

class AppRouter {
  static const String HOME_PAGE = HomePage.routeName;
  static const String SEARCH_OBJECT_PAGE = SearchObjectPage.routeName;
  static const String ALL_PRODUCTS = AllProducts.routeName;
  static const String SVILUPPO_MUSCOLARE_PRODUCTS =
      SviluppoMuscolareProducts.routeName;
  static const String ATTREZZI_PRODUCTS = AttrezziProducts.routeName;
  static const String SALUTE_PRODUCTS = SaluteProducts.routeName;
  static const String PRODUCTS_DETAILS = ProductDetails.routeName;
  static const String SHOPPING_CART = ShoppingCart.routeName;
  static const String LOGIN_PAGE = LoginPage.routeName;
  static const String ACCOUNT_PAGE = AccountPage.routeName;
  static const String USER_LOGIN_PAGE = UserLoginPage.routeName;
  static const String CHECK_OUT_PAGE = CheckOutPage.routeName;
  static const String CONFERMED_ORDER_PAGE = ConfermedOrderPage.routeName;
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.HOME_PAGE:
        return MaterialPageRoute(
            builder: (_) => HomePage(
                productsFuture: RestClient.fetchProducts("?pageSize=4")));
      case AppRouter.ALL_PRODUCTS:
        return MaterialPageRoute(builder: (_) {
          final dto = settings.arguments as AllProductsDTO;
          return AllProducts(
            label: dto.label,
            productsFuture: RestClient.fetchProducts("/all"),
          );
        });
      case AppRouter.SVILUPPO_MUSCOLARE_PRODUCTS:
        return MaterialPageRoute(
          builder: (_) => SviluppoMuscolareProducts(),
        );
      case AppRouter.ATTREZZI_PRODUCTS:
        return MaterialPageRoute(builder: (_) => AttrezziProducts());
      case AppRouter.SALUTE_PRODUCTS:
        return MaterialPageRoute(builder: (_) => SaluteProducts());
      case AppRouter.PRODUCTS_DETAILS:
        return MaterialPageRoute(builder: (_) {
          final dto = settings.arguments as ProductDetailsDTO;
          return ProductDetails(
            product: dto.product,
          );
        });
      case SEARCH_OBJECT_PAGE:
        return MaterialPageRoute(builder: (_) {
          final dto = settings.arguments as SearchObjectPageDTO;
          return SearchObjectPage(
            label: dto.label,
            path: dto.path,
          );
        });
      case SHOPPING_CART:
        return MaterialPageRoute(builder: (_) {
          final dto = settings.arguments as ShoppingCartPageDTO;
          return ShoppingCart(
            carrelloId: dto.idCart,
            listProducts: dto.listaProdotti,
          );
        });
      case LOGIN_PAGE:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case ACCOUNT_PAGE:
        return MaterialPageRoute(builder: (_) {
          final dto = settings.arguments as AccountPageDTO;
          return AccountPage(
            user: dto.user,
            listOrders: dto.listProducts,
          );
        });
      case USER_LOGIN_PAGE:
        return MaterialPageRoute(builder: (_) => UserLoginPage());
      case CHECK_OUT_PAGE:
        return MaterialPageRoute(builder: (_) {
          final dto = settings.arguments as CheckOutPageDto;
          return CheckOutPage(
            ordine: dto.ordine,
          );
        });
      case CONFERMED_ORDER_PAGE:
        return MaterialPageRoute(builder: (_) => ConfermedOrderPage());
      default:
        throw Exception();
    }
  }
}
