import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;

  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Lexi Lore', 'Quezon Boulevard, Pangasinan', 'March 28, 2001',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t39.30808-6/258861931_634146477763618_2928508905448367380_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=174925&_nc_eui2=AeF8mYR8ALmTrj_5ND6jLGGMO1-5ozA50tE7X7mjMDnS0bHDJ4rNijcs22ZyrGbEB0wPtusIx9JLOJE9YfGmUeur&_nc_ohc=I1cwMMznJqYAX8B_dc1&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfCScbHR5LBNNRC1oSxaIyGDACGWAs7i2j-VO-2VuUmwDw&oe=645140D1'),
    Person('Blair Williams', 'Quezon Boulevard, Pangasinan', 'January 1, 1995',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t1.6435-9/75398391_726172547863709_1394865829958385664_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeEtIZLp_-3FLnodYWSViiUeqIEKCQdPX7eogQoJB09ft1E8VI90FUyLScoBXiYQ3xIJXB5OB_gkMw45_8j7Ii66&_nc_ohc=KXz4zNFZj_wAX8peRbi&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfCEyu0x5z3z5QUD9CfiKAjIqMktOHKXmWpHILL--yYprg&oe=647305CA'),
    Person('Miya Khalifa ', 'Quezon Boulevard, Pangasinan', 'June 16, 2000',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t1.6435-9/62073981_2454283484804749_292410569036660736_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeGsFNvw0uNiSTZMPNK3E9FW3L8OGHMpOX3cvw4Ycyk5fRgrl12fqqsU9PHb0dEEHVN6Lx84bbNPb-E1qUWzMtLD&_nc_ohc=nXlCfGyWgIAAX8oIGPm&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfBkuxOHeEW4bQmqu8mN1ExiCvWFjSJ6oGecmrh_rp1_Zg&oe=647320EF'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mandapat_ChristianRobec_MidtermExam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tit.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 5, 5),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 21, 12, 12),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Color.fromARGB(255, 22, 21, 21),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
