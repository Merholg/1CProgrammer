
Procedure Posting(Cancel, Mode)
	//{{__REGISTER_REGISTERRECORDS_WIZARD
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр КурсыВалют
	RegisterRecords.КурсыВалют.Write = True;
	For Each CurRowКурсыВалют In КурсыВалют Do
		Record = RegisterRecords.КурсыВалют.Add();
		Record.Period = Date;
		Record.Валюта = CurRowКурсыВалют.Валюта;
		Record.Курс = CurRowКурсыВалют.Курс;
	EndDo;

	//}}__REGISTER_REGISTERRECORDS_WIZARD
EndProcedure
