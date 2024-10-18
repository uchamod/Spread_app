/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
//
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();

exports.sendNotificationOnNewPost = functions.firestore
  .document('posts/{postId}')
  .onCreate(async (snapshot, context) => {
    const postData = snapshot.data();
    const userId = postData.userId; // ID of the user who posted the video or blog

    try {
      // Fetch the user's document to get the followers' list (String List of user IDs)
      const userDoc = await db.collection('users').doc(userId).get();
      const followers = userDoc.data().followers || []; // Array of follower user IDs

      // If the user has no followers, exit the function
      if (followers.length === 0) {
        console.log('No followers for this user.');
        return null;
      }

      // Fetch FCM tokens of all the followers
      const tokens = [];
      for (const followerId of followers) {
        const followerDoc = await db.collection('users').doc(followerId).get();
        const followerData = followerDoc.data();
        if (followerData && followerData.fcmToken) {
          tokens.push(followerData.fcmToken);
        }
      }

      // If no tokens are found, exit the function
      if (tokens.length === 0) {
        console.log('No FCM tokens found for followers.');
        return null;
      }

      // Create the notification payload
      const payload = {
        notification: {
          title: 'New Post Alert!',
          body: `${postData.userName} posted a new ${postData.type}. Check it out!`,
          sound: 'default'
        },
      };

      // Send notifications to all FCM tokens
      const response = await admin.messaging().sendToDevice(tokens, payload);
      console.log('Notifications sent successfully:', response);
    } catch (error) {
      console.error('Error sending notifications:', error);
    }

    return null;
  });
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
