#!/usr/bin/env oscript

Перем Вспыхнуло;

Функция ПрочитатьДанные()
    Файл = Новый ЧтениеТекста;
    Файл.Открыть(АргументыКоманднойСтроки[0]);

    Разделитель = Новый РегулярноеВыражение("\B");

    Строки = Новый Массив;

    Строка = Файл.ПрочитатьСтроку();
    Пока Строка <> Неопределено Цикл
        Строки.Добавить(Разделитель.Разделить(Строка));
        Строка = Файл.ПрочитатьСтроку();
    КонецЦикла;

    Файл.Закрыть();

    Возврат Строки;
КонецФункции

Процедура Посмотреть(Массив)
    Для Каждого Строки Из Массив Цикл
        Для Каждого Элемент Из Строки Цикл
            Консоль.ЦветТекста = ?(Элемент = Вспыхнуло, ЦветКонсоли.Красный, ЦветКонсоли.Серый);
            Консоль.Вывести(Элемент);
        КонецЦикла;
        Консоль.ВывестиСтроку("");
    КонецЦикла;
    Консоль.ВывестиСтроку("");
КонецПроцедуры

Функция ВзятьСоседние(Массив, X, Y)
    Координаты = Новый Массив();

    Для СмещениеX = -1 По 1 Цикл
        Для СмещениеY = -1 По 1 Цикл
            НовX = X + СмещениеX;
            НовY = Y + СмещениеY;

            Если НовX >= 0 И НовY >= 0 И НовY < Массив.Количество() И НовX < Массив[0].Количество() Тогда
                Координата = Новый Массив;
                Координата.Добавить(НовX);
                Координата.Добавить(НовY);

                Координаты.Добавить(Координата);
            КонецЕсли;
        КонецЦикла;
    КонецЦикла;

    Возврат Координаты;
КонецФункции

Функция УвеличитьСоседние(Массив, X, Y)
    Вспышки = 1;

    Массив[Y][X] = Вспыхнуло;

    Для Каждого Координаты из ВзятьСоседние(Массив, X, Y) Цикл
        НовX = Координаты[0];
        НовY = Координаты[1];

        Если Массив[НовY][НовX] <> Вспыхнуло Тогда
            Массив[НовY][НовX] = 1 + Массив[НовY][НовX];
            Если Массив[НовY][НовX] > 9 Тогда
                Вспышки = Вспышки + УвеличитьСоседние(Массив, НовX, НовY);
            КонецЕсли;
        КонецЕсли;
    КонецЦикла;

    Возврат Вспышки;
КонецФункции

Массив = ПрочитатьДанные();
Вспыхнуло = ".";
Вспышки = 0;

Для Шаг = 1 По 100 Цикл
    Для Y = 0 По Массив.ВГраница() Цикл
        Для X = 0 По Массив[Y].ВГраница() Цикл
            Массив[Y][X] = 1 + Массив[Y][X];
        КонецЦикла;
    КонецЦикла;

    Для Y = 0 По Массив.ВГраница() Цикл
        Для X = 0 По Массив[Y].ВГраница() Цикл
            Если Массив[Y][X] <> Вспыхнуло И Массив[Y][X] > 9 Тогда
                Вспышки = Вспышки + УвеличитьСоседние(Массив, X, Y);
            КонецЕсли;
        КонецЦикла;
    КонецЦикла;

    Для Y = 0 По Массив.ВГраница() Цикл
        Для X = 0 По Массив[Y].ВГраница() Цикл
            Если Массив[Y][X] = Вспыхнуло Тогда
                Массив[Y][X] = 0;
            КонецЕсли;
        КонецЦикла;
    КонецЦикла;
КонецЦикла;

Сообщить(Вспышки);
