# README
Tables:

Name: Users
Columns: string username, string password_digest, string email, integer code, index [username, code] uniqueness foreign_key friendship sent_by_id, sent_to_id

Name: Events
Columns: integer user_id, string stream_link, datetime scheduled time, string title

Name: Invitees
Columns: integer user_id, integer event_id

Name: Friendships
Columns: bigint sent_to_id, bigint sent_by_id, boolean status, index [sent_by_id, sent_to_id] uniqueness

Name: ReviewTags
Columns: integer review_id, integer tag_id

Name: Reviews
Columns: string media, string content, integer user_id, datetime post_date boolean recommended 

Name: Tags
Columns: string category, string name, 


Associations:
User -> friend_sent
User -> friend_request
User -> friends
User -> pending_requests
User -> received_requests
User -> Reviews
User -> Invitees
Tag -> ReviewTag
Review -> ReviewTag
Review -> Tags through ReviewTags
Event -> Invitees
