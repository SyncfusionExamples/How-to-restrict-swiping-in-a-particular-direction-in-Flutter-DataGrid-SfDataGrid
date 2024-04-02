# How to restrict swiping in a particular direction in Flutter DataGrid (SfDataGrid)

In this article, you can learn about how to restrict swiping in a particular direction in [Flutter DataGrid](https://help.syncfusion.com/flutter/datagrid/getting-started).

Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all the necessary properties. Achieve this by utilizing the [SfDataGrid.onSwipeStart](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid/onSwipeStart.html) callback event. Inside the onSwipeStart callback, return false when the [swipeDirection](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSwipeUpdateDetails/swipeDirection.html) is [DataGridRowSwipeDirection.startToEnd](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridRowSwipeDirection.html) to prevent left-to-right swiping, and return false when the swipeDirection is DataGridRowSwipeDirection.endToStart to prevent right-to-left swiping.

```dart
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
              DataGridRowSwipeDirection.endToStart) {
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
```
You can download the example from [GitHub](https://github.com/SyncfusionExamples/How-to-restrict-swiping-in-a-particular-direction-in-Flutter-DataGrid-SfDataGrid)