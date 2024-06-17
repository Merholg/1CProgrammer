#Область ОписаниеПеременных
Перем strRegionNum;
Перем strRegionName;
#КонецОбласти

#Область ОбработчикиСобытий
&НаКлиенте
Процедура FindName(Команда)
	strRegionName = "";
	strRegionNum = GetRegionNumber(GovAutoNumberProp);
	Если ServerModule_Task3.FindRegionName(strRegionNum, strRegionName) Тогда 
		CommentProp = "Регион с номером:" + strRegionNum + " - " + strRegionName;
	Иначе
		Элементы.FindNameKey.Доступность = Ложь;
		CommentProp = "Регион с номером:" + strRegionNum + " - не обнаружен";
		Message = Новый СообщениеПользователю;
		Message.Текст = "Неправильно введен гос.номер";
		Message.Поле = "GovAutoNumberProp";
		Message.Сообщить();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Элементы.FindNameKey.Доступность = Ложь;
	CommentProp = "Гос.номер должен заканчиваться цифрами"; 
КонецПроцедуры

&НаКлиенте
Процедура GovAutoNumberFieldИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
	GovAutoNumberProp = Текст;
	Если СтрДлина(GetRegionNumber(GovAutoNumberProp)) > 0 Тогда 
		Элементы.FindNameKey.Доступность = Истина;
		CommentProp = "";
	Иначе 
		Элементы.FindNameKey.Доступность = Ложь;
		CommentProp = "Гос. номер должен заканчиваться цифрами"; 
	КонецЕсли;
КонецПроцедуры
#КонецОбласти

#Область БазисПрограммирования
Функция GetRegionNumber(Знач strFullGovNumber)       
	strGovNumber = СокрЛП(strFullGovNumber);
	numIndStr = СтрДлина(strGovNumber);
	Пока numIndStr > 0 Цикл 
		strChar = Сред(strGovNumber, numIndStr, 1);
		numInd = СтрНайти("0123456789", strChar);
		Если numInd < 1 Тогда
			Прервать;
		КонецЕсли;
		numIndStr = numIndStr - 1;
	КонецЦикла;
	Возврат  Сред(strGovNumber, numIndStr+1, СтрДлина(strGovNumber)-numIndStr);
КонецФункции

#КонецОбласти
