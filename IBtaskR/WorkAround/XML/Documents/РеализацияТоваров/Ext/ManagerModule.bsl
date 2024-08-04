
Procedure Печать(Spreadsheet, Ref) Export
	//{{_PRINT_WIZARD(Печать)
	Template = Documents.РеализацияТоваров.GetTemplate("Печать");
	Query = New Query;
	Query.Text =
	"SELECT
	|	РеализацияТоваров.Date,
	|	РеализацияТоваров.Number,
	|	РеализацияТоваров.Заказ,
	|	РеализацияТоваров.Покупатель,
	|	РеализацияТоваров.Склады,
	|	РеализацияТоваров.Товары.(
	|		LineNumber,
	|		Номенклатура,
	|		Количество,
	|		Цена,
	|		Сумма
	|	)
	|FROM
	|	Document.РеализацияТоваров AS РеализацияТоваров
	|WHERE
	|	РеализацияТоваров.Ref IN (&Ref)";
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
