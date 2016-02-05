## Crafted (c) 2013~2014 by ZoatWorks Software LTDA.
## Prepared : Roberto Nogueira
## File     : Rakefile
## Version  : PA42
## Date     : 2016-02-02
## Project  : Project 2013~2016 TODAY Automation - Brazil
## Reference: ruby-2.1.2@global
##
## Purpose  : Develop a Rake system in order to help TODAY management directory
##            for projects.

require 'rake'
require 'rainbow'
require 'rainbow/ext/string' if RUBY_VERSION.to_f >= 2.0
require 'yaml'

USERPATH=ENV['HOME']
TODAY_TEMPLATES="#{USERPATH}/TODAY_Templates"
TODAY="#{USERPATH}/TODAY"

LOCAL="#{USERPATH}/TODAY_Archive"
DROPBOX="#{USERPATH}/Dropbox/TODAY_Archive"
GOOGLEDRIVE="#{USERPATH}/Google Drive/TODAY_Archive"
CHROMEAPPS="#{USERPATH}/Dropbox/Projects_CHROME"
ARCHIVE="#{USERPATH}/ARCHIVE"

CLOUD=GOOGLEDRIVE
TODAY_ARCHIVE=ARCHIVE

TODAY_DATA_FILE="today_data.yaml"

CMD_REGEX = /^\[\W\/\w+\]\$|^\w+>|^\w+@\w+>/

CMD_REGEX2 = /(^\w+)>/

desc "TODAY log directory"
task :today_log  do
  puts "=> today_log: logging TODAY directory...".bright
  puts
  LOGFILE= get_timestamp2 + "_localhost.log"
  system %{
  cd #{TODAY};
  touch #{LOGFILE};
  /usr/bin/script #{TODAY}/#{LOGFILE};
  }
end

task :default => ["today_print"]

