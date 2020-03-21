# Mulit Table

```SQL
select id, title, t_major_course.required 
from t_course c
join t_major_course mc on c.id = mc.course_id
where mc.major_id = 1;
```
