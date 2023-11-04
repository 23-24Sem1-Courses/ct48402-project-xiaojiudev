import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initializeFirestore() async {
    // Replace 'ct293' with your desired quiz ID
    print('ok');

    try {
      print('Creating sample data...');

      // Sample data for a quiz
      Map<String, Object> sampleData = {
        "id": "ct293",
        "title": "Network and data communications",
        "image_url": "",
        "Description":
            "Fundamental Multiple Choice Questions (MCQ) from CCNA to practice basic quiz answers",
        "time_seconds": 900,
        "questions": [
          {
            "id": "ct293q001",
            "question":
                "Your company wants to purchase some network hardware to which they can plug the 30 PCs in your department. Which type of network device is appropriate?",
            "answers": [
              {"identifier": "A", "Answer": "A router"},
              {"identifier": "B", "Answer": "A firewall"},
              {"identifier": "C", "Answer": "A switch"},
              {"identifier": "D", "Answer": "A server"},
            ],
            "correct_answer": "C",
          },
          {
            "id": "ct293q002",
            "question":
                "You received a video file from your friend's Apple iPhone using AirDrop. What was his iPhone functioning as in that transaction?",
            "answers": [
              {"identifier": "A", "Answer": "A server"},
              {"identifier": "B", "Answer": "A client"},
              {"identifier": "C", "Answer": "A local area network"},
              {"identifier": "D", "Answer": "A firewall"},
            ],
            "correct_answer": "A",
          },
          {
            "id": "ct293q003",
            "question":
                "Which layers of the OSI model are most relevant to the role of a network engineer?",
            "answers": [
              {
                "identifier": "A",
                "Answer": "Transport - Network - Data Link - Physical"
              },
              {"identifier": "B", "Answer": "Transport - Network - Data Link"},
              {"identifier": "C", "Answer": "Network only"},
              {
                "identifier": "D",
                "Answer": "Application - Presentation - Session"
              },
            ],
            "correct_answer": "A",
          },
          {
            "id": "ct293q004",
            "question":
                "Which layer of the OSI model provides host-to-host communications",
            "answers": [
              {"identifier": "A", "Answer": "Application"},
              {"identifier": "B", "Answer": "Network"},
              {"identifier": "C", "Answer": "Data Link"},
              {"identifier": "D", "Answer": "Transport"},
            ],
            "correct_answer": "D",
          },
          {
            "id": "ct293q005",
            "question":
                "Which field of an Ethernet frame provider receiver clock synchronization?",
            "answers": [
              {"identifier": "A", "Answer": "Preamble"},
              {"identifier": "B", "Answer": "SFD"},
              {"identifier": "C", "Answer": "Type"},
              {"identifier": "D", "Answer": "FCS"},
            ],
            "correct_answer": "A",
          },
          {
            "id": "ct293q006",
            "question":
                "What type of transmission is involved in communication between a computer and a keyboard?",
            "answers": [
              {"identifier": "A", "Answer": "Half-duplex"},
              {"identifier": "B", "Answer": "Full-duplex"},
              {"identifier": "C", "Answer": "Simplex"},
              {"identifier": "D", "Answer": "Automatic"},
            ],
            "correct_answer": "C",
          },
        ],
      };

      // Create a reference to the Firestore collection (replace 'quizzes' with your collection name)
      final collectionReference = _firestore.collection('quizzes');

      // Replace 'ct293' with the desired document ID
      final documentReference = collectionReference.doc(sampleData['id'] as String);

      // Create the document with the sample data
      await documentReference.set(sampleData);

      print('Collection and document created successfully.');
    } catch (error) {
      print('Error creating collection and document: $error');
    }
  }
}
