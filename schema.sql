CREATE SCHEMA discogs;

CREATE TABLE discogs.artists (
	id int4 NOT NULL,
	data_quality varchar(255) NULL,
	"name" text NULL,
	profile text NULL,
	real_name text NULL,
	status text NULL,
	CONSTRAINT artists_pkey PRIMARY KEY (id)
);

CREATE TABLE discogs.artist_namevariations (
	artist_id int4 NOT NULL,
	ofst int4 NOT NULL,
	namevariation text NOT NULL,
	CONSTRAINT artist_namevariations_pkey PRIMARY KEY (artist_id, ofst),
	CONSTRAINT artists_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE
);

CREATE TABLE discogs.artist_aliases (
	artist_id int4 NOT NULL,
	ofst int4 NOT NULL,
	artist2_id int4 NULL,
	"name" varchar(255) NULL,
	CONSTRAINT artist_aliases_pkey PRIMARY KEY (artist_id, ofst),
	CONSTRAINT artists_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE
);

CREATE TABLE discogs.artist_groups (
	artist_id int4 NOT NULL,
	ofst int4 NOT NULL,
	artist2_id int4 NULL,
	"name" text NULL,
	CONSTRAINT artist_groups_pkey PRIMARY KEY (artist_id, ofst),
	CONSTRAINT artists_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE
);

CREATE TABLE discogs.artist_members (
	artist_id int4 NOT NULL,
	ofst int4 NOT NULL,
	artist2_id int4 NULL,
	"name" text NULL,
	CONSTRAINT artist_members_pkey PRIMARY KEY (artist_id, ofst),
	CONSTRAINT artists_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE
);

CREATE TABLE discogs.artist_urls (
	artist_id int4 NOT NULL,
	ofst int4 NOT NULL,
	url text NOT NULL,
	CONSTRAINT artist_urls_pkey PRIMARY KEY (artist_id, ofst),
	CONSTRAINT artists_id_fkey FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE
);

CREATE TABLE discogs.releases (
	id int4 NOT NULL,
	country varchar(255) NULL,
	data_quality varchar(255) NULL,
	master_id int4 NULL,
	notes text NULL,
	released varchar(255) NULL,
	status text NULL,
	title text NULL,
	CONSTRAINT releases_pkey PRIMARY KEY (id)
);

CREATE TABLE discogs.release_artist_maps (
	release_id int4 NOT NULL,
	ofst int4 NOT NULL,
	artist_id int4 NOT NULL,
	anv text NULL,
	join_relation text NULL,
	"name" text NULL,
	tracks text NULL,
	CONSTRAINT release_artist_maps_pkey PRIMARY KEY (release_id, ofst),
	CONSTRAINT releases_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE
);

CREATE TABLE discogs.release_extra_artist_maps (
	release_id int4 NOT NULL,
	ofst int4 NOT NULL,
	artist_id int4 NOT NULL,
	anv text NULL,
	join_relation text NULL,
	"name" text NULL,
	"role" text NULL,
	tracks text NULL,
	CONSTRAINT release_extra_artist_maps_pkey PRIMARY KEY (release_id, ofst),
	CONSTRAINT releases_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE
);

CREATE TABLE discogs.release_companies (
	release_id int4 NOT NULL,
	ofst int4 NOT NULL,
	company_id int4 NOT NULL,
	catno varchar(255) NULL,
	entity_type int4 NULL,
	entity_type_name varchar(255) NULL,
	"name" varchar(255) NULL,
	CONSTRAINT release_companies_pkey PRIMARY KEY (release_id, ofst),
	CONSTRAINT releases_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE
);

CREATE TABLE discogs.release_formats (
	release_id int4 NOT NULL,
	ofst int4 NOT NULL,
	"name" text NULL,
	qty text NULL,
	"text" text NULL,
	CONSTRAINT release_formats_pkey PRIMARY KEY (release_id, ofst),
	CONSTRAINT releases_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE
);

