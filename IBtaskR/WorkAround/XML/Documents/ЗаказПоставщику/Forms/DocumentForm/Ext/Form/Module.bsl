
&AtClient
Procedure ТоварыКоличествоЦенаOnChange(Item)
	Товар = Items.Товары.CurrentData;
	Товар.Сумма = Товар.Количество * Товар.ЦенаПоступления;
	Object.ОбщаяСтоимость = Object.Товары.Total("Сумма");
EndProcedure

&AtServer
Procedure ТоварыOnChangeAtServer()
	ТЗ = Object.Товары.Unload();
	ТЗ.GroupBy("Номенклатура, ЦенаПоступления", "Количество, Сумма");
	Object.Товары.Load(ТЗ);
EndProcedure

&AtClient
Procedure ТоварыOnChange(Item)
	ТоварыOnChangeAtServer();
EndProcedure

&AtClient
Procedure ТоварыНоменклатураOnChange(Item)
	Товар = Items.Товары.CurrentData;
	Товар.ЦенаПоступления = РаботаСоСправочниками.ПолучитьЗакупочнуюЦенуТовара(Товар.Номенклатура);
	Товар.Количество = 1;
	Товар.Сумма = Товар.Количество * Товар.ЦенаПоступления;
EndProcedure
