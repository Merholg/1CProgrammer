
Procedure Печать(Spreadsheet, Ref) Export
	//{{_PRINT_WIZARD(Печать)
	Template = Documents.ЗаказКлиента.GetTemplate("Печать");
	Query = New Query;
	Query.Text =
	"SELECT
	|	ЗаказКлиента.Date,
	|	ЗаказКлиента.Number,
	|	ЗаказКлиента.ОбщаяСтоимость,
	|	ЗаказКлиента.Покупатель,
	|	ЗаказКлиента.Склады,
	|	ЗаказКлиента.Товары.(
	|		LineNumber,
	|		Номенклатура,
	|		Количество,
	|		Цена,
	|		Сумма
	|	)
	|FROM
	|	Document.ЗаказКлиента AS ЗаказКлиента
	|WHERE
	|	ЗаказКлиента.Ref IN (&Ref)";
	Query.Parameters.Insert("Ref", Ref);
	Selection = Query.Execute().Select();

	AreaCaption = Template.GetArea("Caption");
	Header = Template.GetArea("Header");
	AreaТоварыHeader = Template.GetArea("ТоварыHeader");
	AreaТовары = Template.GetArea("Товары");
	Footer = Template.GetArea("Footer");

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

		Footer.Parameters.Fill(Selection);
		Spreadsheet.Put(Footer);

		InsertPageBreak = True;
	EndDo;
	//}}
EndProcedure
