import 'package:get/get.dart';
import 'package:ssgc/app/modules/aboutus/views/about_us.dart';
import 'package:ssgc/app/modules/address/bindings/address_binding.dart';
import 'package:ssgc/app/modules/address/views/update_address_view.dart';
import 'package:ssgc/app/modules/all_news/bindings/all_news_bindings.dart';
import 'package:ssgc/app/modules/all_news/views/all_news_view.dart';
import 'package:ssgc/app/modules/checkout/views/checkout_view.dart';
import 'package:ssgc/app/modules/courses/bindings/courses_bindings.dart';
import 'package:ssgc/app/modules/courses/views/courses_view.dart';
import 'package:ssgc/app/modules/video/views/video_view.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/address/views/add_address_view.dart';
import '../modules/all_products/bindings/all_products_binding.dart';
import '../modules/all_products/views/all_products_view.dart';
import '../modules/bottom_navigation_bar/bindings/bottom_navigation_bar_binding.dart';
import '../modules/bottom_navigation_bar/views/bottom_navigation_bar_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/catalog_product/bindings/catalog_product_binding.dart';
import '../modules/catalog_product/views/catalog_product_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/customer_support/bindings/customer_support_binding.dart';
import '../modules/customer_support/views/customer_support_view.dart';
import '../modules/detail_page/bindings/detail_page_binding.dart';
import '../modules/detail_page/views/detail_page_view.dart';
import '../modules/e_book_details/bindings/e_book_details_binding.dart';
import '../modules/e_book_details/views/e_book_details_view.dart';
import '../modules/earn_accounts/bindings/earn_accounts_binding.dart';
import '../modules/earn_accounts/views/earn_accounts_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/membership/bindings/membership_binding.dart';
import '../modules/membership/views/membership_view.dart';
import '../modules/my_orders/bindings/my_orders_binding.dart';
import '../modules/my_orders/views/my_orders_view.dart';
import '../modules/news_details/bindings/news_details_bindings.dart';
import '../modules/news_details/views/news_details_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/product_detail/bindings/product_detail_binding.dart';
import '../modules/product_detail/views/product_detail_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/purchase/bindings/purchase_binding.dart';
import '../modules/purchase/views/purchase_view.dart';
import '../modules/refer_and_earn/bindings/refer_and_earn_binding.dart';
import '../modules/refer_and_earn/views/refer_and_earn_view.dart';
import '../modules/reviews_all/bindings/reviews_all_binding.dart';
import '../modules/reviews_all/views/reviews_all_view.dart';
import '../modules/search_screen/bindings/search_screen_binding.dart';
import '../modules/search_screen/views/search_screen_view.dart';
import '../modules/suggestion_products/bindings/suggestion_products_binding.dart';
import '../modules/suggestion_products/views/suggestion_products_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION_BAR,
      page: () => BottomNavigationBarView(),
      binding: BottomNavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PAGE,
      page: () => DetailPageView(),
      binding: DetailPageBinding(),
    ),
    GetPage(
      name: _Paths.CATALOG_PRODUCT,
      page: () => CatalogProductView(
        text: '',
      ),
      binding: CatalogProductBinding(),
    ),
    GetPage(
      name: _Paths.ALL_PRODUCTS,
      page: () => AllProductsView(),
      binding: AllProductsBinding(),
    ),

    GetPage(
      name: _Paths.ALL_NEWS,
      page: () => AllNewsView(),
      binding: AllNewsBinding(),
    ),

    GetPage(
      name: _Paths.NEWS_DETAILS,
      page: () => NewsDetailsView(),
      binding: NewsDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),

    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => AddAddressView(),
      binding: AddressBinding(),
    ),

    // GetPage(
    //   name: _Paths.UPDATE_ADDRESS,
    //   page: () => UpdateAddress(),
    //   binding: AddressBinding(),
    // ),
    GetPage(
      name: _Paths.PURCHASE,
      page: () => const PurchaseView(),
      binding: PurchaseBinding(),
    ),
    GetPage(
      name: _Paths.MEMBERSHIP,
      page: () => const MembershipView(),
      binding: MembershipBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDERS,
      page: () => const MyOrdersView(),
      binding: MyOrdersBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    // GetPage(
    //   name: _Paths.PRODUCT_DETAIL,
    //   page: () => const ProductDetailView(id: 30,),
    //   binding: ProductDetailBinding(),
    // ),
    GetPage(
      name: _Paths.E_BOOK_DETAILS,
      page: () => const EBookDetailsView(),
      binding: EBookDetailsBinding(),
      children: [
        GetPage(
          name: _Paths.E_BOOK_DETAILS,
          page: () => const EBookDetailsView(),
          binding: EBookDetailsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.REVIEWS_ALL,
      page: () => const ReviewsAllView(),
      binding: ReviewsAllBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_SCREEN,
      page: () => SearchScreenView(),
      binding: SearchScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.REFER_AND_EARN,
      page: () => const ReferAndEarnView(),
      binding: ReferAndEarnBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_SUPPORT,
      page: () => CustomerSupportView(),
      binding: CustomerSupportBinding(),
    ),
    GetPage(
      name: _Paths.EARN_ACCOUNTS,
      page: () => EarnAccountsView(),
      binding: EarnAccountsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SUGGESTION_PRODUCTS,
      page: () => SuggestionProductsView(
        text: '',
      ),
      binding: SuggestionProductsBinding(),
    ),

    GetPage(
      name: _Paths.ABOUT_US,
      page: ()=> AboutUs(),
    ),

    GetPage(
      name: _Paths.PET,
      page: ()=> CoursesView(),
      binding: CoursesBinding(),
    ),

    GetPage(
      name: _Paths.VIDEO,
      page: ()=> VideoView(),
    ),
  ];
}
