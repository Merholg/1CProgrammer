
&AtClient
Procedure ТоварыКоличествоЦенаOnChange(Item)
	Товар = Items.Товары.CurrentData;
	Товар.Сумма = Товар.Количество * Товар.Цена;
	Object.ОбщаяСтоимость = Object.Товары.Total("Сумма");
EndProcedure

&AtServer
Procedure ТоварыOnChangeAtServer()
	ТЗ = Object.Товары.Unload();
	ТЗ.GroupBy("Номенклатура, Цена", "Количество, Сумма");
	Object.Товары.Load(ТЗ);
EndProcedure

&AtClient
Procedure ТоварыOnChange(Item)
	ТоварыOnChangeAtServer();
EndProcedure

&AtClient
Procedure ТоварыНоменклатураOnChange(Item)
	Товар = Items.Товары.CurrentData;
	Товар.Цена = РаботаСоСправочниками.ПолучитьРозничнуюЦенуТовара(Товар.Номенклатура);
	Товар.Количество = 1;
	Товар.Сумма = Товар.Количество * Товар.Цена;
EndProcedure
