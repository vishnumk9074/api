import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'employeescreen.dart';
import 'employemodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => EmployeeListScreen(),
      },
    );
  }
}

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Employee> employeeList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      setState(() {
        employeeList = data
            .map((item) => Employee(
                  name: item['name'],
                  profileImage: item['profile_image'] ?? '',
                  // Handle null profile image
                  companyName:
                      item['company'] != null ? item['company']['name'] : '',
                  username: item['username'] != null ? item['username'] : '',
                  phone: item['phone'] != null ? item['phone'] : '',
                  email: item['email'] != null ? item['email'] : '',
                  address:
                      item['address'] != null ? item['address']['street'] : '',
                ))
            .toList();
      });
    }
  }

  void _showEmployeeDetails(Employee employee) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EmployeScreen(employee: employee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        backgroundColor: Colors.yellow,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
      ),
      body: ListView.builder(
        itemCount: employeeList.length,
        itemBuilder: (context, index) {
          final employee = employeeList[index];
          return ListTile(
            onTap: () => _showEmployeeDetails(employee), // Navigate to details
            leading: CircleAvatar(
              backgroundImage: NetworkImage(employee.profileImage),
            ),
            title: Text(employee.name),
            subtitle: Text(employee.companyName),
          );
        },
      ),
    );
  }
}
