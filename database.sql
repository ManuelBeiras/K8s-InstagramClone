BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"first_name"	varchar(30) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"last_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "directmessages_message" (
	"id"	integer NOT NULL,
	"content"	varchar(2200) NOT NULL,
	"date_created"	datetime NOT NULL,
	"receiver_id"	integer NOT NULL,
	"sender_id"	integer NOT NULL,
	FOREIGN KEY("receiver_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("sender_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "homepage_postimage" (
	"id"	integer NOT NULL,
	"post_id"	integer NOT NULL,
	"modelimage"	varchar(100) NOT NULL,
	FOREIGN KEY("post_id") REFERENCES "homepage_post"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "homepage_post" (
	"id"	integer NOT NULL,
	"caption"	varchar(2200) NOT NULL,
	"date_posted"	datetime NOT NULL,
	"author_id"	integer NOT NULL,
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "homepage_comment" (
	"id"	integer NOT NULL,
	"post_id"	integer NOT NULL,
	"author_id"	integer NOT NULL,
	"date_created"	datetime NOT NULL,
	"content"	varchar(500) NOT NULL,
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("post_id") REFERENCES "homepage_post"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "homepage_like" (
	"id"	integer NOT NULL,
	"liker_id"	integer NOT NULL,
	"date_created"	datetime NOT NULL,
	"post_id"	integer NOT NULL,
	FOREIGN KEY("post_id") REFERENCES "homepage_post"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("liker_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "notifications_notification" (
	"id"	integer NOT NULL,
	"level"	varchar(20) NOT NULL,
	"actor_object_id"	varchar(255) NOT NULL,
	"verb"	varchar(255) NOT NULL,
	"description"	text,
	"target_object_id"	varchar(255),
	"action_object_object_id"	varchar(255),
	"timestamp"	datetime NOT NULL,
	"public"	bool NOT NULL,
	"action_object_content_type_id"	integer,
	"actor_content_type_id"	integer NOT NULL,
	"recipient_id"	integer NOT NULL,
	"target_content_type_id"	integer,
	"deleted"	bool NOT NULL,
	"emailed"	bool NOT NULL,
	"data"	text,
	"unread"	bool NOT NULL,
	FOREIGN KEY("recipient_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("target_content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("actor_content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("action_object_content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "users_profile" (
	"id"	integer NOT NULL,
	"image"	varchar(100) NOT NULL,
	"bio"	varchar(150) NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	"first_name"	varchar(30) NOT NULL,
	"last_name"	varchar(30) NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "users_follower" (
	"id"	integer NOT NULL,
	"date_followed"	datetime NOT NULL,
	"follower_id"	integer NOT NULL,
	"being_followed_id"	integer NOT NULL,
	FOREIGN KEY("being_followed_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("follower_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "directmessages_message_receiver_id_0b2dd270" ON "directmessages_message" (
	"receiver_id"
);
CREATE INDEX IF NOT EXISTS "directmessages_message_sender_id_5eeeffb9" ON "directmessages_message" (
	"sender_id"
);
CREATE INDEX IF NOT EXISTS "homepage_postimage_post_id_e36fd3c7" ON "homepage_postimage" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "homepage_post_author_id_0d5abdb6" ON "homepage_post" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "homepage_comment_post_id_116a2ee8" ON "homepage_comment" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "homepage_comment_author_id_8043190f" ON "homepage_comment" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "homepage_like_liker_id_d383492d" ON "homepage_like" (
	"liker_id"
);
CREATE INDEX IF NOT EXISTS "homepage_like_post_id_9bf20406" ON "homepage_like" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "notifications_notification_public_1bc30b1c" ON "notifications_notification" (
	"public"
);
CREATE INDEX IF NOT EXISTS "notifications_notification_action_object_content_type_id_7d2b8ee9" ON "notifications_notification" (
	"action_object_content_type_id"
);
CREATE INDEX IF NOT EXISTS "notifications_notification_actor_content_type_id_0c69d7b7" ON "notifications_notification" (
	"actor_content_type_id"
);
CREATE INDEX IF NOT EXISTS "notifications_notification_recipient_id_d055f3f0" ON "notifications_notification" (
	"recipient_id"
);
CREATE INDEX IF NOT EXISTS "notifications_notification_target_content_type_id_ccb24d88" ON "notifications_notification" (
	"target_content_type_id"
);
CREATE INDEX IF NOT EXISTS "notifications_notification_deleted_b32b69e6" ON "notifications_notification" (
	"deleted"
);
CREATE INDEX IF NOT EXISTS "notifications_notification_emailed_23a5ad81" ON "notifications_notification" (
	"emailed"
);
CREATE INDEX IF NOT EXISTS "notifications_notification_unread_cce4be30" ON "notifications_notification" (
	"unread"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "users_follower_follower_id_1bae535a" ON "users_follower" (
	"follower_id"
);
CREATE INDEX IF NOT EXISTS "users_follower_being_followed_id_7c954751" ON "users_follower" (
	"being_followed_id"
);

COMMIT;
