create database healthcare_data
select * from healthcare_providers
-- DUPLICATE ID'S
SELECT provider_id,count(*) as Duplicate_ID FROM healthcare_providers
group by provider_id
having COUNT(*)>1
-- MISSING  PROVIDER NAMES
select * from healthcare_providers
where provider_name is null
-- DUPLICATE PROVIDER NAMES
SELECT provider_name,count(*) as Duplicate_Names FROM healthcare_providers
group by provider_name
having COUNT(*)>1
-- INCONSISTENT SPECIALITIES
select distinct phone from healthcare_providers
order by phone
-- MISSING PHONE NUMBERS
select * from healthcare_providers
where phone is null
-- INCONSISTENT PHONE NUMBERS
select distinct specialty from healthcare_providers
order by specialty
-- MISSING EMAIL ADDRESS
select * from healthcare_providers
where email is null
-- INVALID EMAIL ADDRESS
select * from healthcare_providers
where email not like '%_@_%._%'
-- INVALID FACILITY REFERENCES
select distinct facility_id from healthcare_providers
order by facility_id
-- INVALID POSTAL CODE
select distinct postal_code from healthcare_providers
order by postal_code
-- INCONSISTENT STATUS VALUES
select distinct provider_status from healthcare_providers
order by provider_status
-- DATA CLEANING
-- SPECIALTY
update healthcare_providers 
set specialty = upper(left(trim(specialty),1)) + lower(substring(trim(specialty),2,
len(trim(specialty))))
-- PHONE NUMBERS
update healthcare_providers
set phone = 'INVALID'
where  phone is not null
and (
      len(trim(phone)) <> 10
      or trim(phone) like '%[^0-9]%'
    )