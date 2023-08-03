import 'employemodel.dart';
import 'package:flutter/material.dart';
class EmployeScreen extends StatelessWidget {
  final Employee employee;
  const EmployeScreen({required this.employee});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Details'),backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(employee.profileImage),
            ),
            SizedBox(height: 20),
            Text('Name: ${employee.name}'),
            SizedBox(height: 10),
            Text('Company: ${employee.companyName}'),
            SizedBox(height: 10),
            Text('username: ${employee.username}'),
            SizedBox(height: 10),
            Text('phone: ${employee.phone.toString()}'),
            SizedBox(height: 10),
            Text('email: ${employee.email}'),
            SizedBox(height: 10),
            Text('street: ${employee.address}'),
          ],
        ),
      ),
    );
  }
}