USE extras;
CREATE TABLE Dog(
            id integer,
            owner_id integer,
            name text,
            breed text,
            age integer);
INSERT INTO Dog
VALUES
( 1  ,  4  ,  "Lola"  ,  "Husky"  ,  6 )  ,  
( 2  ,  3  ,  "Molly"  ,  "Husky"  ,  4 )  ,  
( 3  ,  3  ,  "Lucy"  ,  "Husky"  ,  9 )  ,  
( 4  ,  1  ,  "Bella"  ,  "Beagle"  ,  3 )  ,  
( 5  ,  1  ,  "Sophie"  ,  "Beagle"  ,  2 )  ,  
( 6  ,  2  ,  "Sadie"  ,  "Labrador"  ,  3 )  ,  
( 7  ,  2  ,  "Chloe"  ,  "Labrador"  ,  7 )  ,  
( 8  ,  2  ,  "Bailey"  ,  "Labrador"  ,  1 )  ,  
( 9  ,  4  ,  "Dasy"  ,  "Bulldog"  ,  1 )  ,  
( 10  ,  2  ,  "Max"  ,  "Bulldog"  ,  2 )  ,  
( 11  ,  5  ,  "Charlie"  ,  "Bulldog"  ,  2 )  ,  
( 12  ,  4  ,  "Buddy"  ,  "Husky"  ,  10 )  ,  
( 13  ,  1  ,  "Rocky"  ,  "Husky"  ,  9 )  ,  
( 14  ,  2  ,  "Jake"  ,  "Husky"  ,  8 )  ,  
( 15  ,  4  ,  "Jack"  ,  "Beagle"  ,  6 )  ,  
( 16  ,  3  ,  "Toby"  ,  "Labrador"  ,  5 )  ,  
( 17  ,  4  ,  "Cody"  ,  "Beagle"  ,  8 )  ,  
( 18  ,  4  ,  "Buster"  ,  "Labrador"  ,  7 )  ;

CREATE TABLE Person(
                   id integer,
                   first_name text,
                   last_name text,
                   age integer);
                   
INSERT INTO Person
VALUES
( 1  ,  "Dallas"  ,  "Mills"  ,  "47" )  ,  
( 2  ,  "Derek"  ,  "Black"  ,  "35" )  ,  
( 3  ,  "Eduardo"  ,  "Clarke"  ,  "24" )  ,  
( 4  ,  "Clayton"  ,  "Stone"  ,  "47" )  ,  
( 5  ,  "Kelly"  ,  "Owen"  ,  "44" )  ;

# No. of dogs per owner
SELECT
p.id as Dog_Owner_Id,
concat(p.first_name," ",p.last_name) as "Owner's_name",
COUNT(d.id) as Number_of_dogs_Owned
FROM Person p
LEFT JOIN dog d
ON p.id=d.owner_id
GROUP BY 1;

# No. of dogs per owner using window functions
SELECT
DISTINCT(p.id) as dog_owner_id,
concat(p.first_name," ",p.last_name) as "Owner's_name",
COUNT(*) OVER(partition by d.owner_id) AS number_of_dogs
FROM dog d, person p
WHERE p.id=d.owner_id;
