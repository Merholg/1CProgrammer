
Procedure Печать(Spreadsheet, Ref) Export
	//{{_PRINT_WIZARD(Печать)
	Template = Documents.ПоступлениеТоваров.GetTemplate("Печать");
	Query = New Query;
	Query.Text =
	"SELECT
	|	ПоступлениеТоваров.Date,
	|	ПоступлениеТоваров.Number,
	|	ПоступлениеТоваров.Заказ,
	|	ПоступлениеТоваров.Поставщик,
	|	ПоступлениеТоваров.Склады,
	|	ПоступлениеТоваров.Товары.(
	|		LineNumber,
	|		Номенклатура,
	|		Количество,
	|		ЦенаПоступления,
	|		Сумма
	|	)
	|FROM
	|	Document.ПоступлениеТоваров AS ПоступлениеТоваров
	|WHERE
	|	ПоступлениеТоваров.Ref IN (&Ref)";
	Query.Parameters.Insert("Ref", Ref);
	Selection = Query.Execute().Select();

	AreaCaption = Template.GetArea("Caption");
	Header = Template.GetArea("Header");
	AreaТоварыHeader = Template.GetArea("ТоварыHeader");
	AreaТовары = Template.GetArea("Товары");
	Spreadsheet.Clear();

	InsertPageBreak = False;
	While Selection.Next() Do
		If InsertPageBreak Then
			Spreadsheet.PutHorizontalPageBreak();
		EndIf;

		Spreadsheet.Put(AreaCaption);

		Header.Parameters.Fill(Selection);
		Spreadsheet.Put(Header, Selection.Level());

		Spreadsheet.Put(AreaТоварыHeader);
		SelectionТовары = Selection.Товары.Select();
		While SelectionТовары.Next() Do
			AreaТовары.Parameters.Fill(SelectionТовары);
			Spreadsheet.Put(AreaТовары, SelectionТовары.Level());
		EndDo;

		InsertPageBreak = True;
	EndDo;
	//}}
EndProcedure
