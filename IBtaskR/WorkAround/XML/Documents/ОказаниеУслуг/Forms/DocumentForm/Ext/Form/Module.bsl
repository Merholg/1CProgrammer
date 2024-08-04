
&AtClient
Procedure УслугиКоличествоЦенаOnChange(Item)
	Товар = Items.Услуги.CurrentData;
	Товар.Сумма = Товар.Количество * Товар.Цена;
	Object.Сумма = Object.Услуги.Total("Сумма");
EndProcedure

&AtServer
Procedure ТоварыOnChangeAtServer()
	ТЗ = Object.Услуги.Unload();
	ТЗ.GroupBy("Номенклатура, Цена", "Количество, Сумма");
	Object.Услуги.Load(ТЗ);
EndProcedure

&AtClient
Procedure ТоварыOnChange(Item)
	ТоварыOnChangeAtServer();
EndProcedure

&AtClient
Procedure ТоварыНоменклатураOnChange(Item)
	Товар = Items.Услуги.CurrentData;
	Товар.Цена = РаботаСоСправочниками.ПолучитьРозничнуюЦенуТовара(Товар.Номенклатура);
	Товар.Количество = 1;
	Товар.Сумма = Товар.Количество * Товар.Цена;
EndProcedure
