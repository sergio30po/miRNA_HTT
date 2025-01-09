Attribute VB_Name = "Módulo1"
Sub ImportarTXT()
    Dim Carpeta As String
    Dim Archivo As String
    Dim Hoja As Worksheet
    Dim NombreHoja As String
    
    ' Seleccionar carpeta que contiene los archivos TXT
    With Application.FileDialog(msoFileDialogFolderPicker)
        .Title = "Selecciona la carpeta con los archivos TXT"
        If .Show = -1 Then
            Carpeta = .SelectedItems(1) & "\"
        Else
            Exit Sub ' Si el usuario cancela
        End If
    End With
    
    ' Obtener el primer archivo TXT en la carpeta
    Archivo = Dir(Carpeta & "*.txt")
    
    ' Importar cada archivo TXT
    Do While Archivo <> ""
        ' Crear una nueva hoja
        Set Hoja = ThisWorkbook.Sheets.Add
        
        ' Asignar el nombre del archivo (sin extensión y sin "-read_counts") como nombre de la hoja
        NombreHoja = Left(Archivo, InStrRev(Archivo, ".") - 1) ' Quitar la extensión
        NombreHoja = Replace(NombreHoja, "-read_counts", "")  ' Quitar el sufijo "-read_counts"
        Hoja.Name = NombreHoja
        
        ' Importar el contenido del archivo TXT
        With Hoja.QueryTables.Add(Connection:="TEXT;" & Carpeta & Archivo, Destination:=Hoja.Range("A1"))
            .TextFileParseType = xlDelimited
            .TextFileTabDelimiter = True
            .TextFileConsecutiveDelimiter = False
            .Refresh BackgroundQuery:=False
        End With
        
        ' Obtener el siguiente archivo
        Archivo = Dir
    Loop
End Sub

