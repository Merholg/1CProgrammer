
Procedure Печать(Spreadsheet, Ref) Export
	//{{_PRINT_WIZARD(Печать)
	Template = Documents.ЗаказТоваровПоставщику.GetTemplate("Печать");
	Query = New Query;
	Query.Text =
	"SELECT
	|	ЗаказТоваровПоставщику.Date,
	|	ЗаказТоваровПоставщику.Number,
	|	ЗаказТоваровПоставщику.Комментарий,
	|	ЗаказТоваровПоставщику.Контрагент,
	|	ЗаказТоваровПоставщику.Ответственный,
	|	ЗаказТоваровПоставщику.Товары.(
	|		LineNumber,
	|		Номенклатура,
	|		Стоимость,
	|		Количество
	|	)
	|FROM
	|	Document.ЗаказТоваровПоставщику AS ЗаказТоваровПоставщику
	|WHERE
	|	ЗаказТоваровПоставщику.Ref IN (&Ref)";
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
