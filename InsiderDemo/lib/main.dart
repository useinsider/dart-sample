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
    // MARK: Your attribute key should be all lowercased and should not include
    //any special or non Latin characters or any space, otherwise this attribute
    //will be ignored. You can use underscore _.
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
    FlutterInsiderEvent insiderExampleEvent =
        FlutterInsider.Instance.tagEvent("third_event");

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

    // MARK: If any parameter which is passed to this method is nil / null or an
    //empty string, it will return an empty and invalid Insider Product Object.
    //Note that an invalid Insider Product object will be ignored for any product related operations.
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
    // MARK: Your attribute key should be all lowercased and should not include any
    //special or non Latin characters or any space, otherwise this attribute will be ignored. You can use underscore _.
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
        await FlutterInsider.Instance.getMessageCenterData(
            startDate, endDate, 20);
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
          title: const Text('Insider Sample App'),
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
