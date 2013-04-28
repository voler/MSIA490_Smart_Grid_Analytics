Q1:
select nb.name, count(strt.name)
from nyc_neighborhoods as nb, nyc_streets as strt
where ST_Contains(nb.geom,strt.geom)
Group by nb.name;

Q2:
select blk.boroname, count(substn.name) as NumofSubStations
from nyc_census_blocks as blk, nyc_subway_stations as substn
where ST_Within(substn.geom,blk.geom)
Group by blk.boroname;

Q3:
select
  socio.tractid,
	sum(socio.edu_graduate_dipl)+sum(socio.edu_college_dipl) as NumofCollegediploma
from  nyc_census_sociodata as socio
Group by socio.tractid
Order by NumofCollegediploma desc
Limit 1;

Q4:
SELECT substn.name, substn.cross_st, ST_Distance(substn.geom,nb.geom) as Distance
FROM nyc_subway_stations as substn, nyc_neighborhoods as nb
WHERE substn.borough != 'Manhattan' and nb.boroname = 'Manhattan'
Order by ST_Distance(substn.geom, nb.geom)
limit 1;

Q5:
select
	blk1.blkid as blockfrom,
	blk2.blkid as adjacentblock
from 
	nyc_census_blocks as blk1
	join nyc_census_blocks as blk2
on	blk1.blkid != blk2.blkid
and 	ST_Distance(blk1.geom, blk2.geom) <= 1;
