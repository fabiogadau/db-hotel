SQL queries parte due

Sempre utilizzando phpMyAdmin, eseguire le seguenti queries:

- Come si chiamano gli ospiti che hanno fatto più di due prenotazioni?

      SELECT COUNT(`p`.`ospite_id`) AS `tot ospiti`, `p`.`ospite_id`, `o`.`name`, `o`.`lastname`
      FROM `prenotazioni_has_ospiti` AS `p`
      INNER JOIN `ospiti` AS `o`
      ON `p`.`ospite_id` = `o`.`id`
      GROUP BY `p`.`ospite_id`
      HAVING COUNT(`p`.`ospite_id`) > 2;


- Stampare tutti gli ospiti per ogni prenotazione

      SELECT `o`.`id` AS `id ospite`, `o`.`name`, `o`.`lastname`, `p`.`id` AS `id prenotazione`, `p`.`ospite_id` AS `id ospite in prenotazione`
      FROM `ospiti` AS `o`
      INNER JOIN `prenotazioni_has_ospiti` AS `p`
      ON `o`.`id` = `p`.`ospite_id`
      GROUP BY `p`.`id`;


- Stampare Nome, Cognome e Prezzo per tutte le prenotazioni fatte a Maggio 2018

      SELECT `paganti`.`name`, `paganti`.`lastname`, `pagamenti`.`price`, `prenotazioni`.`created_at` AS `data prenotazione`
      FROM `pagamenti`
      INNER JOIN `paganti`
      ON `pagamenti`.`pagante_id` = `paganti`.`id`
      INNER JOIN `prenotazioni`
      ON `pagamenti`.`prenotazione_id` = `prenotazioni`.`id`
      WHERE YEAR(`prenotazioni`.`created_at`) = '2018' AND MONTH(`prenotazioni`.`created_at`) = '05';


- Fai la somma di tutti i prezzi delle prenotazioni per le stanze del primo piano

      SELECT SUM(`pagamenti`.`price`) AS `somma pagamenti`, `stanze`.`floor`, `pagamenti`.`status`
      FROM `prenotazioni`
      INNER JOIN `pagamenti`
      ON `prenotazioni`.`id` = `pagamenti`.`prenotazione_id`
      INNER JOIN `stanze`
      ON `prenotazioni`.`stanza_id` = `stanze`.`id`
      WHERE `stanze`.`floor` = '1'
      AND `pagamenti`.`status` = 'accepted';


- Le stanze sono state tutte prenotate almeno una volta? (Visualizzare le stanze non ancora prenotate)

      SELECT `s`.`id` AS `id stanza non prenotata`, `s`.`room_number` AS `stanza non prenotata`
      FROM `stanze` AS `s`
      LEFT JOIN `prenotazioni` AS `p`
      ON `s`.`id` = `p`.`stanza_id`
      WHERE `p`.`stanza_id` IS NULL;


Bonus: Group by

- Conta gli ospiti raggruppandoli per anno di nascita

      SELECT COUNT(`id`) AS `totale ospiti`, YEAR(`date_of_birth`)
      FROM `ospiti`
      GROUP BY YEAR(`date_of_birth`);


- Somma i prezzi dei pagamenti raggruppandoli per status

      SELECT `status`, SUM(`price`) AS `total`
      FROM `pagamenti`
      GROUP BY `status`;


- Quante prenotazioni ha fatto l’ospite che ha fatto più prenotazioni?

      SELECT `pr`.`ospite_id`,
      `o`.`name`, 
      `o`.`lastname`,
      COUNT(`pr`.`ospite_id`) AS `prenotazioni_ospite`
      FROM `prenotazioni_has_ospiti` AS `pr`
      INNER JOIN `ospiti` AS `o`
      ON `pr`.`ospite_id` = `o`.`id`
      GROUP BY `pr`.`ospite_id`
      ORDER BY `prenotazioni_ospite` DESC
      LIMIT 2;

