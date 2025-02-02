INSERT INTO Users (user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender)
SELECT DISTINCT p.user_id, p.first_name, p.last_name, p.year_of_birth, p.month_of_birth, p.day_of_birth, p.gender
FROM project1.Public_User_Information p
WHERE NOT EXISTS (
    SELECT 1 FROM Users u WHERE u.user_id = p.user_id
);

INSERT INTO Friends (user1_id, user2_id)
SELECT user1_id, user2_id
FROM project1.Public_Are_Friends;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT DISTINCT current_city, current_state, current_country
FROM project1.Public_User_Information;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT p.hometown_city, p.hometown_state, p.hometown_country
FROM project1.Public_User_Information p
WHERE NOT EXISTS (
    SELECT 1 FROM Cities c WHERE c.city_name = p.city_name AND c.state_name = p.state_name AND c.country_name = p.country_name
)

INSERT INTO User_Current_Cities (user_id, current_city_id)
SELECT DISTINCT u.user_id, c.city_id
FROM project1.Public_User_Information u JOIN Cities c
ON u.current_city = c.city_name AND u.current_state = c.state_name AND u.current_country = c.country_name
WHERE u.current_city IS NOT NULL;

INSERT INTO User_Hometown_Cities (user_id, hometown_city_id)
SELECT DISTINCT u.user_id, c.city_id
FROM project1.Public_User_Information u JOIN Cities c
ON u.hometown_city = c.city_name AND u.hometown_state = c.state_name AND u.hometown_country = c.country_name
WHERE u.current_city IS NOT NULL;

INSERT INTO Programs (institution, concentration, degree)
SELECT DISTINCT institution_name, program_concentration, program_degree
FROM project1.Public_User_Information
WHERE institution_name IS NOT NULL;

INSERT INTO Education (user_id, program_id, program_year)
SELECT DISTINCT u.user_id, p.program_id, u.program_year
FROM project1.Public_User_Information u JOIN Programs p
ON u.institution_name = p.institution AND u.program_concentration = p.concentration AND u.program_degree = p.degree
WHERE NOT EXISTS (
    SELECT 1 FROM Education e WHERE e.user_id = u.user_id AND e.program_id = p.program_id
);

INSERT INTO User_Events (event_id, event_creator_id, event_name, event_tagline, event_description, 
                        event_host, event_type, event_subtype, event_address, event_city_id, event_start_time, 
                        event_end_time)
SELECT DISTINCT e.event_id, e.event_creator_id, e.event_name, e.event_tagline, e.event_description, 
        e.event_host, e.event_type, e.event_subtype, e.event_address, c.city_id, e.event_start_time, 
        e.event_end_time
FROM project1.Public_Event_Information e JOIN Cities c
ON e.event_city = c.city_name AND e.event_state = c.state_name AND e.event_country = c.country_name
WHERE NOT EXISTS (
    SELECT 1 FROM User_Events u WHERE u.event_id = e.event_id
);

SET AUTOCOMMIT OFF;

INSERT INTO Albums (album_id, album_owner_id, album_name, album_created_time, 
                    album_modified_time, album_link, album_visibility, cover_photo_id)
SELECT DISTINCT album_id, owner_id, album_name, album_created_time, 
       album_modified_time, album_link, album_visibility, cover_photo_id
FROM project1.Public_Photo_Information
WHERE NOT EXISTS (
    SELECT 1 FROM Albums WHERE project1.Public_Photo_Information.album_id = Albums.album_id
);

INSERT INTO Photos (photo_id, album_id, photo_caption, photo_created_time,
                   photo_modified_time, photo_link)
SELECT photo_id, album_id, photo_caption, photo_created_time,
       photo_modified_time, photo_link
FROM project1.Public_Photo_Information
;

COMMIT;
SET AUTOCOMMIT ON;

INSERT INTO Tags (tag_photo_id, tag_subject_id, tag_created_time, tag_x, tag_y)
SELECT DISTINCT photo_id, tag_subject_id, tag_created_time, tag_x_coordinate, tag_y_coordinate
FROM project1.Public_Tag_Information
;