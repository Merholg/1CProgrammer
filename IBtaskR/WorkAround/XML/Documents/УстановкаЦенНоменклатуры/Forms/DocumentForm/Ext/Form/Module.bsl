
//&AtClient
//Procedure ТоварыКоличествоЦенаOnChange(Item)
//	Товар = Items.Товары.CurrentData;
//	Товар.Сумма = Товар.Количество * Товар.Цена;
//EndProcedure

&AtServer
Procedure ТоварыOnChangeAtServer()
	ТЗ = Object.Товары.Unload();
	ТЗ.GroupBy("Номенклатура", "Цена");
	Object.Товары.Load(ТЗ);
EndProcedure

//&AtClient
//Procedure ТоварыOnChange(Item)
//	ТоварыOnChangeAtServer();
//EndProcedure
