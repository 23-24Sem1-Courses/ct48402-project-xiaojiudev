import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ct484_final_project/utils/app_logger.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initializeFirestore() async {
    try {
      final collectionReference = _firestore.collection('quizzes');

      final collectionSnapshot = await collectionReference.get();

      if (collectionSnapshot.docs.isEmpty) {
        AppLogger.info('Creating sample data...');

        Map<String, Object> sampleData = {
          "id": "ct293",
          "title": "Network and data communications",
          "image_url":
              "https://res.cloudinary.com/de8xbko8y/image/upload/v1699103298/flutter/network_data_management_puiehb.png",
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
                {
                  "identifier": "B",
                  "Answer": "Transport - Network - Data Link"
                },
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

        Map<String, Object> sampleData1 = {
          "id": "ct112",
          "title": "Computer network",
          "image_url":
              "https://res.cloudinary.com/de8xbko8y/image/upload/v1699103297/flutter/computer_network_gf5vry.png",
          "Description":
              "Practice essential computer network concepts with basic MCQs.",
          "time_seconds": 900,
          "questions": [
            {
              "id": "ct112q001",
              "question":
                  "How many layers are there in the ISO OSI reference model?",
              "answers": [
                {"identifier": "A", "Answer": "7"},
                {"identifier": "B", "Answer": "6"},
                {"identifier": "C", "Answer": "5"},
                {"identifier": "D", "Answer": "4"}
              ],
              "correct_answer": "A"
            },
            {
              "id": "ct112q002",
              "question":
                  "Which type of network shares the communication channel among all the machines?",
              "answers": [
                {"identifier": "A", "Answer": "Anycast network"},
                {"identifier": "B", "Answer": "Multicast network"},
                {"identifier": "C", "Answer": "Unicast network"},
                {"identifier": "D", "Answer": "Broadcast network"}
              ],
              "correct_answer": "D"
            },
            {
              "id": "ct112q003",
              "question": "Which topology requires a multipoint connection?",
              "answers": [
                {"identifier": "A", "Answer": "Ring"},
                {"identifier": "B", "Answer": "Bus"},
                {"identifier": "C", "Answer": "Star"},
                {"identifier": "D", "Answer": "Mesh"}
              ],
              "correct_answer": "B"
            },
            {
              "id": "ct112q004",
              "question":
                  "If a link transmits 4000 frames per second, and each slot has 8 bits, what is the transmission rate of the circuit using Time Division Multiplexing (TDM)?",
              "answers": [
                {"identifier": "A", "Answer": "500kbps"},
                {"identifier": "B", "Answer": "32kbps"},
                {"identifier": "C", "Answer": "32bps"},
                {"identifier": "D", "Answer": "500bps"}
              ],
              "correct_answer": "B"
            },
            {
              "id": "ct112q005",
              "question":
                  "Which of the following allows you to connect and login to a remote computer?",
              "answers": [
                {"identifier": "A", "Answer": "SMTP"},
                {"identifier": "B", "Answer": "HTTP"},
                {"identifier": "C", "Answer": "FTP"},
                {"identifier": "D", "Answer": "Telnet"}
              ],
              "correct_answer": "A"
            }
          ]
        };

        Map<String, Object> sampleData2 = {
          "id": "ct467",
          "title": "Data Management",
          "image_url":
              "https://res.cloudinary.com/de8xbko8y/image/upload/v1699103299/flutter/data_management_w56tfj.png",
          "Description":
              "Test your knowledge with fundamental Data Management MCQs",
          "time_seconds": 900,
          "questions": [
            {
              "id": "ct467q001",
              "question": "Which of the following is not a type of database?",
              "answers": [
                {"identifier": "A", "Answer": "Hierarchical"},
                {"identifier": "B", "Answer": "Network"},
                {"identifier": "C", "Answer": "Distributed"},
                {"identifier": "D", "Answer": "Decentralized"}
              ],
              "correct_answer": "D"
            },
            {
              "id": "ct467q002",
              "question":
                  "Which of the following is correct according to the technology deployed by DBMS?",
              "answers": [
                {
                  "identifier": "A",
                  "Answer":
                      "Pointers are used to maintain transactional integrity and consistency"
                },
                {
                  "identifier": "B",
                  "Answer":
                      "Cursors are used to maintain transactional integrity and consistency"
                },
                {
                  "identifier": "C",
                  "Answer":
                      "Locks are used to maintain transactional integrity and consistency"
                },
                {
                  "identifier": "D",
                  "Answer":
                      "Triggers are used to maintain transactional integrity and consistency"
                }
              ],
              "correct_answer": "C"
            },
            {
              "id": "ct467q003",
              "question":
                  "Which of the following is popular for applications such as storage of log files in a database management system since it offers the best write performance?",
              "answers": [
                {"identifier": "A", "Answer": "RAID level 0"},
                {"identifier": "B", "Answer": "RAID level 1"},
                {"identifier": "C", "Answer": "RAID level 2"},
                {"identifier": "D", "Answer": "RAID level 3"}
              ],
              "correct_answer": "B"
            },
            {
              "id": "ct467q004",
              "question":
                  "A major goal of the db system is to minimize the number of block transfers between the disk and memory. Which of the following helps in achieving this goal?",
              "answers": [
                {"identifier": "A", "Answer": "Secondary storage"},
                {"identifier": "B", "Answer": "Storage"},
                {"identifier": "C", "Answer": "Catalog"},
                {"identifier": "D", "Answer": "Buffer"}
              ],
              "correct_answer": "D"
            },
            {
              "id": "ct467q005",
              "question":
                  "Which of the following has \"all-or-none\" property?",
              "answers": [
                {"identifier": "A", "Answer": "Atomicity"},
                {"identifier": "B", "Answer": "Durability"},
                {"identifier": "C", "Answer": "Isolation"},
                {"identifier": "D", "Answer": "All of the mentioned"}
              ],
              "correct_answer": "A"
            }
          ]
        };

        Map<String, Object> sampleData3 = {
          "id": "fl102h",
          "title": "Advanced English Grammar",
          "image_url":
              "https://res.cloudinary.com/de8xbko8y/image/upload/v1699103296/flutter/advanced_english_grammar_fetzg6.png",
          "Description":
              "Dive into advanced English grammar to enhance your proficiency in advanced grammar topics.",
          "time_seconds": 900,
          "questions": [
            {
              "id": "fl102hq001",
              "question":
                  "... Mr. Donovan had expected the charity event to be a success, the response from the community still overwhelmed him.",
              "answers": [
                {"identifier": "A", "Answer": "Whenerver"},
                {"identifier": "B", "Answer": "Although"},
                {"identifier": "C", "Answer": "Even so"},
                {"identifier": "D", "Answer": "In spite of"}
              ],
              "correct_answer": "B"
            },
            {
              "id": "fl102hq002",
              "question":
                  "To receive an electronic reminder when payment is due, set up an online account ... Albright Bank.",
              "answers": [
                {"identifier": "A", "Answer": "of"},
                {"identifier": "B", "Answer": "about"},
                {"identifier": "C", "Answer": "over"},
                {"identifier": "D", "Answer": "with"}
              ],
              "correct_answer": "D"
            },
            {
              "id": "fl102hq003",
              "question":
                  "No one without a pass will be granted ... to the conference.",
              "answers": [
                {"identifier": "A", "Answer": "admission"},
                {"identifier": "B", "Answer": "is admitting"},
                {"identifier": "C", "Answer": "admitted"},
                {"identifier": "D", "Answer": "to admit"}
              ],
              "correct_answer": "A"
            },
            {
              "id": "fl102hq004",
              "question":
                  "The lease with The Pawlicki Group ... if modifications to the existing offices are made.",
              "answers": [
                {"identifier": "A", "Answer": "had continued"},
                {"identifier": "B", "Answer": "will be continued"},
                {"identifier": "C", "Answer": "was continuing"},
                {"identifier": "D", "Answer": "has been continuing"}
              ],
              "correct_answer": "B"
            },
            {
              "id": "fl102hq005",
              "question":
                  "... of the new Delran train station will begin in late September.",
              "answers": [
                {"identifier": "A", "Answer": "Association"},
                {"identifier": "B", "Answer": "Construction"},
                {"identifier": "C", "Answer": "Violation"},
                {"identifier": "D", "Answer": "Comprehension"}
              ],
              "correct_answer": "B"
            }
          ]
        };

        final documentReference =
            collectionReference.doc(sampleData['id'] as String);

        await documentReference.set(sampleData);

        final documentReference1 =
            collectionReference.doc(sampleData1['id'] as String);

        await documentReference1.set(sampleData1);

        final documentReference2 =
            collectionReference.doc(sampleData2['id'] as String);

        await documentReference2.set(sampleData2);

        final documentReference3 =
            collectionReference.doc(sampleData3['id'] as String);

        await documentReference3.set(sampleData3);

        AppLogger.info('Collection and document created successfully.');
      }

      // Sample data for a quiz
    } catch (error) {
      AppLogger.error('Error creating collection and document: $error');
    }
  }
}
