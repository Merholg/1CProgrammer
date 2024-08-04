
Procedure Posting(Cancel, Mode)
	//{{__REGISTER_REGISTERRECORDS_WIZARD
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр Взаиморасчеты Receipt
	RegisterRecords.Взаиморасчеты.Write = True;
	Record = RegisterRecords.Взаиморасчеты.Add();
	Record.RecordType = AccumulationRecordType.Receipt;
	Record.Period = Date;
	Record.Контрагент = Контрагент;
	Record.Договор = Договор;
	Record.Сумма = Сумма;

	//}}__REGISTER_REGISTERRECORDS_WIZARD
EndProcedure

Procedure Filling(FillingData, StandardProcessing)
	//{{__CREATE_BASED_ON_WIZARD
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	If TypeOf(FillingData) = Type("DocumentRef.ЗаказКлиента") Then
		// Заполнение шапки
		Сумма = FillingData.ОбщаяСтоимость;
		Контрагент = FillingData.Покупатель;
		For Each CurRowТовары In FillingData.Товары Do
			If CurRowТовары.Номенклатура.ВидНоменклатуры = Enums.ВидыНоменклатуры.Услуга Then
				NewRow = Услуги.Add();
				NewRow.Количество = CurRowТовары.Количество;
				NewRow.Номенклатура = CurRowТовары.Номенклатура;
				NewRow.Сумма = CurRowТовары.Сумма;
				NewRow.Цена = CurRowТовары.Цена;
			EndIf;
		EndDo;
	EndIf;
	//}}__CREATE_BASED_ON_WIZARD
EndProcedure
