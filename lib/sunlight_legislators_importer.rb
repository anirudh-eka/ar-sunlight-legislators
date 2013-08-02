require 'csv'
require 'date'
require_relative '../app/models/congressman.rb'
require_relative '../app/models/party.rb'

CSV_FILE = ''

class SunlightLegislatorsImporter

  def self.import(filename = CSV_FILE)
    parties = ['D', 'R', 'I']
    parties.each do |name|
      Party.create({ name: name })
    end

    CSV.table(filename).each do |row|
      
      args = {}
      args[:title] = row[:title]

      args[:name] = "#{row[:firstname]} #{row[:middlename]} #{row[:lastname]} #{row[:name_suffix]}".rstrip
      args[:last_name] = row[:lastname]

      args[:state] = row[:state]
      args[:in_office] = row[:in_office] == 1 ? true : false
      args[:gender] = row[:gender]
      args[:phone] = row[:phone].gsub(/\D+/, '')
      args[:fax] = row[:fax].gsub(/\D+/, '')
      args[:website] = row[:website]
      args[:webform]  = row[:webform]
      args[:twitter_id] = row[:twitter_id]

      birthdate = case row[:birthdate]
                  when /\s+/ then nil
                  else Date.strptime row[:birthdate], '%m/%d/%Y'
                  end
      args[:birthdate] = birthdate

      congressman = Congressman.new(args)

      congressman.party = Party.where('name = ?', row[:party]).first
      congressman.save
    end

  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
