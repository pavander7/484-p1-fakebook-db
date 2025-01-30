-- PRAGMA foreign_keys = ON;

CREATE VIEW View_User_Information 
    AS SELECT Users.*,
              Current_Cities.city_name AS current_city_name,
              Current_Cities.state_name AS current_state_name,
              Current_Cities.country_name AS current_country_name,
              Hometown_Cities.city_name AS hometown_city_name,
              Hometown_Cities.state_name AS hometown_state_name,
              Hometown_Cities.country_name AS hometown_country_name,
              Programs.institution AS institution_name,
              Education.program_year,
              Programs.concentration AS program_concentration,
              Programs.degree AS program_degree
        FROM Users
        LEFT JOIN User_Current_Cities ON Users.user_id = User_Current_Cities.user_id
        LEFT JOIN Cities Current_Cities ON User_Current_Cities.current_city_id = Current_Cities.city_id
        LEFT JOIN User_Hometown_Cities ON Users.user_id = User_Hometown_Cities.user_id
        LEFT JOIN Cities Hometown_Cities ON User_Hometown_Cities.hometown_city_id = Hometown_Cities.city_id
        LEFT JOIN Education ON Users.user_id = Education.user_id
        LEFT JOIN Programs ON Education.program_id = Programs.program_id
;

CREATE VIEW View_Are_Friends
    AS SELECT Friends.*
    FROM Friends
;

CREATE VIEW View_Photo_Information
    AS SELECT a.album_id, 
              a.album_owner_id AS owner_id, 
              a.cover_photo_id, 
              a.album_name, a.album_created_time, a.album_modified_time, 
              a.album_link, a.album_visibility, 
              p.photo_id, p.photo_caption,
              p.photo_created_time, p.photo_modified_time, p.photo_link
        FROM Albums a
        LEFT JOIN Photos p ON a.album_id = p.album_id
;

CREATE VIEW View_Event_Information
    AS SELECT User_Events.event_id,
              User_Events.event_creator_id,
              User_Events.event_name,
              User_Events.event_tagline,
              User_Events.event_description,
              User_Events.event_host,
              User_Events.event_type,
              User_Events.event_subtype,
              User_Events.event_address,
              Cities.city_name AS event_city,
              Cities.state_name AS event_state,
              Cities.country_name AS event_country,
              User_Events.event_start_time,
              User_Events.event_end_time
    FROM User_Events
    LEFT JOIN Cities ON User_Events.event_city_id = Cities.city_id
;

CREATE VIEW View_Tag_Information
    AS SELECT *
    FROM Tags
;