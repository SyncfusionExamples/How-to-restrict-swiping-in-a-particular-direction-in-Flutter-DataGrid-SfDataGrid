import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = [];

  @override
  void initState() {
    super.initState();
    _employees = populateData();
    _employeeDataSource = EmployeeDataSource(_employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Syncfusion DataGrid Demo')),
      body: SfDataGrid(
        source: _employeeDataSource,
        columns: getColumns,
        columnWidthMode: ColumnWidthMode.fill,
        allowSwiping: true,
        onSwipeStart: (swipeStartDetails) {
          if (swipeStartDetails.swipeDirection ==
              DataGridRowSwipeDirection.startToEnd) {
            return false;
          } else {
            return true;
          }
        },
        endSwipeActionsBuilder:
            (BuildContext context, DataGridRow row, int rowIndex) {
          return GestureDetector(
              onTap: () {
                _employeeDataSource.dataGridRows.removeAt(rowIndex);
                _employeeDataSource.updateDataGridSource();
              },
              child: Container(
                  color: Colors.redAccent,
                  child: const Center(
                    child: Icon(Icons.delete),
                  )));
        },
      ),
    );
  }

  List<GridColumn> get getColumns {
    return <GridColumn>[
      GridColumn(
          columnName: 'ID',
          label:
              Container(alignment: Alignment.center, child: const Text('ID'))),
      GridColumn(
          columnName: 'Name',
          label: Container(
              alignment: Alignment.center, child: const Text('Name'))),
      GridColumn(
          columnName: 'Designation',
          label: Container(
              alignment: Alignment.center,
              child: const Text(
                'Designation',
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'Salary',
          label: Container(
              alignment: Alignment.center, child: const Text('Salary'))),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    buildDataGridRows(employees);
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRows(List<Employee> employeesData) {
    dataGridRows = employeesData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(
                  columnName: 'Designation', value: e.designation),
              DataGridCell<int>(columnName: 'Salary', value: e.salary),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}

List<Employee> populateData() {
  return [
    Employee(10001, 'Jack', 'Manager', 150000),
    Employee(10002, 'Perry', 'Lead', 80000),
    Employee(10003, 'James', 'Developer', 55000),
    Employee(10004, 'Michael', 'Designer', 39000),
    Employee(10005, 'Maria', 'Developer', 45000),
    Employee(10006, 'Edwards', 'UI Designer', 36000),
    Employee(10008, 'Adams', 'Developer', 43000),
    Employee(10009, 'Edwards', 'QA Testing', 43000),
    Employee(10010, 'Grimes', 'QA Testing', 43000),
  ];
}
