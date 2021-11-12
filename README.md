# SQL Murder Mystery 🕵️‍♂️

created by [Joon Park](https://twitter.com/joonparkmusic) and [Cathy He](https://twitter.com/Cathy_MeiyingHe) while they were Knight Lab fellows

<br>

## Summary

There's been a Murder in SQL City! The SQL Murder Mystery is designed to be both a self-directed lesson to learn SQL concepts and commands and a fun game for experienced SQL users to solve an intriguing crime.                


<br>

## Table names and schemas

The SQL Murder Mystery game has 9 tables, and one of them is used to check the challenge solution (table solution).



**Tables list**

| name                   |
| ---------------------- |
| crime_scene_report     |
| drivers_license        |
| person                 |
| facebook_event_checkin |
| interview              |
| get_fit_now_member     |
| get_fit_now_check_in   |
| income                 |
| solution               |



**Table schemas**

| sql                                                          |
| ------------------------------------------------------------ |
| CREATE TABLE crime_scene_report (        date integer,        type text,        description text,        city text    ) |
| CREATE TABLE drivers_license (        id integer PRIMARY KEY,        age integer,        height integer,        eye_color text,        hair_color text,        gender text,        plate_number text,        car_make text,        car_model text    ) |
| CREATE TABLE person (        id integer PRIMARY KEY,        name text,        license_id integer,        address_number integer,        address_street_name text,        ssn integer,        FOREIGN KEY (license_id) REFERENCES drivers_license(id)    ) |
| CREATE TABLE facebook_event_checkin (        person_id integer,        event_id integer,        event_name text,        date integer,        FOREIGN KEY (person_id) REFERENCES person(id)    ) |
| CREATE TABLE interview (        person_id integer,        transcript text,        FOREIGN KEY (person_id) REFERENCES person(id)    ) |
| CREATE TABLE get_fit_now_member (        id text PRIMARY KEY,        person_id integer,        name text,        membership_start_date integer,        membership_status text,        FOREIGN KEY (person_id) REFERENCES person(id)    ) |
| CREATE TABLE get_fit_now_check_in (        membership_id text,        check_in_date integer,        check_in_time integer,        check_out_time integer,        FOREIGN KEY (membership_id) REFERENCES get_fit_now_member(id)    ) |
| CREATE TABLE income (        ssn integer PRIMARY KEY,        annual_income integer    ) |


<br>

## 🧐 The murder mystery

A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a **murder** that occurred sometime on **Jan.15, 2018** and that it took place in **SQL City**. Start by retrieving the corresponding crime scene report from the police department’s database.


<br>

## 🔎 The investigation

***In a cold day in SQL City...***

🕵️‍♂️ I lost the crime scene reports that the detective gave me... I need to solve this mystery, whatever it takes.


<br>

**Recovering the murder report description**

🕵️‍♂️ The murder occurred on Jan.15, 2018 in SQL City. Was there any crime scene reports with that characteristics?



````sql
SELECT
	description
FROM
	crime_scene_report
WHERE
	date = 20180115
	AND city = "SQL City"
	AND type = "murder";
````



***Output***

| description                                                  |
| ------------------------------------------------------------ |
| Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave". |



🕵️‍♂️ Interesting... 🤔 I should check the witnesses interviews to find out what they saw in the crime scene, but first, I need to find out who the witnesses are exactly.

<br>

**Who are the witnesses?**

- First witness

````sql
SELECT
	id
	,name
FROM
	person
WHERE
	address_street_name = "Northwestern Dr"
ORDER BY
	address_number DESC
LIMIT
	1;
````

***Output***

| id    | name           |
| ----- | -------------- |
| 14887 | Morty Schapiro |



- Second witness

````sql
SELECT
	id
	,name
FROM
	person
WHERE
	name LIKE "%Annabel%"
	AND address_street_name = "Franklin Ave";
````

***Output***

| id    | name           |
| ----- | -------------- |
| 16371 | Annabel Miller |



Bingo! Morty Shapiro and Annabel Miller!


<br>

**The interviews**

I'm advancing in the mystery. I found out who both witness are, now I have to see what did they say to the police.

````sql
SELECT
	transcript
FROM
	interview
WHERE
	person_id = 14887
	OR person_id = 16371;
````

<br>

***Searching...***

🕵️‍♂️ That's it! The two interviews I need.



👤 I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym"  bag. The membership number on the bag started with "48Z". Only gold  members have those bags. The man got into a car with a plate that  included "H42W".

👤 I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.



🕵️‍♂️ Great, now I know a lot to find the murderer.


***Investigation Notes***

- It's a man
- He's a gold member of Get Fit Now gym
- His member ID starts with 48Z
- He was at the gym on Jan. 19, 2018
- He got into a car with the plate that included "H42W"



I need to find someone that matches with all this descriptions and get him to a Police Department to an interview.

<br>

**Finding and interviewing the murderer**

````sql
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
	AND gci.check_in_date = 20180109
	AND d.gender = "male";
````



🕵️‍♂️ It's Jeremy Bowers! I need him to confess.


<br>

***In the interview room***

🕵️‍♂️ Hello, Jeremy! We have two witnesses who saw you in the crime scene. You can't hide it anymore. Tell us the truth!

🤐 ...

***Jeremy do not say a word. I need to be tough with him***

😡 Spit it out, Jeremy! I'm not here to play!

😧 ok, ok! I'll tell you



I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.



🕵️‍♂️ See? Wasn't that hard, was it Jeremy?


<br>

**The mastermind**

🕵️‍♂️ There's a mastermind behind this crime. Jeremy was just a pawn in their game.




***Investigation Notes***

**The mastermind:**

- It's a woman
- Rich
- Around 65" or 67"
- Red hair
- Drives a Tesla Model S
- Attended the SQL Symphony Concert 3 times in Dec 2017



````sql
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
````

<br>

***The next morning...***

🕵️‍♂️ I didn't sleep that night, looking all this papers and trying to find the mastermind and I wasn't able to get the concert attendees data.

🕵️‍♂️ Wait... What if I check the attendees on Facebook?

🕵️‍♂️ No way! The only person that matches with all the characteristics Jeremy told me is...

**Miranda Priestly**



***The police stations send the cops immediately to Miranda's house***

***I watch the situation from across the street, and there's Miranda walking out in handcuffs.***



🕵️‍♂️ It's a pleasure to solve another mystery in SQL City.

<br>

## Challenge website

[The SQL Murder Mystery](https://mystery.knightlab.com/)



The SQL Murder Mystery was created by [Joon Park](https://twitter.com/joonparkmusic) and [Cathy He](https://twitter.com/Cathy_MeiyingHe) while they were Knight Lab fellows.

See the [GitHub repository](https://github.com/NUKnightLab/sql-mysteries) for more information.

Adapted and produced for the web by [Joe Germuska](https://twitter.com/joegermuska).

 

