## Crafted (c) 2013 by ZoatWorks Software LLC.
## Prepared : Roberto Nogueira
## File     : Rakefile
## Version  : PA11
## Date     : 2014-01-11
## Project  : Project 2013 TODAY Automation - Brazil
## Reference: ruby 2.0.0p598 (2014-11-13) [x86_64-cygwin]
## Rake     : rake (10.3.2)
##
## Purpose  : Develop a Rake system in order to help TODAY management directory
##            for projects.

require 'rake'
require 'rainbow'
require 'rainbow/ext/string' if RUBY_VERSION.to_f >= 2.0

require 'yaml'

USERPATH="/home/" + ENV['USERNAME']
TODAY_TEMPLATES="#{USERPATH}/TODAY_Templates"
TODAY_ARCHIVE="#{USERPATH}/TODAY_Archive"

TODAY="#{USERPATH}/TODAY"
CLOUD="#{USERPATH}/CLOUD/"

TODAY_DATA_FILE="today_data.yaml"

CMD_REGEX = /^\[\W\/\w+\]\$|^\w+>|^\w+@\w+>/

CMD_REGEX2 = /(^\w+)>/

task :default => ["today_print"]

desc "TODAY start directory"
task :today_start, [:a_projecttype, :a_projectname] do |t, args|
    puts "=> today_start: starting TODAY directory...".bright
    puts
    args.with_defaults(:a_projecttype => "projecttype", :a_projectname => "projectname")
    @today_projecttype = args.a_projecttype
    @today_projectname = args.a_projectname
    system %{cd "#{TODAY}"}
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
  puts "Crafted (C) 2013-2015 by ZoatWorks Software LLC, Brazil.".color(:cyan)
  puts "by Roberto Nogueira - PA11".color(:cyan)
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

def get_today_name
  @today_name = [] 
  @today_name << @today_start
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
  save_today_data
  puts "-- today file generated:".color(:yellow)
  system %{ls -la "#{TODAY}/#{TODAY_DATA_FILE}"}
  puts
end

desc "TODAY archive directory"
task :today_archive  do
  puts "=> today_archive: archiving TODAY directory...".bright
  puts
  load_today_data
  get_today_name
  system %{cd "#{TODAY}";cp -rf "#{TODAY}/" "#{TODAY_ARCHIVE}/#{@today_name}/"}
  Rake::Task['today_cleanup'].invoke
  puts "-- listing ARCHIVE directory...".color(:yellow)
  system %{cd "#{TODAY_ARCHIVE}";ls -dl "#{@today_name}"}
  puts
end

desc "TODAY archive fallback"
task :today_archive_fallback, [:a_todayname] do |t, args|
  puts "=> today_archive_fallback: fallback to TODAY directory...".bright
  puts
  args.with_defaults(:a_todayname => "todayname")
  @today_name = args.a_todayname
  if @today_name == "todayname" then
    puts "-- listing ARCHIVE directory...".color(:yellow)
    puts
    system %{cd "#{TODAY_ARCHIVE}";ls -la;cd "#{TODAY}"}
    puts "-- todayname is required.".color(:yellow)
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
  system %{shopt -s dotglob;cd "#{TODAY_ARCHIVE}/#{@today_name}";mv * "#{TODAY}";cd ..;rm -rf "#{TODAY_ARCHIVE}/#{@today_name}"}
  load_today_data
  get_today_name
  save_today_data	
  puts "-- contents of TODAY directory:".color(:yellow)
  system %{ls -la "#{TODAY}"}
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
  if !Dir["#{CLOUD}/#{@today_name}"].empty?
    system %{rm -rf "#{CLOUD}/#{@today_name}"}
  end 
  system %{mkdir -p "#{CLOUD}/#{@today_name}";cd "#{TODAY}";shopt -s dotglob;cp -r * "#{CLOUD}/#{@today_name}"}
  puts "-- contents of CLOUD directory:".color(:yellow)
  system %{cd "#{CLOUD}";ls -dl "#{@today_name}"}
  puts
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
    find "#{TODAY}" -type f -not -name '*.log' -not -name '.DS_Store' -not -name '.ruby-gemset' -not -name '.ruby-version' | xargs rm;
    ls -r1 *.log | tail +$((2)) | xargs rm;
    ls -r1 *.log | head -1 | xargs cp /dev/null  
  }
  puts "-- contents of TODAY directory:".color(:yellow)
  system %{ls -la "#{TODAY}"}
  puts
end