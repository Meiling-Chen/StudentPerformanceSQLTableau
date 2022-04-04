SELECT TOP (10) [gender]
      ,[race_ethnicity]
      ,[parental_level_of_education]
      ,[lunch]
      ,[test_preparation_course]
      ,[math_score]
      ,[reading_score]
      ,[writing_score]
  FROM [StudentsPerformance].[dbo].[StudentsPerformance]


--all subjects avg score groupby parental education
select
case when parental_level_of_education like 'master%' then 1
when parental_level_of_education like 'bachelor%' then 2
when parental_level_of_education like 'associate%' then 3
when parental_level_of_education like 'some college%' then 4
when parental_level_of_education like 'some high school%' then 5
else 6 end as RANK,
parental_level_of_education,
gender, 
AVG(math_score) as math_score_avg, avg(reading_score) as reading_score_avg,  avg(writing_score) as writing_score_avg 
from StudentsPerformance
group by parental_level_of_education, gender order by RANK, gender

--Compare male and female performance in subjects
select gender, MIN(math_score) as math_score_min, AVG(math_score) as math_score_avg, MAX(math_score) as math_score_max, 
MIN(reading_score) as reading_score_min, avg(reading_score) as reading_score_avg,  MAX(reading_score) as reading_score_max, 
MIN(writing_score) as writing_score_min, avg(writing_score) as writing_score_avg, MAX(writing_score) as writing_score_max
from StudentsPerformance
GROUP BY gender

--lunch in students performance
select lunch, gender, AVG(math_score) as math_score_avg,
avg(reading_score) as reading_score_avg, 
avg(writing_score) as writing_score_avg
from StudentsPerformance
GROUP BY lunch, gender

--lunch in students performance
select test_preparation_course, gender, AVG(math_score) as math_score_avg,
avg(reading_score) as reading_score_avg, 
avg(writing_score) as writing_score_avg
from StudentsPerformance
GROUP BY test_preparation_course, gender

--PASS rate in subjects

select
format((select count(math_score) math_score_pass
from StudentsPerformance
where math_score > (select AVG(math_score) from StudentsPerformance))/(count(math_score)+0.0), 'P')  math_score_pass,
format((select count(reading_score) reading_score_pass
from StudentsPerformance
where reading_score > (select AVG(reading_score) from StudentsPerformance))/(count(reading_score)+0.0), 'P') reading_score_pass,
format((select count(writing_score) writing_score_pass
from StudentsPerformance
where writing_score > (select AVG(writing_score) from StudentsPerformance))/(count(writing_score)+0.0), 'P') writing_score_pass
from StudentsPerformance