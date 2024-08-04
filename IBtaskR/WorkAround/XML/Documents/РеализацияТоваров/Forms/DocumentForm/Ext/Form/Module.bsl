
&AtClient
Procedure ТоварыКоличествоЦенаOnChange(Item)
	Товар = Items.Товары.CurrentData;
	Товар.Сумма = Товар.Количество * Товар.Цена;
	Object.Сумма = Object.Товары.Total("Сумма");
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


&AtClient
Procedure BeforeWrite(Cancel, WriteParameters)
	Object.Сумма = Object.Товары.Total("Сумма");
EndProcedure

&AtClient
Procedure КонтрагентOnChange(Item)
	If NOT ПроверкаНаПокупателя(Object.Покупатель) Then
		ТекстСообщения = "У контрагента не установлен признак покупателя. Установить?";
		Режим = QuestionDialogMode.YesNo;
		Оповещение = New NotifyDescription("УстановкаПризнакаПокупателя", ThisForm);
		ShowQueryBox(Оповещение, ТекстСообщения, Режим);
	EndIf;
EndProcedure

&AtServer
Function ПроверкаНаПокупателя(Покупатель)
	Return Покупатель.ЭтоПокупатель;
EndFunction

&AtClient
Procedure УстановкаПризнакаПокупателя(Ответ, ДополнительныеПараметры) Export
	If DialogReturnCode.Yes = Ответ Then
		//Message("Answer Yes");
		ПризнакПокупателя(Object.Покупатель);
	EndIf;
EndProcedure	  

&AtServer
Procedure ПризнакПокупателя(Покупатель)
	ОбъектПокупателя = Покупатель.GetObject();
	ОбъектПокупателя.ЭтоПокупатель = True;
	ОбъектПокупателя.Write();
EndProcedure
