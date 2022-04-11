import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_insider/src/user.dart';
import 'package:flutter_insider/src/product.dart';
import 'package:flutter_insider/enum/InsiderGender.dart';
import 'package:flutter_insider/enum/InsiderCallbackAction.dart';
import 'package:flutter_insider/enum/ContentOptimizerDataType.dart';
import 'package:flutter_insider/src/event.dart';
import 'package:flutter_insider/src/identifiers.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

String _callbackData = 'No Callback Data';

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initInsider();
  }

  Future initInsider() async {
    if (!mounted) return;

    // Call in async method.
    await FlutterInsider.Instance.init(
        "your_partner_name", "group.com.useinsider.InsiderDemo",
        (int type, dynamic data) {
      switch (type) {
        case InsiderCallbackAction.NOTIFICATION_OPEN:
          print("[INSIDER][NOTIFICATION_OPEN]: " + data.toString());
          setState(() {
            _callbackData = data.toString();
          });
          break;
        case InsiderCallbackAction.TEMP_STORE_PURCHASE:
          print("[INSIDER][TEMP_STORE_PURCHASE]: " + data.toString());
          setState(() {
            _callbackData = data.toString();
          });
          break;
        case InsiderCallbackAction.TEMP_STORE_ADDED_TO_CART:
          print("[INSIDER][TEMP_STORE_ADDED_TO_CART]: " + data.toString());
          setState(() {
            _callbackData = data.toString();
          });
          break;
        case InsiderCallbackAction.TEMP_STORE_CUSTOM_ACTION:
          print("[INSIDER][TEMP_STORE_CUSTOM_ACTION]: " + data.toString());
          setState(() {
            _callbackData = data.toString();
          });
          break;
        default:
          print("[INSIDER][InsiderCallbackAction]: Unregistered Action!");
          break;
      }
    });

    // This is an utility method, if you want to handle the push permission in iOS own your own you can omit the following method.
    FlutterInsider.Instance.registerWithQuietPermission(false);
    FlutterInsider.Instance.startTrackingGeofence();
    FlutterInsider.Instance.enableCarrierCollection(true);
    FlutterInsider.Instance.enableIDFACollection(true);
    FlutterInsider.Instance.enableIpCollection(true);
  }

  Future trigger() async {
    // --- USER --- //

    // You can crete Insider User and add attributes later on it.

    FlutterInsiderUser currentUser = FlutterInsider.Instance.getCurrentUser()!;

    // Setting User Attributes
    currentUser.setName("Insider");
    currentUser.setSurname("Demo");
    currentUser.setAge(23);
    currentUser.setGender(InsiderGender.OTHER);
    currentUser.setBirthday(new DateTime.now());
    currentUser.setEmailOptin(true);
    currentUser.setSMSOptin(false);
    currentUser.setPushOptin(true);
    currentUser.setLocationOptin(true);
    currentUser.setFacebookID("Facebook-ID");
    currentUser.setTwitterID("Twittter-ID");
    currentUser.setLanguage("TR");
    currentUser.setLocale("tr_TR");

    // Setting User Identifiers.
    FlutterInsiderIdentifiers identifiers = new FlutterInsiderIdentifiers();
    identifiers.addEmail("mobile@useinsider.com");
    identifiers.addPhoneNumber("+901234567");
    identifiers.addUserID("CRM-ID");

    // Login and Logout
    await currentUser.logout();
    await currentUser.login(identifiers);

    // Setting custom attributes.
    // MARK: Your attribute key should be all lowercased and should not include any special or non Latin characters or any space, otherwise this attribute will be ignored. You can use underscore _.
    currentUser.setCustomAttributeWithString(
        "string_attribute", "This is Insider.");
    currentUser.setCustomAttributeWithInt("int_attribute", 10);
    currentUser.setCustomAttributeWithDouble("double_attribute", 20.5);
    currentUser.setCustomAttributeWithBoolean("bool_attribute", true);
    currentUser.setCustomAttributeWithDate(
        "date_attribute", new DateTime.now());

    // MARK: You can only call the method with array of string otherwise this event will be ignored.

    final arr = <String>['value1', 'value2', 'value3'];

    FlutterInsider.Instance.getCurrentUser()!
        .setCustomAttributeWithArray("arr_attribute", arr);

    // --- EVENT --- //

    // You can create an event without parameters and call the build method
    FlutterInsider.Instance.tagEvent("first_event").build();

    // You can create an event then add parameters and call the build method
    FlutterInsider.Instance.tagEvent("second_event")
        .addParameterWithInt("int_parameter", 10)
        .build();

    // You can create an object and add the parameters later
    FlutterInsiderEvent insiderExampleEvent = FlutterInsider.Instance.tagEvent("third_event");

    insiderExampleEvent
        .addParameterWithString("string_parameter", "This is Insider.")
        .addParameterWithInt("int_parameter", 10)
        .addParameterWithDouble("double_parameter", 10.5)
        .addParameterWithBoolean("bool_parameter", true)
        .addParameterWithDate("date_parameter", new DateTime.now());

    // MARK: You can only call the method with array of string otherwise this event will be ignored.
    insiderExampleEvent.addParameterWithArray("array_parameter", arr);

    // Do not forget to call build method once you are done with parameters.
    // Otherwise your event will be ignored.
    insiderExampleEvent.build();

    // --- PRODUCT --- //

    // MARK: If any parameter which is passed to this method is nil / null or an empty string, it will return an empty and invalid Insider Product Object. Note that an invalid Insider Product object will be ignored for any product related operations.
    // You can crete Insider Product and add attributes later on it.
    final taxonomy = <String>['tax1', 'tax2', 'tax3'];

    FlutterInsiderProduct insiderExampleProduct =
        FlutterInsider.Instance.createNewProduct("productID", "productName",
            taxonomy, "imageURL", 1000.5, "currency");

    // Setting Product Attributes in chainable way.
    insiderExampleProduct
        .setColor("color")
        .setVoucherName("voucherName")
        .setVoucherDiscount(10.5)
        .setPromotionName("promotionName")
        .setPromotionDiscount(10.5)
        .setSize("size")
        .setSalePrice(10.5)
        .setShippingCost(10.5)
        .setQuantity(10)
        .setStock(10);

    // Setting custom attributes.
    // MARK: Your attribute key should be all lowercased and should not include any special or non Latin characters or any space, otherwise this attribute will be ignored. You can use underscore _.
    insiderExampleProduct
        .setCustomAttributeWithString("string_parameter", "This is Insider.")
        .setCustomAttributeWithInt("int_parameter", 10)
        .setCustomAttributeWithDouble("double_parameter", 10.5)
        .setCustomAttributeWithBoolean("bool_parameter", true)
        .setCustomAttributeWithDate("date_parameter", new DateTime.now());

    // MARK: You can only call the method with array of string otherwise this event will be ignored.
    insiderExampleProduct.setCustomAttributeWithArray("array_parameter", arr);

    // --- REVENUE TRACKING --- //

    FlutterInsider.Instance.itemPurchased(
        "uniqueSaleID", insiderExampleProduct);

    // --- CART REMINDER --- //

    // Adding item to cart.
    FlutterInsider.Instance.itemAddedToCart(insiderExampleProduct);

    // Removing item from the cart.
    FlutterInsider.Instance.itemRemovedFromCart("productID");

    // Removing all the items from the cart.
    // This method will automatically triggered when you call Revenue Tracking.
    FlutterInsider.Instance.cartCleared();

    // --- RECOMMENDATION ENGINE --- //

    // ID comes from your smart recommendation campaign.
    // Please follow the locale code structure. For instance tr_TR.
    Map? recommendationWithID =
        await FlutterInsider.Instance.getSmartRecommendation(1, "tr_TR", "TRY");

    print("[INSIDER][getSmartRecommendation]: " +
        recommendationWithID.toString());

    Map? recommendationWithProduct =
        await FlutterInsider.Instance.getSmartRecommendationWithProduct(
            insiderExampleProduct, 1, "tr_TR");

    print("[INSIDER][getSmartRecommendationWithProduct]: " +
        recommendationWithProduct.toString());

    // --- SOCIAL PROOF --- //

    FlutterInsider.Instance.visitProductDetailPage(insiderExampleProduct);

    // --- PAGE VISITING --- //

    FlutterInsider.Instance.visitHomePage();
    FlutterInsider.Instance.visitListingPage(taxonomy);

    final insiderExampleProducts = <FlutterInsiderProduct>[
      insiderExampleProduct,
      insiderExampleProduct
    ];

    FlutterInsider.Instance.visitCartPage(insiderExampleProducts);

    // --- GDPR --- //

    // MARK: Please note that by default our SDK is collecting the data so you don't have to call this function if you are not asking users consents.

    // MARK: If you set false, the user will not share any data or receive any push until you set back true.
    FlutterInsider.Instance.setGDPRConsent(true);

    // --- MESSAGE CENTER --- //
    DateTime startDate = new DateTime(2020);
    DateTime endDate = new DateTime(2022, DateTime.december);
    print("[INSIDER][startDate]: " + startDate.toString());
    print("[INSIDER][endDate]: " + endDate.toString());
    List? messageCenterData =
        await FlutterInsider.Instance.getMessageCenterData(startDate, endDate, 20);
    print("[INSIDER][getMessageCenterData]: " + messageCenterData.toString());

    // --- CONTENT OPTIMIZER --- //

    // String
    var contentOptimizerString =
        await FlutterInsider.Instance.getContentStringWithName(
            "string_variable_name",
            "defaultValue",
            ContentOptimizerDataType.ELEMENT);
    print("[INSIDER][getContentStringWithName]: " +
        contentOptimizerString.toString());

    // Boolean
    var contentOptimizerBool =
        await FlutterInsider.Instance.getContentBoolWithName(
            "bool_variable_name", true, ContentOptimizerDataType.ELEMENT);
    print("[INSIDER][getContentBoolWithName]: " +
        contentOptimizerBool.toString());

    // Integer
    var contentOptimizerInt =
        await FlutterInsider.Instance.getContentIntWithName(
            "int_variable_name", 10, ContentOptimizerDataType.ELEMENT);
    print(
        "[INSIDER][getContentIntWithName]: " + contentOptimizerInt.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: TextButton(
                onPressed: () {
                  trigger();
                },
                child: Text(_callbackData))),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//         // This makes the visual density adapt to the platform that you run
//         // the app on. For desktop platforms, the controls will be smaller and
//         // closer together (more dense) than on mobile platforms.
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
