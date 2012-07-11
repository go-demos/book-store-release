cwd = File.expand_path(File.dirname(__FILE__) + "/")

cookbook_path    [ "#{cwd}/cookbooks"]
node_path 	 [ "#{cwd}/node" ]
role_path 	 [ "#{cwd}/roles" ]
file_cache_path  [ "#{cwd}/tmp/" ]

log_location     STDOUT
log_level        :debug
verbose_logging  nil