CREATE TABLE discogs.release_genres (
	release_id int4 NOT NULL,
	ofst int4 NOT NULL,
	genre varchar(255) NOT NULL,
	CONSTRAINT release_genres_pkey PRIMARY KEY (release_id, ofst),
	CONSTRAINT releases_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE
);

CREATE TABLE discogs.release_styles (
	release_id int4 NOT NULL,
	ofst int4 NOT NULL,
	"style" varchar(255) NOT NULL,
	CONSTRAINT release_styles_pkey PRIMARY KEY (release_id, ofst),
	CONSTRAINT releases_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE
);

CREATE TABLE discogs.release_labels (
	release_id int4 NOT NULL,
	ofst int4 NOT NULL,
	label_id int4 NOT NULL,
	catno text NULL,
	"name" varchar(255) NULL,
	CONSTRAINT release_labels_pkey PRIMARY KEY (release_id, ofst),
	CONSTRAINT releases_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE
);

CREATE TABLE discogs.release_videos (
	release_id int4 NOT NULL,
	ofst int4 NOT NULL,
	src varchar(255) NOT NULL,
	description varchar(255) NULL,
	duration varchar(255) NULL,
	embed bool NULL,
	title varchar(255) NULL,
	CONSTRAINT release_videos_pkey PRIMARY KEY (release_id, ofst),
	CONSTRAINT releases_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE
);

CREATE TABLE discogs.tracks (
	release_id int4 NOT NULL,
	ofst int4 NOT NULL,
	title text NULL,
	duration varchar(255) NULL,
	"position" varchar(255) NULL,
	CONSTRAINT tracks_pkey PRIMARY KEY (ofst, release_id),
	CONSTRAINT releases_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE
);

CREATE TABLE discogs.track_artist_maps (
	release_id int4 NOT NULL,
	track_ofst int4 NOT NULL,
	artist_ofst int4 NOT NULL,
	artist_id int4 NOT NULL,
	anv text NULL,
	join_relation text NULL,
	"name" text NULL,
	CONSTRAINT track_artist_maps_pkey PRIMARY KEY (release_id, track_ofst, artist_ofst),
	CONSTRAINT tracks_id_fkey FOREIGN KEY (release_id, track_ofst)
	REFERENCES tracks(release_id, ofst) ON DELETE CASCADE
);

CREATE TABLE discogs.track_extra_artist_maps (
	release_id int4 NOT NULL,
	track_ofst int4 NOT NULL,
	artist_ofst int4 NOT NULL,
	artist_id int4 NOT NULL,
	anv text NULL,
	join_relation text NULL,
	"name" text NULL,
	"role" text NULL,
	CONSTRAINT track_extra_artist_maps_pkey PRIMARY KEY (track_ofst, release_id, artist_ofst),
	CONSTRAINT tracks_id_fkey FOREIGN KEY (release_id, track_ofst)
	REFERENCES tracks(release_id, ofst) ON DELETE CASCADE
);

CREATE TABLE discogs.masters (
	id int4 NOT NULL,
	main_release_id int4 NULL,
	CONSTRAINT master_pkey PRIMARY KEY (id)
);

CREATE TABLE discogs.labels (
	id int4 NOT NULL,
	contact_info text NULL,
	data_quality varchar(255) NULL,
	"name" varchar(255) NULL,
	profile text NULL,
	CONSTRAINT labels_pkey PRIMARY KEY (id)
);

CREATE TABLE discogs.label_sublabels (
	label_id int4 NOT NULL,
	ofst int4 NOT NULL,
	label2_id int4 NOT NULL,
	"name" varchar(255) NULL,
	CONSTRAINT label_sublabels_pkey PRIMARY KEY (label_id, ofst),
	CONSTRAINT label_id_fkey FOREIGN KEY (label_id) REFERENCES labels(id) ON DELETE CASCADE
);

CREATE TABLE discogs.label_urls (
	label_id int4 NOT NULL,
	ofst int4 NOT NULL,
	url text NOT NULL,
	CONSTRAINT label_urls_pkey PRIMARY KEY (label_id, ofst),
	CONSTRAINT label_id_fkey FOREIGN KEY (label_id) REFERENCES labels(id) ON DELETE CASCADE
);