import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_food_cart_app/bloc/cartListBloc.dart';
import 'package:the_food_cart_app/model/foodItem.dart';

import 'bloc/cartListBloc.dart';
import 'cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc ((i) => CartListBloc())
      ],
      dependencies: [],
      child: MaterialApp(
        title: 'Food Cart',
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends StatefulWidget {
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

 List<FoodItem>items= getItems();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              FirstHalf(),
              SizedBox(height: 45,),
              for (var foodItem in items)
              if((foodItem.title.contains(searchBoxText)||searchBoxText=="")&&foodItem.category==categoryName)
                ItemContainer(foodItem: foodItem)
              else if(categoryName=="All")  ItemContainer(foodItem: foodItem)
              ,
            ],
          ),
        ),
      ),
    );
  }
}



class ItemContainer extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

final FoodItem foodItem;
  ItemContainer({this.foodItem});

  addToCart(FoodItem foodItem){
    bloc.addToList(foodItem);

  }
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return  GestureDetector(
      onTap: () {
        addToCart(foodItem);

        final snackBar = SnackBar(
          content: Text("${foodItem.title} added to the cart"),
          duration: Duration(milliseconds: 550),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: ItemInfoCard(
        hotel: foodItem.hotel, 
        itemName: foodItem.title, 
        itemPrice: foodItem.price, 
        imageUrl: foodItem.imgUrl,
        leftAligned: (foodItem.id % 2 == 0) ? true : false,
      ),
    );
    
  }
}

class ItemInfoCard extends StatelessWidget {

  final String hotel;
  final String itemName;
  final double itemPrice;
  final String imageUrl;
  final bool leftAligned;

  ItemInfoCard({
    @required this.hotel,
    @required this.itemName,
    @required this.itemPrice,
    @required this.imageUrl,
    @required this.leftAligned
  });

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 1 : containerPadding,
            right: leftAligned ? containerPadding : 1,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.only(
                  left: leftAligned ? 20 : 0,
                  right: leftAligned ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        children: <Widget>[ Expanded(
                          child: Text(
                            itemName,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18
                            ),
                          ),
                        ),
                         Text(
                           "\$$itemPrice",
                           style: TextStyle(
                             fontWeight: FontWeight.w700,
                             fontSize: 18,
                           ),
                         ),
                        ]
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(


                          children: [
                            TextSpan(
                                text: "by ",
                                style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15)),
                            TextSpan(
                              text: hotel,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,color: Colors.grey
                              )
                            )
                          ]
                        ),
                      ),
                    ),
                    SizedBox(height: containerPadding,),

                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class FirstHalf extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.fromLTRB(35, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          SizedBox(height: 30,),
          title(),
          SizedBox(height: 30,),
          searchBar(),
          SizedBox(height: 30,),
          categories(),

        ],
      ),
    );
  }
}
int categoryId=0;
String categoryName="All";
Widget categories(){

 setCategoryId(int i){
   categoryId=i;
 }
 setCategoryName(String n){
   categoryName=n;
 }
  return

       Container(
         height: 185,
        
             child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[

                InkWell(
                  child: CategoryListItem(
                    categoryIcon:
                      Image.network('https://hips.hearstapps.com/pop.h-cdn.co/assets/cm/15/05/480x240/54ca71fb94ad3_-_5summer_skills_burger_470_0808-de.jpg'
                          ,fit: BoxFit.fill),
                    categoryName: "All",
                    availability: 12,
                    selected:categoryId==0 ? true : false,
                  ),
                  onTap: (){
                    setCategoryId(0);
                    setCategoryName("All");
                    runApp(MyApp());
                  },
                ),
                InkWell(
                  child: CategoryListItem(
                    categoryIcon: Image.network('https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg'
                        ,fit: BoxFit.fill),
                    categoryName: "Burgers",
                    availability: 12,
                    selected: categoryId==1 ? true : false,
                  ),
                  onTap: (){
                    setCategoryId(1);
                    setCategoryName("Burger");
                    runApp(MyApp());
                  },
                ),
                InkWell(
                  child: CategoryListItem(
                    categoryIcon: Image.network('https://www.qsrmagazine.com/sites/default/files/styles/story_page/public/FreddysBurger.jpg'
                        ,fit: BoxFit.fill),
                    categoryName: "Pizza",
                    availability: 12,
                    selected: categoryId==2 ? true : false,
                  ),
                  onTap: (){
                    setCategoryId(2);
                    setCategoryName("Pizza");
                    runApp(MyApp());
                  },
                ),
              ],
          ),
        
        


       );
}
String searchBoxText="";
Widget searchBar(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Icon(
        Icons.search,
        color: Colors.black45,
      ),
      SizedBox(width: 20,),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search....",
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            helperStyle: TextStyle(
              color: Colors.black87,
            )
          ),onChanged: (value){
            searchBoxText=value;
            runApp(MyApp());
            //Home();
        },
        ),
      )
    ],

  );
}

Widget title(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        "Food",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 30
        ),
      ),
      Text(
        "Cart",
        style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 30
        ),
      )
    ],
  );
}

class CustomAppBar extends StatelessWidget {

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          StreamBuilder(
            stream: bloc.ListStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;
              return buildGestureDetector(length, context, foodItems);
            },
          ),

        ],
      ),
    );
  }
}

GestureDetector buildGestureDetector(int length, BuildContext context ,List<FoodItem> foodItems) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Cart())
      );
    },
    child:  Container(
      margin: EdgeInsets.only(right: 30),
      child: Text(length.toString()),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.yellow[800], borderRadius: BorderRadius.circular(50)),
    ),
  );
}


class CategoryListItem extends StatelessWidget {

  final Image categoryIcon;
  final String categoryName;
  final int availability;
  final bool selected;

  CategoryListItem({
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.availability,
    @required this.selected
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.only(left: 20,right: 20,top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: selected ? Color(0xfffeb324) : Colors.white,
          border: Border.all(
            color: selected ? Colors.transparent : Colors.grey[200],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[100],
              blurRadius: 15,
              offset: Offset(25,0),
              spreadRadius: 5
            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
          width: 60,
          height: 60,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected ? Colors.transparent : Colors.grey,
                width: 1.5,
              )
            ),
            
              child: 
               categoryIcon,
            
            
             
          ),
          
          SizedBox(height: 10,),
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: 1.5,
            height: 15,
            color: Colors.black26,
          ),
          Text(
            availability.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
  //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
}