
Procedure Posting(Cancel, Mode)
	//{{__REGISTER_REGISTERRECORDS_WIZARD
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ЦеныНоменклатуры
	RegisterRecords.ЦеныНоменклатуры.Write = True;
	For Each CurRowТовары In Товары Do
		Record = RegisterRecords.ЦеныНоменклатуры.Add();
		Record.Period = Date;
		Record.Номенклатура = CurRowТовары.Номенклатура;
		Record.ВидЦены = ВидЦены;
		Record.Цена = CurRowТовары.Цена;
	EndDo;

	//}}__REGISTER_REGISTERRECORDS_WIZARD
EndProcedure
