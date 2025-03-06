SELECT
  pers1.name AS person_name1,
  pers2.name AS person_name2,
  pers1.address AS common_address
FROM
  person AS pers1
JOIN
  person AS pers2 ON pers1.address = pers2.address
   AND pers1.name < pers2.name
ORDER BY person_name1, person_name2, common_address;