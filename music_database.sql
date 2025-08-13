-- Создание таблицы Жанры
CREATE TABLE Genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Создание таблицы Исполнители
CREATE TABLE Artists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Создание таблицы Альбомы
CREATE TABLE Albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    year INTEGER NOT NULL CHECK (year > 1900 AND year <= EXTRACT(YEAR FROM CURRENT_DATE))
);

-- Создание таблицы Треки
CREATE TABLE Tracks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INTEGER NOT NULL CHECK (duration > 0), -- в секундах
    album_id INTEGER NOT NULL,
    FOREIGN KEY (album_id) REFERENCES Albums(id) ON DELETE CASCADE
);

-- Создание таблицы Сборники
CREATE TABLE Compilations (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    year INTEGER NOT NULL CHECK (year > 1900 AND year <= EXTRACT(YEAR FROM CURRENT_DATE))
);

-- Создание связующей таблицы для отношения многие-ко-многим между Исполнителями и Жанрами
CREATE TABLE ArtistsGenres (
    id SERIAL PRIMARY KEY,
    artist_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES Artists(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES Genres(id) ON DELETE CASCADE,
    UNIQUE (artist_id, genre_id)
);

-- Создание связующей таблицы для отношения многие-ко-многим между Исполнителями и Альбомами
CREATE TABLE ArtistsAlbums (
    id SERIAL PRIMARY KEY,
    artist_id INTEGER NOT NULL,
    album_id INTEGER NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES Artists(id) ON DELETE CASCADE,
    FOREIGN KEY (album_id) REFERENCES Albums(id) ON DELETE CASCADE,
    UNIQUE (artist_id, album_id)
);

-- Создание связующей таблицы для отношения многие-ко-многим между Треками и Сборниками
CREATE TABLE TracksCompilations (
    id SERIAL PRIMARY KEY,
    track_id INTEGER NOT NULL,
    compilation_id INTEGER NOT NULL,
    FOREIGN KEY (track_id) REFERENCES Tracks(id) ON DELETE CASCADE,
    FOREIGN KEY (compilation_id) REFERENCES Compilations(id) ON DELETE CASCADE,
    UNIQUE (track_id, compilation_id)
);

-- Создание индексов для ускорения поиска
CREATE INDEX idx_artists_name ON Artists(name);
CREATE INDEX idx_albums_title ON Albums(title);
CREATE INDEX idx_tracks_title ON Tracks(title);
CREATE INDEX idx_compilations_title ON Compilations(title);
CREATE INDEX idx_artists_genres ON ArtistsGenres(artist_id, genre_id);
CREATE INDEX idx_artists_albums ON ArtistsAlbums(artist_id, album_id);
CREATE INDEX idx_tracks_compilations ON TracksCompilations(track_id, compilation_id);