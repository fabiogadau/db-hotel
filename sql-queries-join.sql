SQL queries parte due

Sempre utilizzando phpMyAdmin, eseguire le seguenti queries:

Come si chiamano gli ospiti che hanno fatto più di due prenotazioni?

      SELECT COUNT(`p`.`ospite_id`) AS `tot ospiti`, `p`.`ospite_id`, `o`.`name`, `o`.`lastname`
      FROM `prenotazioni_has_ospiti` AS `p`
      INNER JOIN `ospiti` AS `o`
      ON `p`.`ospite_id` = `o`.`id`
      GROUP BY `p`.`ospite_id`
      HAVING COUNT(`p`.`ospite_id`) > 2;


Stampare tutti gli ospiti per ogni prenotazione

      SELECT `o`.`id` AS `id ospite`, `o`.`name`, `o`.`lastname`, `p`.`id` AS `id prenotazione`, `p`.`ospite_id` AS `id ospite in prenotazione`
      FROM `ospiti` AS `o`
      INNER JOIN `prenotazioni_has_ospiti` AS `p`
      ON `o`.`id` = `p`.`ospite_id`
      GROUP BY `p`.`id`;


Stampare Nome, Cognome, Prezzo e Pagante per tutte le prenotazioni fatte a Maggio 2018




Fai la somma di tutti i prezzi delle prenotazioni per le stanze del primo piano




Le stanze sono state tutte prenotate almeno una volta? (Visualizzare le stanze non ancora prenotate)






Bonus: Group by

Conta gli ospiti raggruppandoli per anno di nascita

      SELECT COUNT(*) AS `totale ospiti`, YEAR(`date_of_birth`)
      FROM `ospiti`
      GROUP BY YEAR(`date_of_birth`);


Somma i prezzi dei pagamenti raggruppandoli per status

      SELECT `status`, SUM(`price`) AS `total`
      FROM `pagamenti`
      GROUP BY `status`;


Quante prenotazioni ha fatto l’ospite che ha fatto più prenotazioni?



