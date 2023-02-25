import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/service/subscription_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// import 'package:enebla_user_app/services/subscription_service.dart';
import 'package:enebla_user_app/models/subscription_model.dart';

// Define a mock for the FirebaseFirestore class
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  // Create a mock instance of FirebaseFirestore
  final firestore = MockFirebaseFirestore();

  // Create an instance of SubscriptionService using the mock FirebaseFirestore
  final subscriptionService = SubscriptionService();

  group('SubscriptionService', () {
    test('addSubscription adds a subscription to Firestore', () async {
      // Create a SubscriptionModel to use as the input parameter for addSubscription
      final subscription = SubscriptionModel(
        subscriptionAmount: '10.00',
        subscriptionstatus: 'active',
        subscribedUser: 'user123',
        subscribtionOwner: 'owner456',
      );

      // Define the expected behavior of the mock FirebaseFirestore
      when(firestore
              .collection('subscriptionuser')
              .doc('owner456')
              .set(subscription.toJson(), SetOptions(merge: true)))
          .thenAnswer((_) => Future.value());

      // Call the addSubscription method and verify the result
      final result = await subscriptionService.addSubscription(
        subscriptionAmount: subscription.subscriptionAmount,
        subscriptionstatus: subscription.subscriptionstatus,
        subscribedUser: subscription.subscribedUser,
        subscribtionOwner: subscription.subscribtionOwner,
      );
      expect(result, 'subscription added successfully');

      // Verify that the mock FirebaseFirestore was called with the correct arguments
      verify(firestore
          .collection('subscriptionuser')
          .doc('owner456')
          .set(subscription.toJson(), SetOptions(merge: true)));
    });
  });
}
