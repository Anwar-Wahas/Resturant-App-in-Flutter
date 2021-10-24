import 'package:meta/meta.dart';



class FoodItem {

  int id;
  String title;
  String hotel;
  double price;
  String imgUrl;
  int quantity;
  String category;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.imgUrl,
    @required this.category,

    this.quantity = 1
  });





  void incrementQuantity( ) {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity( ) {
    this.quantity = this.quantity - 1;
  }
}

List<FoodItem>  getItems(){
  List<FoodItem> AllFoodItemList= [
    FoodItem(
      id: 1,
      title: "Beach BBQ Burger",
      hotel: "Las Vegas Hotel",
      price: 14.49,
      imgUrl:
      "https://hips.hearstapps.com/pop.h-cdn.co/assets/cm/15/05/480x240/54ca71fb94ad3_-_5summer_skills_burger_470_0808-de.jpg",
      category: "Burger"
    ),
    FoodItem(
      id: 2,
      title: "Kick  Burgers",
      hotel: "Dudley",
      price: 11.99,
      imgUrl:
      "https://b.zmtcdn.com/data/pictures/chains/8/18427868/1269c190ab2f272599f8f08bc152974b.png",
      category: "Burger"
    ),
    FoodItem(
      id: 3,
      title: "Supreme Pizza Burger",
      hotel: "Golf Course",
      price: 8.49,
      imgUrl: "https://www.qsrmagazine.com/sites/default/files/styles/story_page/public/FreddysBurger.jpg",
      category: "Pizza"
    ),
    FoodItem(
      id: 4,
      title: "Chilly Cheese Pizza Burger",
      hotel: "Las Vegas Hotel",
      price: 14.49,
      imgUrl: "https://image.insider.com/5613ebd59dd7cc1d008bfa6b?width=700&format=jpeg&auto=webp",
      category: "Pizza"
    ),
    FoodItem(
      id: 5,
      title: "Beach BBQ Burger",
      hotel: "Las Vegas Hotel",
      price: 14.49,
      imgUrl: "https://www.beliefnet.com/columnists/doinglifetogether/wp-content/uploads/sites/258/2013/05/burger.jpg",
      category: "Burger"
    ),
    FoodItem(
      id: 6,
      title: "Beach BBQ Burger",
      hotel: "Las Vegas Hotel",
      price: 14.49,
      imgUrl:
      "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
      category: "Burger"
    ),
  ];
  return AllFoodItemList;
}