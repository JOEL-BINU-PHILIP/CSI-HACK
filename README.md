# Dermi AI
An app that detects dermatological conditions from images.

## Overview
Dermi AI allows users to take photos of skin conditions, upload them to the cloud for later verification, and have them analyzed by an AI model to identify potential skin diseases. Users can also interact with a chatbot for further queries about their conditions.

## Features
- **Capture and Upload**: Take a photo of the skin condition through the app.
- **Cloud Storage**: Store the image in Firebase Storage for later verification.
- **AI Analysis**: The image is sent to an AI model hosted at Modelbit via a REST API to identify potential skin diseases.
- **Results Display**: View the AI's diagnosis on the results page.
- **Chatbot Assistance**: Ask questions to a chatbot if there are any doubts about the diagnosis.

## Installation
After cloning this repository, migrate to `dermi-ai-flutter` folder. Then, follow these steps:

1. Create a Firebase Project.
2. Enable Firebase Authentication.
3. Set up Firebase Storage.
4. Set up Firestore Rules.
5. Create Android, iOS, & Web Apps in Firebase.
6. Configure Firebase options in the `main.dart` file.
7. Run the following commands to run your app:
   ```bash
   flutter pub get
   open -a simulator # to get iOS Simulator
   flutter run
   flutter run -d chrome --web-renderer html # to see the best output
## Tech Used

**Server:**
- Firebase Auth
- Firebase Firestore
- Firebase Storage

**Client:**
- Flutter
- Provider

**AI Model:**
- Modelbit (for hosting the AI model)

**Communication:**
- REST API (for sending images to the AI model and receiving results)
- Chatbot (for user queries)

