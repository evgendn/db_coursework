-- роли для всего кластера бд, не для конкретной бд!
-- createuser это обертка для приведенной выше команды.

drop role admin;
drop role driver;
drop role cc_agent;

create role admin login;
create role driver login;
create role cc_agent login;


grant all on all tables in schema public to admin;

grant select on driver to driver;
grant select on cab_ride to driver;
grant select on shift to driver;
grant execute on function top_3_workers() to driver;

grant select on cab_ride to cc_agent;
grant select on status to cc_agent;
grant select on cab_ride_status to cc_agent;

grant execute on function top_3_workers() to cc_agent;
grant execute on function get_cancel_ratio() to cc_agent; 
revoke execute on function get_full_information(name varchar) from cc_agent;

-- Для проверки
-- Установите пароль для user_name:
-- \password user_name
-- psql -U user_name -d database_name -h 127.0.0.1 -W

-- login    password
-- admin    admin
-- driver   driver
-- cc_agent cc_agent