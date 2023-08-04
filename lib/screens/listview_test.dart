import 'package:dm_mobile/widgets/exercise_title.dart';
import 'package:flutter/material.dart';

import '../widgets/emotion_face.dart';

class ListViewTest extends StatefulWidget {
  const ListViewTest({super.key});

  @override
  State<ListViewTest> createState() => _ListViewTestState();
}

class _ListViewTestState extends State<ListViewTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi Jared!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '23 Jan, 2021',
                            style: TextStyle(color: Colors.blue[100]),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[600],
                            borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // search bar
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Search",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'How do you feel?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),

            // 4 different faces
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    EmoticonFace(
                      emoticonFace: "😞",
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Bad",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: const [
                    EmoticonFace(
                      emoticonFace: "😀",
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Fine",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: const [
                    EmoticonFace(
                      emoticonFace: "😊",
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Well",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: const [
                    EmoticonFace(
                      emoticonFace: "🥰",
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Excellent",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(25),
                color: Colors.grey[200],
                child: Center(
                    child: Column(
                  children: [
                    //exercise heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Exercises",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Icon(Icons.more_horiz),
                      ],
                    ),
                    SizedBox(height: 20),

                    // listview of exercises
                    Expanded(
                      child: ListView(
                        children: const [
                          ExerciseTitle(
                              icon: Icons.favorite,
                              exerciseName: "0422 230 861, Andy Jung",
                              numberOfExercises: 16,
                              color: Colors.orange),
                          ExerciseTitle(
                            icon: Icons.person,
                            exerciseName: "Reading Skills",
                            numberOfExercises: 8,
                            color: Colors.green,
                          ),
                          ExerciseTitle(
                            icon: Icons.star,
                            exerciseName: "Writing Skills",
                            numberOfExercises: 20,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
