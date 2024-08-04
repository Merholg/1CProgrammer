
Procedure Печать(Spreadsheet, Ref) Export
	//{{_PRINT_WIZARD(Печать)
	Template = Documents.ВыпискаБанка.GetTemplate("Печать");
	Query = New Query;
	Query.Text =
	"SELECT
	|	ВыпискаБанка.Date,
	|	ВыпискаБанка.Number,
	|	ВыпискаБанка.Организация,
	|	ВыпискаБанка.ПоступлениеДС.(
	|		LineNumber,
	|		Контрагент,
	|		Сумма,
	|		Договор,
	|		НазначениеПлатежа
	|	),
	|	ВыпискаБанка.СписаниеДС.(
	|		LineNumber,
	|		Контрагент,
	|		Сумма,
	|		Договор,
	|		НазначениеПлатежа
	|	)
	|FROM
	|	Document.ВыпискаБанка AS ВыпискаБанка
	|WHERE
	|	ВыпискаБанка.Ref IN (&Ref)";
	Query.Parameters.Insert("Ref", Ref);
	Selection = Query.Execute().Select();

	AreaCaption = Template.GetArea("Caption");
	Header = Template.GetArea("Header");
	AreaПоступлениеДСHeader = Template.GetArea("ПоступлениеДСHeader");
	AreaПоступлениеДС = Template.GetArea("ПоступлениеДС");
	AreaСписаниеДСHeader = Template.GetArea("СписаниеДСHeader");
	AreaСписаниеДС = Template.GetArea("СписаниеДС");
	Spreadsheet.Clear();

	InsertPageBreak = False;
	While Selection.Next() Do
		If InsertPageBreak Then
			Spreadsheet.PutHorizontalPageBreak();
		EndIf;

		Spreadsheet.Put(AreaCaption);

		Header.Parameters.Fill(Selection);
		Spreadsheet.Put(Header, Selection.Level());

		Spreadsheet.Put(AreaПоступлениеДСHeader);
		SelectionПоступлениеДС = Selection.ПоступлениеДС.Select();
		While SelectionПоступлениеДС.Next() Do
			AreaПоступлениеДС.Parameters.Fill(SelectionПоступлениеДС);
			Spreadsheet.Put(AreaПоступлениеДС, SelectionПоступлениеДС.Level());
		EndDo;

		Spreadsheet.Put(AreaСписаниеДСHeader);
		SelectionСписаниеДС = Selection.СписаниеДС.Select();
		While SelectionСписаниеДС.Next() Do
			AreaСписаниеДС.Parameters.Fill(SelectionСписаниеДС);
			Spreadsheet.Put(AreaСписаниеДС, SelectionСписаниеДС.Level());
		EndDo;

		InsertPageBreak = True;
	EndDo;
	//}}
EndProcedure
