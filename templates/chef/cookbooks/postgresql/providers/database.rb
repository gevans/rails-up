include PostgreSQL::Database

action :create_db do
  unless @pgsqldb.exists
    Chef::Log.info "postgresql_database: Creating database #{new_resource.database}"
    db.query("create user #{new_resource.database_user} with password '#{new_resource.database_password}'")
    db.query("create database #{new_resource.database}")
    db.query("grant all privileges on database #{new_resource.database} to #{new_resource.database_user}")
    new_resource.updated_by_last_action(true)
  end
end

def load_current_resource
  @pgsqldb = Chef::Resource::PostgresqlDatabase.new(new_resource.name)
  @pgsqldb.database(new_resource.database)
  databases = db.query("select datname from pg_database;").map do |result|
    result["datname"]
  end
  exists = databases.include?(new_resource.database)
  @pgsqldb.exists(exists)
end
