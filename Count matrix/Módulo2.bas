Attribute VB_Name = "Count_matrix"
Sub CombinarHojas()
    Dim HojaDestino As Worksheet
    Dim HojaOrigen As Worksheet
    Dim UltimaFilaDestino As Long
    Dim UltimaFilaOrigen As Long
    Dim UltimaColumnaOrigen As Long
    Dim ColumnaInicioDestino As Long
    Dim RangoCopiar As Range

    ' Crear o limpiar una hoja para combinar
    On Error Resume Next
    Set HojaDestino = ThisWorkbook.Sheets("Combinar")
    If HojaDestino Is Nothing Then
        Set HojaDestino = ThisWorkbook.Sheets.Add
        HojaDestino.Name = "counts_matrix"
    Else
        HojaDestino.Cells.Clear ' Limpiar contenido si ya existe
    End If
    On Error GoTo 0

    ' Escribir encabezado para la columna de nombres comunes
    HojaDestino.Cells(1, 1).Value = "Row Name"
    ColumnaInicioDestino = 2 ' Comenzar a copiar datos desde la segunda columna

    ' Recorrer todas las hojas del libro
    For Each HojaOrigen In ThisWorkbook.Sheets
        If HojaOrigen.Name <> HojaDestino.Name Then
            ' Obtener la última fila y columna de la hoja origen
            UltimaFilaOrigen = HojaOrigen.Cells(HojaOrigen.Rows.Count, 1).End(xlUp).Row
            UltimaColumnaOrigen = HojaOrigen.Cells(1, HojaOrigen.Columns.Count).End(xlToLeft).Column

            ' Copiar los row names (Columna A) si aún no se han copiado
            If HojaDestino.Cells(2, 1).Value = "" Then
                HojaOrigen.Range(HojaOrigen.Cells(1, 1), HojaOrigen.Cells(UltimaFilaOrigen, 1)).Copy _
                    Destination:=HojaDestino.Cells(2, 1)
            End If

            ' Copiar los datos de las columnas adicionales (Columna B en adelante)
            Set RangoCopiar = HojaOrigen.Range(HojaOrigen.Cells(1, 2), HojaOrigen.Cells(UltimaFilaOrigen, UltimaColumnaOrigen))
            RangoCopiar.Copy Destination:=HojaDestino.Cells(2, ColumnaInicioDestino)

            ' Agregar el nombre de la hoja como encabezado para sus columnas
            HojaDestino.Cells(1, ColumnaInicioDestino).Value = HojaOrigen.Name

            ' Avanzar a la siguiente columna para la próxima hoja
            ColumnaInicioDestino = ColumnaInicioDestino + UltimaColumnaOrigen - 1
        End If
    Next HojaOrigen
End Sub


