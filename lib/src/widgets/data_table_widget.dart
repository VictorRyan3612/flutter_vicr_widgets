import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';




/*
Original version of Dayanne Xavier, github: https://github.com/DayXL
Repository: https://github.com/DayXL/Atividades-de-POO-1
Adapted file: https://github.com/DayXL/Atividades-de-POO-1/blob/main/receita9-10ab/lib/view/widgets.dart#L130
*/

void empty(String){}


class DataTableWidget extends HookWidget {
  final Function(String value)? sortCallback;
  final List objects;
  final List columns;
  final List? columnsNames;
  final String Function(dynamic obj, String property) accessCallback;
  final Function(dynamic item)? onTapRow;

  const DataTableWidget({super.key, 
    this.objects = const [],
    this.columns = const [], 
    this.columnsNames,
    this.sortCallback,
    required this.accessCallback,
    this.onTapRow,
    });

  
  @override
  Widget build(BuildContext context) {
    final columnsNamesFinal = columnsNames ?? columns;
    
    final onTapRowFinal = onTapRow ?? empty;
    final sortCallbackFinal = sortCallback ?? empty;

    final sortAscending = useState(true);
    final sortColumnIndex = useState(0);

    return DataTable(
      showCheckboxColumn: false,
      sortAscending: sortAscending.value,
      sortColumnIndex: sortColumnIndex.value,
      columns: columnsNamesFinal.map( 
        (name) => DataColumn(
          onSort: (columnIndex, ascending) {
            sortColumnIndex.value = columnIndex;
            sortAscending.value = !sortAscending.value;

            sortCallbackFinal(columnsNamesFinal[columnIndex]);
          },
          label: Expanded(
            child: Text(name,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold
              )
            )
          )
        )
      ).toList(),


      rows: List<DataRow>.generate(
        objects.length,
        (index) => DataRow(
          cells: columns.map(
            (propName) => DataCell(Text(accessCallback(objects[index], propName))),
          ).toList(),
          
          onSelectChanged: (selected) {
            onTapRowFinal(objects[index]);
          },
        ),
      ),

    );
  }
}
