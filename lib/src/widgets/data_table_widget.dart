import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';




/*
Original version of Dayanne Xavier, github: https://github.com/DayXL
Repository: https://github.com/DayXL/Atividades-de-POO-1
Adapted file: https://github.com/DayXL/Atividades-de-POO-1/blob/main/receita9-10ab/lib/view/widgets.dart#L130
*/

void _empty(String){}


class DataTableWidget extends HookWidget {
  final Function(String value) sortCallback;
  final List objects;
  final List columns;
  final List? columnsNames;
  final String Function(dynamic obj, String property) accessCallback;


  const DataTableWidget({super.key, 
    this.objects = const [],
    this.columns = const [], 
    this.columnsNames,
    sortCallback,
    required this.accessCallback,
    }):
    sortCallback = sortCallback ?? _empty ;

  @override
  Widget build(BuildContext context) {
    final columnsNamesFinal = columnsNames ?? columns;

    final sortAscending = useState(true);
    final sortColumnIndex = useState(0);
    return DataTable(
      sortAscending: sortAscending.value,
      sortColumnIndex: sortColumnIndex.value,
      columns: columnsNamesFinal.map( 
        (name) => DataColumn(
          onSort: (columnIndex, ascending) {
            sortColumnIndex.value = columnIndex;
            sortAscending.value = !sortAscending.value;

            sortCallback(columnsNamesFinal[columnIndex]);
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


      rows: objects.map( 
        (obj) => DataRow(
            cells: columns.map(
              (propName) => DataCell(Text(accessCallback(obj, propName)))
            ).toList()
          )
        ).toList()
    );
  }
}
