//Практическое задание No2.
//В рамках задания «Процедуры и функции» вам необходимо выполнить следующие действия:
//1. Создать функцию, которая возводит число в степень. В функции два аргумента.
//2. Первый аргумент – число, которое нужно возвести в степень. Второй аргумент – степень числа.
//Запрещено использовать функцию возведения в степень. Реализовать через умножение в цикле. Результат вывести в сообщении.
//3. Написать функцию, которая в зависимости от типа переданного параметра выводит сообщение.
//Если типы «число», «строка», «дата», то сообщение: «Данный параметр имеет тип» и далее название типа.
//Если тип «булево», то сообщение: «Данный параметр может принимать значение "истина" или "ложь"».
//Если другой тип, то сообщение: «тип не определен».
//4. Ознакомиться с определениями «Функция», «Процедура», разделом «Примитивные типы» в синтаксис-помощнике.


Function SquareRealNumber(Val a)
	
	low = 0;
	high = ?(a < 1, 1, a);
    While True Do
		middle = Окр((low + high) / 2, 15);
		If (middle * middle) <= a Then
			If middle = low Then
				Return middle;
			EndIf;
        	low = middle;
		Else
			If middle = high Then
				Return middle;
			EndIf;
        	high = middle;
		EndIf;
	EndDo;
EndFunction

Procedure PowInteger(p, Val a, Val b)
	If b <= p.b Then
		PowInteger(p, a * a, b * 2);
	EndIf;
	If b <= p.b Then
		p.b = p.b - b;
		p.pow = p.pow * a;
	EndIf;
EndProcedure

Procedure PowFractional(p, Val a, Val b)
	While Окр(p.b, 15) > 0 Do
		If b <= p.b Then
			p.b = p.b - b;
			p.pow = p.pow * a;
		EndIf;
		a = SquareRealNumber(a);
		b = b / 2;
	EndDo;
EndProcedure

Function PowerRealNumber(Val a, Val b) Export
	pow_t = New Структура("b, pow", b, 1);
	PowInteger(pow_t, a, 1);
	PowFractional(pow_t, a, 1);
	Return Окр(pow_t.pow, 12);
EndFunction

Function TypeDetermination(Val a) Export
	TypeOfValue = TypeOf(a);
	If Type("Число") = TypeOfValue Then
		Return "Данный параметр имеет тип Число";
	ElsIf Type("Строка") = TypeOfValue Then
		Return "Данный параметр имеет тип Строка";
	ElsIf Type("Дата") = TypeOfValue Then
		Return "Данный параметр имеет тип Дата";
	ElsIf Type("Булево") = TypeOfValue Then
		Return "Данный параметр может принимать значение «истина» или «ложь»";
	Else
		Return "тип не определен";
	EndIf;
	Return "Не может быть";
EndFunction
		
//Процедура ПриНачалеРаботыСистемы()
	// Вставить содержимое обработчика.
	// при значении аргументов 6.7 ** 2.7 
	//Сообщить(PowerRealNumber(6.7, 2.7)); //вывод 169,981621311176
	//Сообщить(Pow(6.7, 2.7)); //вывод 169,981621311173
	//Сообщить(TypeDetermination(0));
	//Сообщить(TypeDetermination("Строка"));
	//Сообщить(TypeDetermination(Дата(2012,01,02)));
	//Сообщить(TypeDetermination(True));
	
//КонецПроцедуры
