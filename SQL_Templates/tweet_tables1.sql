CREATE TABLE tweet_info AS SELECT
tweet_json ->> 'id_str' AS tweetID, 
tweet_json ->> 'created_at' AS Created_At, 
tweet_json ->> 'text' AS Tweet_Text, 
tweet_json -> 'extended_tweet' ->> 'full_text' AS Extended_Text,
tweet_json ->> 'truncated' AS truncated, 
tweet_json ->> 'quote_count' AS Quotes,
tweet_json ->> 'reply_count' AS Replies,
tweet_json ->> 'retweet_count' AS Retweets,
tweet_json ->> 'favorite_count' AS Liked,
tweet_json ->> 'lang' AS Language
FROM tweets;

CREATE TABLE user_info AS SELECT 
tweet_json ->> 'id_str' AS tweetID, 
tweet_json -> 'user' ->> 'name' AS Name,
tweet_json -> 'user' ->> 'screen_name' AS Handle,
tweet_json -> 'user' ->> 'location' AS Location,
tweet_json -> 'user' ->> 'url' AS URL,
tweet_json -> 'user' ->> 'description' AS Bio,
tweet_json -> 'user' ->> 'verified' AS Verified_Status,
tweet_json -> 'user' ->> 'followers_count' AS Followers,
tweet_json -> 'user' ->> 'friends_count' AS Following,
tweet_json -> 'user' ->> 'profile_image_url_https' AS Profile_Image
FROM tweets;

CREATE TABLE locations_query AS SELECT
tweet_json ->> 'id_str' AS tweetID,
jsonb_array_elements(tweet_json -> 'user' -> 'derived' -> 'locations') AS location_json
FROM tweets;

CREATE TABLE hashtags_query AS SELECT
tweet_json ->> 'id_str' AS tweetID,
jsonb_array_elements(tweet_json -> 'extended_tweet' -> 'entities' -> 'hashtags') AS hashtags_json
FROM tweets;

CREATE TABLE entities_query AS SELECT
tweet_json ->> 'id_str' AS tweetID,
jsonb_array_elements(tweet_json -> 'extended_tweet' -> 'entities' -> 'annotations' -> 'context') AS annotations_json
FROM tweets;

CREATE TABLE location_info AS SELECT
tweetID,
location_json ->> 'country' AS country,
location_json ->> 'country_code' AS country_code,
location_json ->> 'region' AS region
FROM locations_query;

CREATE TABLE hashtag_info AS SELECT
tweetID,
hashtags_json ->> 'text' AS hashtag
FROM hashtags_query;

CREATE TABLE annotations_info AS SELECT
tweetID,
annotations_json ->> 'context_entity_name' AS entity_name
FROM entities_query;

CREATE TABLE tweet_info AS SELECT
tweet_json ->> 'id_str' AS tweetID, 
tweet_json ->> 'created_at' AS Created_At, 
tweet_json ->> 'text' AS Tweet_Text, 
tweet_json -> 'extended_tweet' ->> 'full_text' AS Extended_Text,
tweet_json ->> 'truncated' AS truncated, 
tweet_json ->> 'quote_count' AS Quotes,
tweet_json ->> 'reply_count' AS Replies,
tweet_json ->> 'retweet_count' AS Retweets,
tweet_json ->> 'favorite_count' AS Liked,
tweet_json ->> 'lang' AS Language
FROM tweets;

CREATE TABLE user_info AS SELECT 
tweet_json ->> 'id_str' AS tweetID, 
tweet_json -> 'user' ->> 'name' AS Name,
tweet_json -> 'user' ->> 'screen_name' AS Handle,
tweet_json -> 'user' ->> 'location' AS Location,
tweet_json -> 'user' ->> 'url' AS URL,
tweet_json -> 'user' ->> 'description' AS Bio,
tweet_json -> 'user' ->> 'verified' AS Verified_Status,
tweet_json -> 'user' ->> 'followers_count' AS Followers,
tweet_json -> 'user' ->> 'friends_count' AS Following,
tweet_json -> 'user' ->> 'profile_image_url_https' AS Profile_Image
FROM tweets;

CREATE TABLE locations_query AS SELECT
tweet_json ->> 'id_str' AS tweetID,
jsonb_array_elements(tweet_json -> 'user' -> 'derived' -> 'locations') AS location_json
FROM tweets;

CREATE TABLE hashtags_query AS SELECT
tweet_json ->> 'id_str' AS tweetID,
jsonb_array_elements(tweet_json -> 'extended_tweet' -> 'entities' -> 'hashtags') AS hashtags_json
FROM tweets;

CREATE TABLE entities_query AS SELECT
tweet_json ->> 'id_str' AS tweetID,
jsonb_array_elements(tweet_json -> 'extended_tweet' -> 'entities' -> 'annotations' -> 'context') AS annotations_json
FROM tweets;

CREATE TABLE location_info AS SELECT
tweetID,
location_json ->> 'country' AS country,
location_json ->> 'country_code' AS country_code,
location_json ->> 'region' AS region
FROM locations_query;

CREATE TABLE hashtag_info AS SELECT
tweetID,
hashtags_json ->> 'text' AS hashtag
FROM hashtags_query;

CREATE TABLE annotations_info AS SELECT
tweetID,
annotations_json ->> 'context_entity_name' AS entity_name
FROM entities_query;