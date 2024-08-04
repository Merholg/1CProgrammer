
&AtClient
Procedure ТоварыКоличествоЦенаOnChange(Item)
	Товар = Items.Товары.CurrentData;
	Товар.Сумма = Товар.Количество * Товар.ЦенаПоступления;
	Object.Сумма = Object.Товары.Total("Сумма");
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

&AtClient                                                                                                         
Procedure BeforeWrite(Cancel, WriteParameters)
	Object.Сумма = Object.Товары.Total("Сумма");
EndProcedure

&AtClient
Procedure КонтрагентOnChange(Item)
	If NOT ПроверкаНаПоставщика(Object.Поставщик) Then
		ТекстСообщения = "У контрагента не установлен признак поставщика. Установить?";
		Режим = QuestionDialogMode.YesNo;
		Оповещение = New NotifyDescription("УстановкаПризнакаПоставщика", ThisForm);
		ShowQueryBox(Оповещение, ТекстСообщения, Режим);
	EndIf;
EndProcedure

&AtServer
Function ПроверкаНаПоставщика(Поставщик)
	Return Поставщик.ЭтоПоставщик;
EndFunction

&AtClient
Procedure УстановкаПризнакаПоставщика(Ответ, ДополнительныеПараметры) Export
	If DialogReturnCode.Yes = Ответ Then
		//Message("Answer Yes");
		ПризнакПоставщика(Object.Поставщик);
	EndIf;
EndProcedure	  

&AtServer
Procedure ПризнакПоставщика(Поставщик)
	ОбъектПоставщика = Поставщик.GetObject();
	ОбъектПоставщика.ЭтоПоставщик = True;
	ОбъектПоставщика.Write();
EndProcedure