desc "TODAY start directory"
  task :today_start, [:a_projecttype, :a_projectname, :a_parameter] do |t, args|
  puts "=> today_start: starting TODAY directory...".bright
  puts
  args.with_defaults(:a_projecttype => "projecttype", :a_projectname => "projectname", :a_parameter => "parameter")
  @today_projecttype = args.a_projecttype.split.join('_')
  @today_projectname = args.a_projectname.split.join('_')
  @today_parameter = args.a_parameter
  system %{cd "#{TODAY}"; mkdir #{@today_projectname}}
  if ((@today_projecttype.include? 'WSMD') and (@today_projectname.include? 'Lift')) or 
     ((@today_projecttype.include? 'WSMD') and (@today_projectname.include? 'New')) or 
     ((@today_projecttype.include? 'WSMD') and (@today_projectname.include? 'DC1')) or 
     ((@today_projecttype.include? 'WSMD') and (@today_projectname.include? 'DC2')) then
    system %{cd "#{TODAY}/#{@today_projectname}";
             touch status_data.txt;
             touch description.txt;
             touch trouble_effects.txt;
             touch trouble_description.txt;
             touch test_instruction.txt;
             touch plex_solution.txt;
             touch asa_solution.txt;
             touch load_spac_criteria.txt;
             touch test_data_and_cover_page.txt;
             touch enclosures.txt;
             touch notebook.txt
            }
  elsif ((@today_projecttype.include? 'WSMD') and (@today_projectname.include? 'Reuse')) then
    feature = @today_projectname.split('_')[0]
    @today_parameter = @today_parameter.split
	  @today_parameter.each do |parameter|
        system %{cd "#{TODAY}/#{@today_projectname}";
                 touch "#{feature}-#{parameter}.txt"
        }
	  end
  elsif ((@today_projecttype.include? 'WSMD') and (@today_projectname.include? 'Verification')) then
    	system %{cd "#{TODAY_TEMPLATES}/TEMPLATES_Verification"; cp * "#{TODAY}/#{@today_projectname}"}
  end
  @today_start = get_timestamp
  @today_stop = 'stop'
  get_today_name
  save_today_data
  puts "-- contents of TODAY directory:".color(:yellow)
  system %{ls -la "#{TODAY}/#{TODAY_DATA_FILE}"}
  puts
end

desc "TODAY start clone directory"
  task :today_clone, [:a_projecttype, :a_projectname] do |t, args|
  puts "=> today_clone: starting clone TODAY directory...".bright
  puts
  args.with_defaults(:a_projecttype => "projecttype", :a_projectname => "projectname")
  @today_projecttype = args.a_projecttype.split.join('_')
  @today_projectname = args.a_projectname.split.join('_')
  system %{cd "#{TODAY}"; git clone "https://github.com/enogrob/#{@today_projectname}.git"}
  @today_start = get_timestamp
  @today_stop = 'stop'
  get_today_name
  save_today_data
  puts "-- contents of TODAY directory:".color(:yellow)
  system %{ls -la "#{TODAY}/#{TODAY_DATA_FILE}"}
  puts
end

def save_today_data
  File.open("#{TODAY}/#{TODAY_DATA_FILE}", 'w') do |f| 
    today_data = {
    'Start' => @today_start,
    'Stop' => @today_stop,
    'ProjectType' => @today_projecttype,
    'ProjectName' => @today_projectname,
    'TodayName' => @today_name
  }	 
  YAML.dump(today_data, f)
  end	
end

def load_today_data
  if !File.exist?("#{TODAY}/#{TODAY_DATA_FILE}")
    puts "-- File: #{TODAY_DATA_FILE} do not exist !".color(:red)
    puts
    system %{rake --tasks}
    puts
    exit
  end 
  today_data = YAML.load(File.open("#{TODAY}/#{TODAY_DATA_FILE}"))
  @today_start = today_data['Start']
  @today_stop = today_data['Stop']
  @today_projecttype = today_data['ProjectType'] || 'projecttype'
  @today_projectname = today_data['ProjectName'] || 'projectname'
  @today_name = today_data['TodayName'] || 'todayname'
end

desc "TODAY printint data"
task :today_print do
  puts "Crafted (C) 2013~2016 by ZoatWorks Software LTDA, Brazil.".color(:cyan)
  puts "by Roberto Nogueira - PA42".color(:cyan)
  puts
  load_today_data
  puts "=> today_print: printing ricc data...".bright
  puts
  print "START       : ".color(:cyan);puts @today_start
  print "STOP        : ".color(:cyan);puts @today_stop
  print "PROJECT TYPE: ".color(:cyan);puts @today_projecttype.color(:green)
  print "PROJECT NAME: ".color(:cyan);puts @today_projectname.color(:green)
  print "TODAY   NAME: ".color(:cyan);puts @today_name.color(:green)
  puts
end
	
def get_timestamp
  t = DateTime.now
  t.strftime("%Y%m%d_%H%M")
end

def get_timestamp2
  t = DateTime.now
  t.strftime("%Y%m%d_%H%M%S")
end

def get_today_name
  @today_name = [] 
  if @today_stop == 'stop' then
    @today_name << @today_start
  else
    @today_name << @today_stop
  end
  @today_projecttype = @today_projecttype.delete('-')  
  @today_name << @today_projecttype
  @today_name << '-'
  @today_name << @today_projectname
  @today_name = @today_name.join('_')
end

desc "TODAY stop directory"
task :today_stop  do
  puts "=> today_stop: stopping TODAY directory...".bright
  puts
  load_today_data
  @today_stop = get_timestamp
  get_today_name
  save_today_data
  puts "-- today file generated:".color(:yellow)
  system %{ls -la "#{TODAY}/#{TODAY_DATA_FILE}"}
  puts
end

desc "TODAY end directory"
task :today_end  do
  puts "=> today_end: ending TODAY directory...".bright
  puts
  Rake::Task['today_stop'].invoke
  Rake::Task['today_archive'].invoke
end

desc "TODAY archive directory"
task :today_archive  do
  puts "=> today_archive: archiving TODAY directory...".bright
  puts
  load_today_data
  system %{cd "#{TODAY}";cp -rf "#{TODAY}/" "#{TODAY_ARCHIVE}/#{@today_name}/"}
  Rake::Task['today_cleanup'].invoke
  puts "-- listing ARCHIVE directory...".color(:yellow)
  system %{cd "#{TODAY_ARCHIVE}";ls -dl "#{@today_name}"}
  puts
end

desc "TODAY archive list"
task :today_archive_list  do
  puts "=> today_archive_list: Listing ARCHIVE directory...".bright
  puts
  puts "-- listing ARCHIVE directory...".color(:yellow)
  puts
  system %{cd "#{TODAY_ARCHIVE}";ls -la;cd "#{TODAY}"}
  puts
end

desc "TODAY archive Conf"
task :today_archive_conf  do
  puts "=> today_archive_conf: Listing ARCHIVE configuration...".bright
  puts
  puts "-- LOCAL  : #{LOCAL}".color(:yellow)
  puts "-- CLOUD  : #{CLOUD}".color(:yellow)
  puts
  if !File.exist?("#{USERPATH}/ARCHIVE")
    puts "-- File: #{USERPATH}/ARCHIVE do not exist !".color(:red)
    puts
    exit
  else  
    puts "-- ARCHIVE: #{ARCHIVE}".bright
    system %{cd "#{USERPATH}";ls -l ARCHIVE;cd "#{TODAY}"}
    puts
  end
end

task :today_archive_cloud  do
  puts "=> today_archive_cloud: Configuring to CLOUD...".bright
  system %{
    cd "#{USERPATH}";
    rm ARCHIVE;
    touch ARCHIVE;
    ln -sf "#{CLOUD}" ARCHIVE
  }
  system %{cd "#{USERPATH}";ls -l ARCHIVE}
  puts
  Rake::Task['today_archive_conf'].invoke
end

task :today_archive_local  do
  puts "=> today_archive_local: Configuring to LOCAL...".bright
  system %{
    cd "#{USERPATH}";
    rm ARCHIVE;
    touch ARCHIVE;
    ln -sf "#{LOCAL}" ARCHIVE
  }
  system %{cd "#{USERPATH}";ls -l ARCHIVE}
  puts
  Rake::Task['today_archive_conf'].invoke
end

desc "TODAY Cloud Conf"
task :today_cloud_conf  do
  puts "=> today_cloud_conf: Listing CLOUD configuration...".bright
  puts
  puts "-- DROPBOX    : #{DROPBOX}".color(:yellow)
  puts "-- GOOGLEDRIVE: #{GOOGLEDRIVE}".color(:yellow)
  puts
  if !File.exist?("#{USERPATH}/ARCHIVE")
    puts "-- File: #{USERPATH}/ARCHIVE do not exist !".color(:red)
    puts
    exit
  else  
    puts "-- ARCHIVE: #{ARCHIVE}".bright
    system %{cd "#{USERPATH}";ls -l ARCHIVE;cd "#{TODAY}"}
    puts
  end
end

task :today_cloud_dropbox  do
  puts "=> today_cloud_dropbox: Configuring to DROPBOX...".bright
  system %{
    cd "#{USERPATH}";
    rm ARCHIVE;
    touch ARCHIVE;
    ln -sf "#{DROPBOX}" ARCHIVE
  }
  system %{cd "#{USERPATH}";ls -l ARCHIVE}
  puts
  Rake::Task['today_cloud_conf'].invoke
end

task :today_cloud_googledrive  do
  puts "=> today_cloud_googledrive: Configuring to GOOGLEDRIVE...".bright
  system %{
    cd "#{USERPATH}";
    rm ARCHIVE;
    touch ARCHIVE;
    ln -sf "#{GOOGLEDRIVE}" ARCHIVE
  }
  system %{cd "#{USERPATH}";ls -l ARCHIVE}
  puts
  Rake::Task['today_cloud_conf'].invoke
end

desc "TODAY archive fallback"
task :today_archive_fallback, [:a_todayname] do |t, args|
  puts "=> today_archive_fallback: fallback to TODAY directory...".bright
  puts
  args.with_defaults(:a_todayname => "todayname")
  @today_name = args.a_todayname
  if @today_name == "todayname" then
    if File.dirname(Rake.original_dir) == TODAY_ARCHIVE then
      @today_name = File.basename(Rake.original_dir)
    else
      puts "-- listing ARCHIVE directory...".color(:yellow)
      puts
      system %{cd "#{TODAY_ARCHIVE}";ls -la;cd "#{TODAY}"}
      puts "-- todayname is required.".color(:yellow)
      puts
      exit
    end
  end
  if Dir["#{TODAY_ARCHIVE}/#{@today_name}"].empty?
    puts "-- Directory: #{TODAY_ARCHIVE}/#{@today_name} do not exist !".color(:red)
    puts
    exit
  end 
  save_today_data
  load_today_data
  system %{shopt -s dotglob;cd "#{TODAY_ARCHIVE}/#{@today_name}";mv * "#{TODAY}";cd ..;rm -rf "#{TODAY_ARCHIVE}/#{@today_name}"}
  load_today_data
  get_today_name
  save_today_data	
  Dir.chdir("#{TODAY}/#{@today_projectname}")
  puts "-- contents of #{@today_projectname} :".color(:yellow)
  system %{ls -la "#{TODAY}/#{@today_projectname}"}
  Dir.chdir(TODAY)
  puts
end

desc "TODAY archive select"
task :today_archive_select, [:a_todayname] do |t, args|
  puts "=> today_archive_select: select TODAY directory...".bright
  puts
  args.with_defaults(:a_todayname => "todayname")
  @today_name = args.a_todayname
  if @today_name == "todayname" then
    puts "-- listing ARCHIVE directory...".color(:yellow)
    puts
    system %{cd "#{TODAY_ARCHIVE}";ls -la;cd "#{TODAY}"}
    puts "-- todayname is required.".color(:red)
    puts
    exit
  end
  if Dir["#{TODAY_ARCHIVE}/#{@today_name}"].empty?
    puts "-- Directory: #{TODAY_ARCHIVE}/#{@today_name} do not exist !".color(:red)
    puts
    exit
  end 
  if !File.exist?("#{TODAY_ARCHIVE}/#{@today_name}/#{TODAY_DATA_FILE}")
    puts "-- File: #{TODAY_DATA_FILE} do not exist !".color(:red)
    puts
    exit
  end 
  today_data = YAML.load(File.open("#{TODAY_ARCHIVE}/#{@today_name}/#{TODAY_DATA_FILE}")) 
  @today_projectname = today_data['ProjectName'] || 'projectname'
  @today_name = today_data['TodayName'] || 'todayname'
  system %{
  cd "#{TODAY}";
  ln -sf "#{TODAY_ARCHIVE}/#{@today_name}/#{@today_projectname}" "#{@today_projectname}";
  ln -sf "#{@today_projectname}" current_app 
  }
  puts "-- contents of TODAY directory:".color(:yellow)
  system %{ls -la "#{TODAY}"}
  puts
end

desc "TODAY archive unselect"
task :today_archive_unselect, [:a_todayname] do |t, args|
  puts "=> today_archive_unselect: unselect TODAY directory...".bright
  puts
  args.with_defaults(:a_todayname => "todayname")
  @today_name = args.a_todayname
  if @today_name == "todayname" then
    puts "-- listing ARCHIVE directory...".color(:yellow)
    puts
    system %{cd "#{TODAY_ARCHIVE}";ls -la;cd "#{TODAY}"}
    puts "-- todayname is required.".color(:red)
    puts
    exit
  end
  if Dir["#{TODAY_ARCHIVE}/#{@today_name}"].empty?
    puts "-- Directory: #{TODAY_ARCHIVE}/#{@today_name} do not exist !".color(:red)
    puts
    exit
  end 
  if !File.exist?("#{TODAY_ARCHIVE}/#{@today_name}/#{TODAY_DATA_FILE}")
    puts "-- File: #{TODAY_DATA_FILE} do not exist !".color(:red)
    puts
    exit
  end 
  today_data = YAML.load(File.open("#{TODAY_ARCHIVE}/#{@today_name}/#{TODAY_DATA_FILE}")) 
  @today_projectname = today_data['ProjectName'] || 'projectname'
  @today_name = today_data['TodayName'] || 'todayname'
  system %{
  cd "#{TODAY}";
  cp *.log "#{TODAY_ARCHIVE}/#{@today_name}";
  ls -r1 *.log | tail +$((2)) | xargs rm;
  ls -r1 *.log | head -1 | xargs cp /dev/null;
  rm -f current_app;
  rm -f "#{@today_projectname}"
  }
  puts "-- contents of TODAY directory:".color(:yellow)
  system %{ls -la "#{TODAY}"}
  puts
end

desc "TODAY copy from archive"
task :today_archive_copy, [:a_todayname] do |t, args|
  puts "=> today_archive_copy: copying to TODAY directory...".bright
  puts
  args.with_defaults(:a_todayname => "todayname")
  @today_name = args.a_todayname
  if @today_name == "todayname" then
    puts "-- listing ARCHIVE directory...".color(:yellow)
    system %{cd "#{TODAY_ARCHIVE}";ls -la;cd "#{TODAY}"}
    puts "-- todayname is required.".color(:red)
    puts
    exit
  end
  if Dir["#{TODAY_ARCHIVE}/#{@today_name}"].empty?
    puts "-- Directory: #{TODAY_ARCHIVE}/#{@today_name} do not exist !".color(:red)
    puts
    exit
  end 
  save_today_data
  load_today_data
  system %{cp -rf "#{TODAY_ARCHIVE}/#{@today_name}/" "#{TODAY}/"}
  load_today_data
  get_today_name
  save_today_data	
  puts "-- contents of TODAY directory:".color(:yellow)
  system %{ls -la "#{TODAY}"}
  puts
end

desc "TODAY copy to CLOUD directory"
task :today_cloud_to, [:a_todayname] do |t, args|
  puts "=> today_cloud_to: copying to CLOUD directory...".bright
  puts
  args.with_defaults(:a_todayname => "TODAY")
  @today_name = args.a_todayname
  if @today_name == "Projects_CHROME" then
    if !Dir["#{CHROMEAPPS}"].empty? then
      system %{cd "#{DROPBOX}";rm -rf Projects_CHROME;mkdir Projects_CHROME}
      system %{cd "#{TODAY}/Chrome_Apps";cp -r * "#{CHROMEAPPS}"}
      puts "-- contents of Projects_CHROME directory:".color(:yellow)
      system %{cd "#{TODAY}/Chrome_Apps";ls -dl "#{CHROMEAPPS}"}
      puts
    end
  else
    if !Dir["#{CLOUD}/#{@today_name}"].empty?
      system %{rm -rf "#{CLOUD}/#{@today_name}"}
    end 
    system %{mkdir -p "#{CLOUD}/#{@today_name}";cd "#{TODAY}";shopt -s dotglob;cp -r * "#{CLOUD}/#{@today_name}"}
    puts "-- contents of CLOUD directory:".color(:yellow)
    system %{cd "#{CLOUD}";ls -dl "#{@today_name}"}
    puts
  end
end

desc "TODAY copy from CLOUD directory"
task :today_cloud_from, [:a_todayname] do |t, args|
  puts "=> ricc_cloud_from: copying from CLOUD directory...".bright
  puts
  args.with_defaults(:a_todayname => "TODAY")
  @today_name = args.a_todayname
  if Dir["#{CLOUD}/#{@today_name}"].empty?
    puts "-- Directory: #{CLOUD}/#{@today_name} do not exist !".color(:red)
    puts
    exit
  end 
  system %{cd "#{CLOUD}/#{@today_name}";shopt -s dotglob;cp -r * "#{TODAY}"}
  puts "-- contents of TODAY directory:".color(:yellow)
  system %{ls -la "#{TODAY}"}
  puts
end

desc "TODAY cleanup directory"
task :today_cleanup do
  puts "=> today_cleanup: cleaning TODAY directory...".bright
  puts
  system %{
    cd "#{TODAY}";
    find . -mindepth 1 -maxdepth 1 -type d | xargs -t rm -rf;
    find "#{TODAY}" -type f -not -name '*.log' -not -name '.DS_Store' -not -name '.ruby-*' | xargs rm 
  }
  if !Dir.glob("#{TODAY}/*.log").empty?
    system %{
    cd "#{TODAY}";
    ls -r1 *.log | tail -2 | xargs rm;
    ls -r1 *.log | head -1 | xargs cp /dev/null  
    }
  end
  puts "-- contents of TODAY directory:".color(:yellow)
  system %{ls -la "#{TODAY}"}
  puts
end
