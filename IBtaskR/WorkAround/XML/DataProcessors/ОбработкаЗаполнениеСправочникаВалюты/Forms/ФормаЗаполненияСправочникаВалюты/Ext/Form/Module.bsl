
&AtServer
Procedure КоммандаЗаполнитьСправочникВалютыAtServer()

	//ВыборкаСправочникаВалюты = Catalogs.Валюты.Select();
	//While ВыборкаСправочникаВалюты.Next() Do
	//	ВалютаЭлемент = ВыборкаСправочникаВалюты.GetObject();
	//	ВалютаЭлемент.DataExchange.Load = True;
	//	ВалютаЭлемент.Delete();
	//EndDo;
	
	ТаблицаВалюты = ThisForm.РеквизитТаблицаКодовВалют;
	ВысотаТаблицыВалют = ТаблицаВалюты.TableHeight;
	ШиринаТаблицыВалют = ТаблицаВалюты.TableWidth;
	СтрокаТаблицыВалют = 1;
	While СтрокаТаблицыВалют <= ВысотаТаблицыВалют Do
		ЦифроКод = Number(ТаблицаВалюты.Area("R" + String(СтрокаТаблицыВалют) + "C1").Text);
		Наименование = ТаблицаВалюты.Area("R" + String(СтрокаТаблицыВалют) + "C2").Text;
		БуквоКод = ТаблицаВалюты.Area("R" + String(СтрокаТаблицыВалют) + "C3").Text;
		СправочникВалюты = Catalogs.Валюты.CreateItem();
		СправочникВалюты.Code = ЦифроКод;
		СправочникВалюты.БуквенныйКодВалюты = БуквоКод;
		СправочникВалюты.Description = Наименование;
		СправочникВалюты.Write();
		СтрокаТаблицыВалют = СтрокаТаблицыВалют +1;
	EndDo;
		
EndProcedure

&AtClient
Procedure КоммандаЗаполнитьСправочникВалюты(Command)
	КоммандаЗаполнитьСправочникВалютыAtServer();
EndProcedure

&AtClient
Procedure КоммандаЗаписатьТаблицуВЕхел(Command)
	ДиалогВыбора = New FileDialog(FileDialogMode.Save);
	ДиалогВыбора.Title = "Файл для записи";
	ДиалогВыбора.Filter = "Документ Excel (*.xls, *.xlsx)|*.xls;*.xlsx|";
	ДиалогВыбора.Multiselect = False;
	If ДиалогВыбора.Choose() Then
		ИмяФайла = ДиалогВыбора.FullFileName;
		РеквизитТаблицаКодовВалют.Write(ИмяФайла,SpreadsheetDocumentFileType.XLS);
	EndIf;
EndProcedure
