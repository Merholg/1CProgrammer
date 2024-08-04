
Procedure Filling(FillingData, StandardProcessing)
	//{{__CREATE_BASED_ON_WIZARD
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	If TypeOf(FillingData) = Type("DocumentRef.ЗаказПоставщику") Then
		// Заполнение шапки
		Заказ = FillingData.Ref;
		Поставщик = FillingData.Поставщик;
		Склад = FillingData.Склады;
		For Each CurRowТовары In FillingData.Товары Do
			NewRow = Товары.Add();
			NewRow.Количество = CurRowТовары.Количество;
			NewRow.Номенклатура = CurRowТовары.Номенклатура;
			NewRow.Сумма = CurRowТовары.Сумма;
			NewRow.ЦенаПоступления = CurRowТовары.ЦенаПоступления;
		EndDo;
	EndIf;
	//}}__CREATE_BASED_ON_WIZARD
EndProcedure

Procedure Posting(Cancel, Mode)
	//{{__REGISTER_REGISTERRECORDS_WIZARD
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ОстаткиНоменклатуры Receipt
	RegisterRecords.ОстаткиНоменклатуры.Write = True;
	For Each CurRowТовары In Товары Do
		Record = RegisterRecords.ОстаткиНоменклатуры.Add();
		Record.RecordType = AccumulationRecordType.Receipt;
		Record.Period = Date;
		Record.Номенклатура = CurRowТовары.Номенклатура;
		Record.Склад = Склад;
		Record.Количество = CurRowТовары.Количество;
	EndDo;

	// регистр Взаиморасчеты Expense
	RegisterRecords.Взаиморасчеты.Write = True;
	Record = RegisterRecords.Взаиморасчеты.Add();
	Record.RecordType = AccumulationRecordType.Expense;
	Record.Period = Date;
	Record.Контрагент = Поставщик;
	Record.Договор = Договор;
	Record.Сумма = Сумма;

	//}}__REGISTER_REGISTERRECORDS_WIZARD
EndProcedure
