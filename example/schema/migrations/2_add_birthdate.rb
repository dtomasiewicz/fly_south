module FlySouth::Migrations

  def add_birthdate_up
    execute "ALTER TABLE users ADD birthdate INTEGER"
  end

  def add_birthdate_down
    # sqlite doesn't support DROP COLUMN!
    execute *[
      "CREATE TEMPORARY TABLE users_backup (id, name, bio)",
      "INSERT INTO users_backup SELECT id, name, bio FROM users",
      "DROP TABLE users",
      "CREATE TABLE users (
         id INTEGER NOT NULL PRIMARY KEY,
         name TEXT NOT NULL,
         bio TEXT)",
      "INSERT INTO users SELECT * FROM users_backup",
      "DROP TABLE users_backup"]
  end

end