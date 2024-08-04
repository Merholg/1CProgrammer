
Procedure Filling(FillingData, StandardProcessing)
	//{{__CREATE_BASED_ON_WIZARD
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	If TypeOf(FillingData) = Type("DocumentRef.ЗаказКлиента") Then
		// Заполнение шапки
		Заказ = FillingData.Ref;
		Покупатель = FillingData.Покупатель;
		Склад = FillingData.Склад;
		For Each CurRowТовары In FillingData.Товары Do
			If CurRowТовары.Номенклатура.ВидНоменклатуры = Enums.ВидыНоменклатуры.Товар Then
				NewRow = Товары.Add();
				NewRow.Количество = CurRowТовары.Количество;
				NewRow.Номенклатура = CurRowТовары.Номенклатура;
				NewRow.Сумма = CurRowТовары.Сумма;
				NewRow.Цена = CurRowТовары.Цена;
			EndIf;
		EndDo;
	EndIf;
	//}}__CREATE_BASED_ON_WIZARD
EndProcedure

Procedure Posting(Cancel, Mode)
	//{{__REGISTER_REGISTERRECORDS_WIZARD
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ОстаткиНоменклатуры Expense
	RegisterRecords.ОстаткиНоменклатуры.Write = True;
	For Each CurRowТовары In Товары Do
		Record = RegisterRecords.ОстаткиНоменклатуры.Add();
		Record.RecordType = AccumulationRecordType.Expense;
		Record.Period = Date;
		Record.Номенклатура = CurRowТовары.Номенклатура;
		Record.Склад = Склад;
		Record.Количество = CurRowТовары.Количество;
	EndDo;

	// регистр Взаиморасчеты Receipt
	RegisterRecords.Взаиморасчеты.Write = True;
	For Each CurRowТовары In Товары Do
		Record = RegisterRecords.Взаиморасчеты.Add();
		Record.RecordType = AccumulationRecordType.Receipt;
		Record.Period = Date;
		Record.Контрагент = Покупатель;
		Record.Договор = Договор;
		Record.Сумма = Сумма;
	EndDo;

	// регистр Продажи 
	RegisterRecords.Продажи.Write = True;
	For Each CurRowТовары In Товары Do
		Record = RegisterRecords.Продажи.Add();
		Record.Period = Date;
		Record.Номенклатура = CurRowТовары.Номенклатура;
		Record.Контрагент = Покупатель;
		Record.Склад = Склад;
		Record.Количество = CurRowТовары.Количество;
		Record.Выручка = CurRowТовары.Сумма;
	EndDo;

	//}}__REGISTER_REGISTERRECORDS_WIZARD
	     	//{{QUERY_BUILDER_WITH_RESULT_PROCESSING
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Query = New Query;
	Query.Text = 
		"SELECT
		|	ОстаткиНоменклатурыBalance.Номенклатура AS Номенклатура,
		|	ОстаткиНоменклатурыBalance.Склад AS Склад,
		|	ОстаткиНоменклатурыBalance.КоличествоBalance AS КоличествоBalance
		|FROM
		|	AccumulationRegister.ОстаткиНоменклатуры.Balance(
		|			,
		|			Склад = &Склад
		|				AND Номенклатура IN
		|					(SELECT
		|						РеализацияТоваровТовары.Номенклатура AS Номенклатура
		|					FROM
		|						Document.РеализацияТоваров.Товары AS РеализацияТоваровТовары
		|					WHERE
		|						РеализацияТоваровТовары.Ref = &Ref)) AS ОстаткиНоменклатурыBalance
		|WHERE
		|	ОстаткиНоменклатурыBalance.КоличествоBalance < 0";
	
	Query.SetParameter("Ref", Ref);
	Query.SetParameter("Склад", Склад);
	
	QueryResult = Query.Execute();
	If NOT QueryResult.IsEmpty() Then 
		// Недостаточно товара
		Cancel = True;
		SelectionDetailRecords = QueryResult.Select();
	
		While SelectionDetailRecords.Next() Do
			Message("Недостаточно товара: " + SelectionDetailRecords.Номенклатура + " в количестве:" + (-SelectionDetailRecords.КоличествоBalance));
		EndDo;
	Else 
		Cancel = False;       
	EndIf;
	
	//}}QUERY_BUILDER_WITH_RESULT_PROCESSING

EndProcedure
