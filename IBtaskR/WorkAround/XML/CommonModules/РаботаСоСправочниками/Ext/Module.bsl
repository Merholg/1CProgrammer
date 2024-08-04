Function ПолучитьЗакупочнуюЦенуТовара(Номенклатура) Export
	Отбор = New Structure;
	Отбор.Insert("Номенклатура", Номенклатура);
	Отбор.Insert("ВидЦены", Catalogs.ВидЦены.Закупочная);
	Значение = InformationRegisters.ЦеныНоменклатуры.GetLast(EndOfMonth(CurrentDate()), Отбор);
	Return Значение.Цена;
EndFunction

Function ПолучитьРозничнуюЦенуТовара(Номенклатура) Export
	Отбор = New Structure;
	Отбор.Insert("Номенклатура", Номенклатура);
	Отбор.Insert("ВидЦены", Catalogs.ВидЦены.Розничная);
	Значение = InformationRegisters.ЦеныНоменклатуры.GetLast(EndOfMonth(CurrentDate()), Отбор);
	Return Значение.Цена;
EndFunction
