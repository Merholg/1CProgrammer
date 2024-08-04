
Procedure Печать(Spreadsheet, Ref) Export
	//{{_PRINT_WIZARD(Печать)
	Template = Documents.ОказаниеУслуг.GetTemplate("Печать");
	Query = New Query;
	Query.Text =
	"SELECT
	|	ОказаниеУслуг.Date,
	|	ОказаниеУслуг.Number,
	|	ОказаниеУслуг.Договор,
	|	ОказаниеУслуг.Контрагент,
	|	ОказаниеУслуг.Организация,
	|	ОказаниеУслуг.Сумма,
	|	ОказаниеУслуг.Услуги.(
	|		LineNumber,
	|		Номенклатура,
	|		Количество,
	|		Цена,
	|		Сумма
	|	)
	|FROM
	|	Document.ОказаниеУслуг AS ОказаниеУслуг
	|WHERE
	|	ОказаниеУслуг.Ref IN (&Ref)";
	Query.Parameters.Insert("Ref", Ref);
	Selection = Query.Execute().Select();

	AreaCaption = Template.GetArea("Caption");
	Header = Template.GetArea("Header");
	AreaУслугиHeader = Template.GetArea("УслугиHeader");
	AreaУслуги = Template.GetArea("Услуги");
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

		Spreadsheet.Put(AreaУслугиHeader);
		SelectionУслуги = Selection.Услуги.Select();
		While SelectionУслуги.Next() Do
			AreaУслуги.Parameters.Fill(SelectionУслуги);
			Spreadsheet.Put(AreaУслуги, SelectionУслуги.Level());
		EndDo;

		Footer.Parameters.Fill(Selection);
		Spreadsheet.Put(Footer);

		InsertPageBreak = True;
	EndDo;
	//}}
EndProcedure
