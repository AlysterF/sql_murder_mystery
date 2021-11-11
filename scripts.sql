--SQLite used directly in the challenge website (https://mystery.knightlab.com/)

--Recover the crime scene report

SELECT
	*
FROM
	crime_scene_report
WHERE
	date = 20180115
	AND city = "SQL City"
	AND type = "murder";



--Finding the first witness

SELECT
	*
FROM
	person
WHERE
	address_street_name = "Northwestern Dr"
ORDER BY
	address_number DESC
LIMIT
	1;


--Finding the second witness

SELECT
	*
FROM
	person
WHERE
	name LIKE "%Annabel%"
	AND address_street_name = "Franklin Ave";


--Interview with the witnesses

SELECT
	*
FROM
	interview
WHERE
	person_id = 14887
	OR person_id = 16371;



--Find the main suspect and see what he has to say about the crime

SELECT
	gm.person_id
	,gm.name
	,i.transcript
FROM
	get_fit_now_member gm
JOIN
	get_fit_now_check_in gci
	ON gci.membership_id = gm.id
JOIN
	person p
	ON p.id = gm.person_id
JOIN
	drivers_license d
	ON d.id = p.license_id
JOIN
	interview i
	ON i.person_id = gm.person_id
WHERE
	gm.id LIKE "48Z%"
	AND gm.membership_status = "gold"
	AND gci.check_in_date = 20180109;



--Find the mastermind of the crime

SELECT
	p.name
	,ic.annual_income
	,COUNT(*) AS times_attended_event
FROM
	drivers_license dl
JOIN
	person p
	ON p.license_id = dl.id
JOIN
	facebook_event_checkin fb
	ON fb.person_id = p.id
JOIN
	income ic
	ON ic.ssn = p.ssn
WHERE
	car_make = "Tesla"
	AND car_model = "Model S"
	AND hair_color = "red"
	AND gender = "female"
	AND height BETWEEN 65 AND 67
	AND fb.event_name = "SQL Symphony Concert"
	AND fb.date BETWEEN 20171201 AND 20171231
GROUP BY
	p.name;