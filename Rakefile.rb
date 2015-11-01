require_relative 'application'

namespace :db do
  namespace :production do
    desc 'setup production database: destroy, create and seed'
    task :setup => [:destroy, :create, :seed]

    desc 'create production database'
    task :create do
      system "echo \"CREATE DATABASE 'db/sueldos.fdb' USER 'SYSDBA' PASSWORD 'masterkey' PAGE_SIZE 16384;\" | isql-fb"
      system "isql-fb -user SYSDBA -pas masterkey -input db/schema.sql 'db/sueldos.fdb'"
    end

    desc 'destroy production database'
    task :destroy do
      system 'sudo rm db/sueldos.fdb'
    end

    desc 'seed production database'
    task :seed do
      Application.instance.db_connect
      require_relative 'db/seeds'
    end
  end

  namespace :testing do
    desc 'create testing database'
    task :create do
      system "echo \"CREATE DATABASE 'db/testing.fdb' USER 'SYSDBA' PASSWORD 'masterkey' PAGE_SIZE 16384;\" | isql-fb"
      system "isql-fb -user SYSDBA -pas masterkey -input db/schema.sql 'db/testing.fdb'"
    end

    desc 'destroy production database'
    task :destroy do
      system 'sudo rm db/testing.fdb'
    end
  end
end
