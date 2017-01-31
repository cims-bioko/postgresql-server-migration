create or replace view v_individual_max_residency as select distinct on (individual_uuid) individual_uuid, uuid from residency where not deleted order by individual_uuid, startDate desc;
create or replace view v_individual_sync as select i.uuid as uuid, to_char(i.dob,'YYYY-MM-DD') as dob, i.extId as extId, i.father_uuid as father, case i.firstName when 'null' then null else i.firstName end as firstName, i.gender as gender, case i.lastName when 'null' then null else i.lastName end as lastName, i.mother_uuid as mother, rl.uuid as currentResidence, r.endType as endType, case i.middleName when 'null' then null else i.middleName end as otherNames, i.age as age, i.ageUnits as ageUnits, case i.phoneNumber when 'null' then null else i.phoneNumber end as phoneNumber, case i.otherPhoneNumber when 'null' then null else i.otherPhoneNumber end as otherPhoneNumber, case i.pointOfContactName when 'null' then null else i.pointOfContactName end as pointOfContactName, case i.pointOfContactPhoneNumber when 'null' then null else i.pointOfContactPhoneNumber end as pointOfContactPhoneNumber, i.languagePreference as languagePreference, case i.memberStatus when 'null' then null else i.memberStatus end as memberStatus, case i.nationality when 'null' then null else i.nationality end as nationality, case i.dip when 0 then null else i.dip end as otherId from individual i left join v_individual_max_residency mr on i.uuid = mr.individual_uuid left join residency r on mr.uuid = r.uuid left join location rl on r.location_uuid = rl.uuid where not i.deleted and i.extId <> 'UNK' and r.uuid is not null;
create or replace view v_fieldworker_sync as select uuid, extId, idPrefix, firstName, lastName, passwordHash as password from fieldworker where not deleted and extId <> 'UNK';
create or replace view v_locationhierarchy_sync as select lh.uuid, lh.extId, lh.name, l.name as level, lh.parent_uuid as parent from locationhierarchy lh join locationhierarchylevel l on lh.level_uuid = l.uuid;
create or replace view v_location_sync as select l.uuid, l.extId, locationHierarchy_uuid as hierarchyUuid, lh.extId as hierarchyExtId, case locationName when 'null' then 'Unnamed' else locationName end as name, description, communityName, communityCode, localityName, mapAreaName, sectorName, buildingNumber, floorNumber, case latitude when 'null' then null else latitude end as latitude, case longitude when 'null' then null else longitude end as longitude from location l join locationhierarchy lh on l.locationHierarchy_uuid = lh.uuid where not l.deleted;
create or replace view v_membership_sync as select uuid, individual_uuid, bIsToA as relationshipToHead, socialGroup_uuid from membership where not deleted;
create or replace view v_relationship_sync as select uuid, individualA_uuid as individualA, individualB_uuid as individualB, aIsToB as relationshipType, to_char(startDate,'YYYY-MM-DD') as startDate from relationship where not deleted;
create or replace view v_socialgroup_sync as select uuid, groupHead_uuid, location_uuid, groupName from socialgroup where not deleted and location_uuid is not null;
create or replace view v_visit_sync as select uuid, extId, visitLocation_uuid as location_uuid, to_char(visitDate,'YYYY-MM-DD') as date, collectedBy_uuid as fieldworkerUuid, roundNumber as round from visit where not deleted;
