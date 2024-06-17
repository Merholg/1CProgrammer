
&НаКлиенте
Процедура Determine(Команда)
	ResultDataTypeDetermined = ServerModule_1.TypeDetermination(DeterminedTypeValue); 
КонецПроцедуры

&НаКлиенте
Процедура Power(Команда)
	ResultPoweredNumber = ServerModule_1.PowerRealNumber(RaisedNumber, PowerNumber);
	ResultPowFunction = Pow(RaisedNumber, PowerNumber);
КонецПроцедуры

&НаКлиенте
Процедура RaisedNumberПриИзменении(Элемент)
	ResultPoweredNumber = 0;
	ResultPowFunction = 0;
КонецПроцедуры

&НаКлиенте
Процедура PowerNumberПриИзменении(Элемент)
	ResultPoweredNumber = 0;
	ResultPowFunction = 0;
КонецПроцедуры

&НаКлиенте
Процедура DeterminedTypeValueПриИзменении(Элемент)
	ResultDataTypeDetermined = ServerModule_1.TypeDetermination(DeterminedTypeValue);
КонецПроцедуры
