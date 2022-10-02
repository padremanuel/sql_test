 # Задание 1
 
Есть 3 связанных таблицы:
* Процедуры (id, наименование)
* Лоты (Id, procedure_id [ссылка на таблицу процедуры], Стоимость)
* Позиции (Id, lot_id [ссылка на таблицу лоты], Количество)

*Надо написать корректно работающий SQL-запрос,
который бы выводил наименование процедуры, суммарную стоимость лотов, суммарное количество позиций.*

# Создание таблиц базы данных и заполнение

```sql
/*таблица процедуры*/
CREATE TABLE IF NOT EXISTS procs (
  id int(11) NOT NULL AUTO_INCREMENT,
  proc_name varchar(60) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (id)
);

/*таблица лоты*/
CREATE TABLE IF NOT EXISTS lots (
  Id int(11) NOT NULL AUTO_INCREMENT,
  procedure_id int(11) NOT NULL REFERENCES procs(id),
  price double NOT NULL,
  PRIMARY KEY (Id)
);

/*таблица позиции*/
CREATE TABLE IF NOT EXISTS pozs (
  Id int(11) NOT NULL AUTO_INCREMENT,
  lot_id int(11) NOT NULL REFERENCES lots(Id),
  poz_count int(11) NOT NULL,
  PRIMARY KEY (Id)
);

/*заполнение процедур*/
INSERT INTO procs (proc_name) VALUES 
('cleaning'),
('promotion'),
('Поддержка')
;

/*заполнение лотов*/
INSERT INTO lots (procedure_id, price) VALUES
(2, 17),
(2, 0.5),
(2, 100),
(1, 20),
(1, 30),
(3, 777)
;

/*заполнение позиций*/
INSERT INTO pozs (lot_id, poz_count) VALUES
(1, 7),
(1, 7),
(2, 8),
(2, 8),
(2, 8),
(3, 9),
(3, 9),
(3, 9),
(3, 9),
(4, 11),
(5, 888);
```

# SQL - запрос
```sql
SELECT
	procs.proc_name 'наименование процедуры', SUM(price) 'суммарная стоимость лотов', SUM(count_pozs) 'суммарное количество позиций'
	FROM
	(SELECT procedure_id, price, (
		SELECT SUM(poz_count)
			FROM pozs
			WHERE pozs.lot_id = L.Id) AS 'count_pozs'
		FROM lots as L) as C
JOIN procs ON procs.id=C.procedure_id
GROUP BY procs.proc_name;
```
