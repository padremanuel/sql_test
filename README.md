# sql_test


# Есть 3 связанных таблицы:
## Процедуры (id, наименование)
## Лоты (Id, procedure_id [ссылка на таблицу процедуры], Стоимость)
## Позиции (Id, lot_id [ссылка на таблицу лоты], Количество)
Надо написать корректно работающий SQL-запрос,
который бы выводил наименование процедуры, суммарную стоимость лотов, суммарное количество позиций.
*/
