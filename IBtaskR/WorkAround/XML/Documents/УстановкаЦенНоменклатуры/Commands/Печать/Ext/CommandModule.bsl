
&AtClient
Procedure CommandProcessing(CommandParameter, CommandExecuteParameters)
	//{{_PRINT_WIZARD(Печать)
	Spreadsheet = New SpreadsheetDocument;
	Печать(Spreadsheet, CommandParameter);

	Spreadsheet.ShowGrid = False;
	Spreadsheet.Protection = False;
	Spreadsheet.ReadOnly = False;
	Spreadsheet.ShowHeaders = False;
	Spreadsheet.Show();
	//}}
EndProcedure

&AtServer
Procedure Печать(Spreadsheet, CommandParameter)
	Documents.УстановкаЦенНоменклатуры.Печать(Spreadsheet, CommandParameter);
EndProcedure
