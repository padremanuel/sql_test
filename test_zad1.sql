/*Тестовое задание
1. Есть 3 связанных таблицы:
Процедуры (id, наименование)
Лоты (Id, procedure_id [ссылка на таблицу процедуры], Стоимость)
Позиции (Id, lot_id [ссылка на таблицу лоты], Количество)
Надо написать корректно работающий SQL-запрос,
который бы выводил наименование процедуры, суммарную стоимость лотов, суммарное количество позиций.
*/

/*таблица процедуры*/
CREATE TABLE IF NOT EXISTS procs (
  proc_id int(11) NOT NULL AUTO_INCREMENT,
  proc_name varchar(60) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (proc_id)
);

/*таблица лоты*/
CREATE TABLE IF NOT EXISTS lots (
  lot_id int(11) NOT NULL AUTO_INCREMENT,
  proc_id int(11) NOT NULL REFERENCES procs(proc_id),
  price double NOT NULL,
  PRIMARY KEY (lot_id)
);

/*таблица позиции*/
CREATE TABLE IF NOT EXISTS pozs (
  poz_id int(11) NOT NULL AUTO_INCREMENT,
  lot_id int(11) NOT NULL REFERENCES lots(lot_id),
  poz_count int(11) NOT NULL,
  PRIMARY KEY (poz_id)
);

/*заполнение процедур*/
INSERT INTO procs (proc_name) VALUES 
('cleaning'),
('promotion'),
('Поддержка')
;

/*заполнение лотов*/
INSERT INTO lots (proc_id, price) VALUES
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

/*ответ*/
SELECT
	procs.proc_name 'наименование процедуры', SUM(price) 'суммарная стоимость лотов', SUM(count_pozs) 'суммарное количество позиций'
	FROM
	(SELECT proc_id, price, (
		SELECT SUM(poz_count)
			FROM pozs
			WHERE pozs.lot_id = L.lot_id) AS 'count_pozs'
		FROM lots as L) as C
JOIN procs ON procs.proc_id=C.proc_id
GROUP BY procs.proc_name;