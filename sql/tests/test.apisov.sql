delete from api_sov;

select *
from apiloadsov('<?xml version=''1.0'' encoding=''UTF-8''?>
<eveapi version="2">
  <currentTime>2009-02-01 04:00:00</currentTime>
  <result>
    <rowset name="solarSystems" key="solarSystemID" columns="solarSystemID,allianceID,constellationSovereignty,sovereigntyLevel,factionID,solarSystemName">
      <row solarSystemID="30004450" allianceID="824518128" constellationSovereignty="824518128" sovereigntyLevel="4" factionID="0" solarSystemName="AZN-D2" />
      <row solarSystemID="30004451" allianceID="824518128" constellationSovereignty="824518128" sovereigntyLevel="3" factionID="0" solarSystemName="E-PR0S" />
      <row solarSystemID="30000142" allianceID="0" constellationSovereignty="0" sovereigntyLevel="0" factionID="500001" solarSystemName="Jita" />
      <row solarSystemID="30004009" allianceID="1762812782" constellationSovereignty="0" sovereigntyLevel="1" factionID="0" solarSystemName="49-U6U" />
      <row solarSystemID="30004712" allianceID="1762812782" constellationSovereignty="0" sovereigntyLevel="1" factionID="0" solarSystemName="NOL-M9" />
    </rowset>
    <dataTime>2009-02-01 02:00:00</dataTime>
  </result>
  <cachedUntil>2009-02-08 03:26:20</cachedUntil>
</eveapi>
'::text)
as t(id bigint, solarsystemid int, allianceid int, const_sov int, sov_level smallint, factionid int, entrydate timestamp);

select * from api_sov_recent;



-- identical, for good measure, sans NOL
select *
from apiloadsov('<?xml version=''1.0'' encoding=''UTF-8''?>
<eveapi version="2">
  <currentTime>2009-02-02 04:00:00</currentTime>
  <result>
    <rowset name="solarSystems" key="solarSystemID" columns="solarSystemID,allianceID,constellationSovereignty,sovereigntyLevel,factionID,solarSystemName">
      <row solarSystemID="30004450" allianceID="824518128" constellationSovereignty="824518128" sovereigntyLevel="4" factionID="0" solarSystemName="AZN-D2" />
      <row solarSystemID="30004451" allianceID="824518128" constellationSovereignty="824518128" sovereigntyLevel="3" factionID="0" solarSystemName="E-PR0S" />
      <row solarSystemID="30000142" allianceID="0" constellationSovereignty="0" sovereigntyLevel="0" factionID="500001" solarSystemName="Jita" />
      <row solarSystemID="30004009" allianceID="1762812782" constellationSovereignty="0" sovereigntyLevel="1" factionID="0" solarSystemName="49-U6U" />
    </rowset>
    <dataTime>2009-02-02 02:00:00</dataTime>
  </result>
  <cachedUntil>2009-02-08 03:26:20</cachedUntil>
</eveapi>
')
as t(id bigint, solarsystemid int, allianceid int, const_sov int, sov_level smallint, factionid int, entrydate timestamp);

select * from api_sov_recent;



-- azn and 49 change, still no nol
select *
from apiloadsov('<?xml version=''1.0'' encoding=''UTF-8''?>
<eveapi version="2">
  <currentTime>2009-02-03 04:00:00</currentTime>
  <result>
    <rowset name="solarSystems" key="solarSystemID" columns="solarSystemID,allianceID,constellationSovereignty,sovereigntyLevel,factionID,solarSystemName">
      <row solarSystemID="30004450" allianceID="824518128" constellationSovereignty="824518128" sovereigntyLevel="3" factionID="0" solarSystemName="AZN-D2" />
      <row solarSystemID="30004451" allianceID="824518128" constellationSovereignty="824518128" sovereigntyLevel="3" factionID="0" solarSystemName="E-PR0S" />
      <row solarSystemID="30000142" allianceID="0" constellationSovereignty="0" sovereigntyLevel="0" factionID="500001" solarSystemName="Jita" />
      <row solarSystemID="30004009" allianceID="0" constellationSovereignty="0" sovereigntyLevel="0" factionID="0" solarSystemName="49-U6U" />
    </rowset>
    <dataTime>2009-02-03 02:00:00</dataTime>
  </result>
  <cachedUntil>2009-02-08 03:26:20</cachedUntil>
</eveapi>
')
as t(id bigint, solarsystemid int, allianceid int, const_sov int, sov_level smallint, factionid int, entrydate timestamp);

select * from api_sov_recent;



select *
from apiloadsov('<?xml version=''1.0'' encoding=''UTF-8''?>
<eveapi version="2">
  <currentTime>2009-02-04 04:00:00</currentTime>
  <result>
    <rowset name="solarSystems" key="solarSystemID" columns="solarSystemID,allianceID,constellationSovereignty,sovereigntyLevel,factionID,solarSystemName">
      <row solarSystemID="30004450" allianceID="824518128" constellationSovereignty="824518128" sovereigntyLevel="4" factionID="0" solarSystemName="AZN-D2" />
      <row solarSystemID="30004451" allianceID="824518128" constellationSovereignty="824518128" sovereigntyLevel="3" factionID="0" solarSystemName="E-PR0S" />
      <row solarSystemID="30000142" allianceID="0" constellationSovereignty="0" sovereigntyLevel="0" factionID="500001" solarSystemName="Jita" />
      <row solarSystemID="30004009" allianceID="1762812782" constellationSovereignty="0" sovereigntyLevel="1" factionID="0" solarSystemName="49-U6U" />
      <row solarSystemID="30004712" allianceID="1762812782" constellationSovereignty="0" sovereigntyLevel="1" factionID="0" solarSystemName="NOL-M9" />
    </rowset>
    <dataTime>2009-02-04 02:00:00</dataTime>
  </result>
  <cachedUntil>2009-02-08 03:26:20</cachedUntil>
</eveapi>
')
as t(id bigint, solarsystemid int, allianceid int, const_sov int, sov_level smallint, factionid int, entrydate timestamp);

select * from api_sov_recent;


