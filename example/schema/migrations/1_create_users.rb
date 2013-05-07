module FlySouth::Migrations

  def create_users_up
    execute %Q{
      CREATE TABLE users (
        id INTEGER NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        bio TEXT)}
  end

  def create_users_down
    execute "DROP TABLE users"
  end

end