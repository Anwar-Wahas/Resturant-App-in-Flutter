import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:the_food_cart_app/bloc/cartListBloc.dart';
import 'package:the_food_cart_app/model/foodItem.dart';

class Cart extends StatelessWidget {

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    List<FoodItem> foodItems;

    // TODO: implement build
    return StreamBuilder(
      stream: bloc.ListStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: Container(
               child: CartBody(foodItems),
              ),
            ),
            bottomNavigationBar: BottomBar(foodItems),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class BottomBar extends StatelessWidget{
  final List<FoodItem> foodItems;

  BottomBar(this.foodItems);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
           totalAmount(foodItems) ,
          Divider(
            height: 1,
            color: Colors.grey[700],
          ),
          persons(),
          nextButtonBar(),
        ],
      ),
    );
  }

  Container nextButtonBar() {
    return Container(
      margin: EdgeInsets.only(right: 25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Color(0xfffeb324),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "15-25 min",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800
            ),
          ),
          Text(
            "Next",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900
            ),
          )
        ],
      ),
    );
  }

  Container persons() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Persons",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700
            ),
          ),
          CustomPersonWidget()
        ],
      ),
    );
  }

  Container totalAmount(List<FoodItem> foodItem) {
   return Container (
     margin: EdgeInsets.only(right: 10),
     padding: EdgeInsets.all(25),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
         Text(
           "Total",
           style: TextStyle(
             fontSize: 25,
             fontWeight: FontWeight.w300
           ),
         ),
         Text(
           "\$${returnTotalAmount(foodItem)}",
           style: TextStyle(
             fontWeight: FontWeight.w700,
             fontSize: 28
           ),

         )
       ],
     ),
   );
  }

  String returnTotalAmount(List<FoodItem> foodItem){
    double totalAmount = 0;
    for (int i =0; i < foodItem.length; i ++){
      totalAmount = totalAmount + foodItem[i].price * foodItem[i].quantity;
    }
    return totalAmount.toStringAsFixed(2);
  }
}


class CustomPersonWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomPersonWidgetState();
  }
}

class _CustomPersonWidgetState extends State<CustomPersonWidget> {

  int noOfPersons = 1;
  double buttonWidth = 30;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300], width: 2),
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: buttonWidth,
            height: buttonWidth,
            child: FlatButton(
              child: Text(
                "-",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              onPressed: (){
                setState(() {
                  noOfPersons--;
                });
              },
            ),
          ),
          Text(
            noOfPersons.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20
            ),
          ),
          SizedBox(
            width: buttonWidth,
            height: buttonWidth,
            child: FlatButton(
              child: Text(
                "+",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              onPressed: (){
                setState(() {
                  noOfPersons++;
                });

              },
            ),
          ),
        ],
      ),

    );
  }
}


class CartBody extends StatelessWidget {

  final List<FoodItem> foodItems;

  CartBody(this.foodItems);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(35, 40, 25, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          title(),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemsList() : noItemsContainer(),
          )
        ],
      ),
    );
  }

  Container noItemsContainer() {
    return Container(
      child: Center(
        child: Text(
          "No more items in the cart",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[500],
            fontSize: 20
          ),
        ),
      ),
    );
  }

  ListView foodItemsList(){
    return ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (builder, index) {
          return CartListItem(foodItem: foodItems[index]);
        }
    );
  }

  Widget title () {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "My",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                ),
              ),
              Text(
                "Order",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 35,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}

class CartListItem extends StatelessWidget {

  final FoodItem foodItem;

  CartListItem({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(foodItem: foodItem),
    );
  }
}

class ItemContent extends StatelessWidget {

  final FoodItem foodItem;

  ItemContent({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              foodItem.imgUrl,
              fit: BoxFit.fitHeight,
              height: 55,
              width: 80,
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
               children: [
                 TextSpan(text: foodItem.quantity.toString()),
                 TextSpan(text: " X "),
                 TextSpan(text: foodItem.title)
               ]
            ),
          ),
          Text(
            "\$${foodItem.quantity * foodItem.price}",
            style: TextStyle(
              color: Colors.grey[300],
              fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
    );
  }
}


class CustomAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Icon(
              CupertinoIcons.back,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
                CupertinoIcons.delete,
                size: 35,
            ),
          ),
          onTap: () {

          },
        )
      ],
    );
  }

}