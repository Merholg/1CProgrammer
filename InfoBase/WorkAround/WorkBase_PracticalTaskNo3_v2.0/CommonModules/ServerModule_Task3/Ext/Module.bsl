Функция FindRegionName(RegionNumStr, RegionName) Экспорт 
	RegionName = "";
	Query = Новый Запрос;
	Query.Текст = 
        "ВЫБРАТЬ
        |   Наименование
        |ИЗ
        |   Справочник.NumOfRegions КАК NumOfRegions
        |ГДЕ
        |   NumOfRegions.Код = &RegionNumStr";
	Query.УстановитьПараметр("RegionNumStr", RegionNumStr);
	QueryResult = Query.Выполнить();
	SelectedRegionNames = QueryResult.Выбрать();
	Если SelectedRegionNames.Следующий() Тогда 
		RegionName = SelectedRegionNames.Наименование;
		Возврат Истина;
	КонецЕсли;
	Возврат Ложь;
КонецФункции

