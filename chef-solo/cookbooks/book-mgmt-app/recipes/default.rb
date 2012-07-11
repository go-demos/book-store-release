include_recipe "tomcat7"
include_recipe "h2"
include_recipe "ant"

#remote_file "book_management.war" do
#	path  "/usr/local/tomcat/webapps/book_managemet.war"
#	owner "tomcat"
#	mode  "0640"
#	source "/tmp/book_management.war"
#end 

file "book_management.war" do
	path  "/usr/local/tomcat/webapps/book_managemet.war"
    	content IO.read("/tmp/book_management.war")
    	only_if {File.exists?("/tmp/book_management.war")}    
end


service "tomcat7" do
	action :restart
end
