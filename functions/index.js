const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

exports.cellCallStarted = functions.firestore
    .document("/feed/{userId}/feeds/{id}")
    .onCreate((snap, context) => {
      const document = snap.data();
      const userId = context.params.userId;

      db.collection("users").doc(userId).get().then((documents) => {
        if (documents.exists) {
          const tokenDocument = documents.data().token;
          let body, title;
          switch (document.type) {
                  case "PrayerComment":
                    body = `${document.username} commented on your contemplation: ${
                      document.commentData
                    }`;
                    title = "New Community Activity";
                    break;
                  case "PrayerLike":
                      body = `${document.username} liked your contemplation`;
                      title = "New Community Activity";
                      break;
                  case "Prayer":
                      body = `${document.username} posted a contemplation: ${
                        document.commentData
                      }`;
                      title = "New Community Activity";
                      break;
                  case "Event":
                      body = `${document.username} posted an Event: ${
                        document.commentData
                      }`;
                      title = "New Event Added";
                      break;
                  case "Livestream":
                    body = `${document.commentData}`;
                    title = "New Livestream Started";
                    break;

                  default:
                    break;
                }

          const payload = {

            notification: {
              title: title,
              body: body,
            },
            data: {
              "title": title,
              "body": body,
              "type": `${document.type}`,
              "postId": `${document.postId}`,
              "ownerId": `${document.ownerId}`,
              "category": `${document.category}`,

            },
          };
          return admin.messaging()
              .sendToDevice(tokenDocument, payload)
              .then((response) => {
                console.log("Message Sent Successfully "+ tokenDocument);
                return null;
              });
        }
      return null;
      })
      .catch(() => null);
    });