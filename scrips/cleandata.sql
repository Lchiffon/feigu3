--create database chiffon
use chiffon;
drop table chiffon__company1;
create table chiffon__company1
as
select a.job_name job_name,
       a.company_name company_name,
       a.webtype,
       a.master,
       a.bachelor,
       a.junior,
       b.high_pay,
       b.medium_pay,
       b.low_pay,
       c.big_city,
       d.hadoop,
       d.spark,
       d.bigdata
from(
    select job_name,
           company_name,
           max(web_type) webtype,
           case when max(edu_type)='B3' then 1 
                else 0 end master,
           case when max(edu_type)='B2' then 1 
                else 0 end bachelor,
            case when max(edu_type)='B1' then 1 
                else 0 end junior
    from feigu3.dim_edu
    group by job_name,company_name
) a
left join(
   select job_name,
           company_name,
           case when max(salary_type)='D3' then 1 
                else 0 end high_pay,
           case when max(salary_type)='D2' then 1 
                else 0 end medium_pay,
            case when max(salary_type)='D1' then 1 
                else 0 end low_pay
    from feigu3.dim_salary
    group by job_name,company_name
) b
on a.job_name=b.job_name 
    and a.company_name=b.company_name  
left join(
    select job_name,
           company_name,
           case when max(joblocation_type)='A9' then 0 
                else 1 end big_city
    from feigu3.dim_joblocation
    group by job_name,company_name
) c
on a.job_name=c.job_name 
    and a.company_name=c.company_name 
left join(
    select job_name,
           company_name,
           case when max(tech_word)='hadoop' then 1 
                else 0 end hadoop,
           case when max(tech_word)='spark' then 1 
                else 0 end spark,
           case when max(tech_word)='大数据' then 1 
                else 0 end bigdata                
    from feigu3.dim_job_techword
    group by job_name,company_name
) d
on a.job_name=d.job_name 
    and a.company_name=d.company_name
;

use chiffon;
drop table chiffon__company2;
create table chiffon__company2
as
select  
       case when job_name like '%携程%' or
            company_name like '%携程%' 
            then '携程'
            when job_name like '%滴滴%' or
            company_name like '%滴滴%' 
            then '滴滴'
            when job_name like '%三快%' or
            company_name like '%三快%' 
            then '三快'
            when job_name like '%去哪%' or
            company_name like '%去哪%' 
            then '去哪' 
            when job_name like '%饿了么%' or
            company_name like '%饿了么%' 
            then '饿了么' 
            when job_name like '%百度%' or
            company_name like '%百度%' 
            then '百度' 
            when job_name like '%同程%' or
            company_name like '%同程%' 
            then '同程'
            when job_name like '%途牛%' or
            company_name like '%途牛%' 
            then '途牛' 
            when job_name like '%五八%' or
            company_name like '%五八%' 
            then '五八' 
            when job_name like '%京东%' or
            company_name like '%京东%' 
            then '京东'
            when job_name like '%拉卡拉%' or
            company_name like '%拉卡拉%' 
            then '拉卡拉'
            when job_name like '%房多多%' or
            company_name like '%房多多%' 
            then '房多多'
            when job_name like '%阿里%' or
            company_name like '%阿里%' 
            then '阿里'
            when job_name like '%河狸家%' or
            company_name like '%河狸家%' 
            then '河狸家'
            when job_name like '%景域%' or
            company_name like '%景域%' 
            then '景域'
            when job_name like '%窝窝%' or
            company_name like '%窝窝%' 
            then '窝窝'
            when job_name like '%欢校%' or
            company_name like '%欢校%' 
            then '欢校'
            when job_name like '%团博百众%' or
            company_name like '%团博百众%' 
            then '团博百众'
            when job_name like '%顺丰%' or
            company_name like '%顺丰%' 
            then '顺丰'
            when job_name like '%快跑%' or
            company_name like '%快跑%' 
            then '快跑'
            when job_name like '%点我吧%' or
            company_name like '%点我吧%' 
            then '点我吧'
            when job_name like '%赛可%' or
            company_name like '%赛可%' 
            then '赛可'
            when job_name like '%百米%' or
            company_name like '%百米%' 
            then '百米'
            else company_name end company_name,
       webtype,
       master,
       bachelor,
       junior,
       high_pay,
       medium_pay,
       low_pay,
       big_city,
       hadoop,
       spark,
       bigdata,
        case when job_name like '%携程%' or
            company_name like '%携程%' 
            then 97.62
            when job_name like '%滴滴%' or
            company_name like '%滴滴%' 
            then 96.4
            when job_name like '%三快%' or
            company_name like '%三快%' 
            then 94.85
            when job_name like '%去哪%' or
            company_name like '%去哪%' 
            then 92.79
            when job_name like '%饿了么%' or
            company_name like '%饿了么%' 
            then 89.77
            when job_name like '%百度%' or
            company_name like '%百度%' 
            then 87.92
            when job_name like '%同程%' or
            company_name like '%同程%' 
            then 87.92
            when job_name like '%途牛%' or
            company_name like '%途牛%' 
            then 87.33
            when job_name like '%五八%' or
            company_name like '%五八%' 
            then 87.16
            when job_name like '%京东%' or
            company_name like '%京东%' 
            then 86.84
            when job_name like '%拉卡拉%' or
            company_name like '%拉卡拉%' 
            then 86.67
            when job_name like '%房多多%' or
            company_name like '%房多多%' 
            then 86.47
            when job_name like '%阿里%' or
            company_name like '%阿里%' 
            then 85.99
            when job_name like '%河狸家%' or
            company_name like '%河狸家%' 
            then 85.77
            when job_name like '%景域%' or
            company_name like '%景域%' 
            then 83.77
            when job_name like '%窝窝%' or
            company_name like '%窝窝%' 
            then 83.17
            when job_name like '%欢校%' or
            company_name like '%欢校%' 
            then 81.97
            when job_name like '%团博百众%' or
            company_name like '%团博百众%' 
            then 80.07
            when job_name like '%顺丰%' or
            company_name like '%顺丰%' 
            then 80.04
            when job_name like '%快跑%' or
            company_name like '%快跑%' 
            then 80
            when job_name like '%点我吧%' or
            company_name like '%点我吧%' 
            then 76.58
            when job_name like '%赛可%' or
            company_name like '%赛可%' 
            then 76.47
            when job_name like '%百米%' or
            company_name like '%百米%' 
            then 74.48
            else 0 end score
from chiffon.chiffon__company1
;







use chiffon;
drop table chiffon__company3;
create table chiffon__company3
as
select  company_name,
       max(big_city) big_city,
       count(*) postion_num,
       sum(spark) spark,
       sum(hadoop) hadoop,
       sum(bigdata) bigdata,
       sum(spark)/count(*) spark_ratio,
       sum(hadoop)/count(*) hadoop_ratio,
       sum(bigdata)/count(*) bigdata_ratio,
       sum(high_pay) high_pay,
       sum(medium_pay) medium_pay,
       sum(low_pay) low_pay,
       sum(master)/count(*) master,
       sum(bachelor)/count(*) bachelor,
       sum(junior)/count(*) junior,
       max(score) score
from chiffon__company2
group by company_name;