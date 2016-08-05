require 'find'

#Class to use to convert slim file into html by calling run method
class SlimConvert

  ## Run the slim files convertion
  # Create missing folder then loop on files convertion
  ##
  def run
    create_missing_directory!

    loop do
      convert_slim_files!
      sleep 1
    end
  end

  ## Convert all slim into html
  # Find all slim files into slim folder, convert them in html and put them
  #   into html folder
  # Note:
  #   Use excutable 'slimrb' in command line
  ##
  def convert_slim_files!
    Find.find("slim").each do |path|
      if path.include? ".slim"
        puts "Convert #{path} to #{path.gsub('slim/', 'html/').gsub('.slim', '')}"
        `slimrb #{path} > #{path.gsub('slim/', 'html/').gsub('.slim', '')}`
      end
    end
  end

  ## Create all missing folder
  # Create an html folder and create all subfolder if they do not exist
  ##
  def create_missing_directory!
    unless Dir.exist? "html"
      puts "Create html directory"
      Dir.mkdir "html"
    end

    Find.find("slim").each do |path|
      if path.include? ".slim"
        html_directory = path.gsub('slim/', 'html/')[0..(path.rindex '/')]

        unless Dir.exist? html_directory
          puts "Create #{html_directory}"
          Dir.mkdir html_directory
        end
      end
    end
  end
end

SlimConvert.new.run
