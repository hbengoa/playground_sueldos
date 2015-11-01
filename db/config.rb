config = { 'production' => { 'adapter' => 'fb',
                             'database' => 'db/sueldos.fdb',
                             'username' => 'sysdba',
                             'password' => 'masterkey',
                             'host' => 'localhost',
                             'create' => true,
                             'encoding' => 'UTF-8' },
           'testing'    => { 'adapter' => 'fb',
                             'database' => 'db/testing.fdb',
                             'username' => 'sysdba',
                             'password' => 'masterkey',
                             'host' => 'localhost',
                             'create' => true,
                             'encoding' => 'UTF-8' } }

ActiveRecord::Base.configurations = config
