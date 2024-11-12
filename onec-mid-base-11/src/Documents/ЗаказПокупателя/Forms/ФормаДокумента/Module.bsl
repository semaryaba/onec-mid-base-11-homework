
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	//{{Рябов С.В. Добавление команды пересчета скидки
	Существующий = ЭтотОбъект.Элементы.Найти("ГруппаШапкаЛево");
	Группа = ЭтотОбъект.Элементы.Добавить("ГруппаСкидка", Тип("ГруппаФормы"), Существующий);
	Группа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	
	//добавляем поле ввода
	ДобавляемыеРеквизиты = Новый Массив;
	РеквизитФормы = Новый РеквизитФормы("РСВ_Скидка", Новый ОписаниеТипов("Число"),, "РСВ_Скидка");
	ДобавляемыеРеквизиты.Добавить(РеквизитФормы);
	ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	ПолеВвода = Элементы.Вставить("РСВ_Скидка", Тип("ПолеФормы"), Группа);
	ПолеВвода.ПутьКДанным = "Объект.РСВ_Скидка";
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.УстановитьДействие("ПриИзменении", "ПриИзмененииСкидки");
	
	//добавляем команду
	Команда = Команды.Добавить("ПересчитатьСкидку");
	Команда.Заголовок = "Пересчитать скидку";
	Команда.Действие = "КомандаПересчитатьСкидку";
	
	КнопкаФормы = Элементы.Вставить("КнопкаПересчитатьСкидку", Тип("КнопкаФормы"), Группа,);
	КнопкаФормы.ИмяКоманды = "ПересчитатьСкидку";
	КнопкаФормы.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
	//}}
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

&НаКлиенте
Асинх Процедура ПриИзмененииСкидки()
	//{{Рябов С.В. Изменение рассчета скидки при активации строки
	Диалог = ВопросАсинх("Пересчитать табличную часть с учетом скидки?",
		РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Да, "Пересчитать скидку?");
	Результат = Ждать Диалог; 
	Если Результат = КодВозвратаДиалога.Да Тогда
		ПересчитатьВсеТаблицы();
	Иначе
		Возврат;
	КонецЕсли;
	//}}
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	//Исходный код
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	//ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	//Конец исходного кода
	
	//{{Рябов С.В. Изменение процедуры расчета строки
	СуммаСкидки = ТекущиеДанные.Скидка + Объект.РСВ_Скидка;
	Если СуммаСкидки > 100 Тогда
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = СтрШаблон("Сумма скидки для товара %1 больше чем 100 процентов", ТекущиеДанные.Номенклатура);
		Сообщение.Сообщить();
		ТекущиеДанные.Сумма = 0;
	Иначе	
		СуммаБезСкидки = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
		ТекущиеДанные.Сумма = СуммабезСкидки - (СуммабезСкидки * (Объект.РСВ_Скидка/100 + ТекущиеДанные.Скидка/100));
	КонецЕсли;
		
	РассчитатьСуммуДокумента();
	//}}
	РассчитатьСуммуДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьВсеТаблицы()
	//{{Рябов С.В. Изменение процедуры расчета строки
	Для каждого Строка из Объект.Товары Цикл
		РассчитатьСуммуСтроки(Строка);
	КонецЦикла;
	Для каждого Строка из Объект.Услуги Цикл
		РассчитатьСуммуСтроки(Строка);
	КонецЦикла;
    //}}
КонецПроцедуры


#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры

&НаКлиенте
Асинх Процедура КомандаПересчитатьСкидку(Команда)
	//{{Рябов С.В. Добавление команды пересчета скидки
	ПересчитатьВсеТаблицы();
    //}}
КонецПроцедуры

// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
