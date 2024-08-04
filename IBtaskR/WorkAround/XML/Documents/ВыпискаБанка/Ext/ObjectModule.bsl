
Procedure Posting(Cancel, Mode)
	//{{__REGISTER_REGISTERRECORDS_WIZARD
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр Взаиморасчеты Receipt
	RegisterRecords.Взаиморасчеты.Write = True;
	For Each CurRowПоступлениеДС In ПоступлениеДС Do
		Record = RegisterRecords.Взаиморасчеты.Add();
		Record.RecordType = AccumulationRecordType.Receipt;
		Record.Period = Date;
		Record.Контрагент = CurRowПоступлениеДС.Контрагент;
		Record.Договор = CurRowПоступлениеДС.Договор;
		Record.Организация = Организация;
		Record.Сумма = CurRowПоступлениеДС.Сумма;
	EndDo;

	// регистр Взаиморасчеты Expense
	RegisterRecords.Взаиморасчеты.Write = True;
	For Each CurRowСписаниеДС In СписаниеДС Do
		Record = RegisterRecords.Взаиморасчеты.Add();
		Record.RecordType = AccumulationRecordType.Expense;
		Record.Period = Date;
		Record.Контрагент = CurRowСписаниеДС.Контрагент;
		Record.Договор = CurRowСписаниеДС.Договор;
		Record.Организация = Организация;
		Record.Сумма = CurRowСписаниеДС.Сумма;
	EndDo;

	//}}__REGISTER_REGISTERRECORDS_WIZARD
EndProcedure
