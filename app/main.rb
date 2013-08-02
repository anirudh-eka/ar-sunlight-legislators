require 'thor'
require 'pry'
require_relative '../db/config.rb'
require_relative '../app/models/congressman.rb'
require_relative '../app/models/party.rb'

# binding.pry

class Congressomator < Thor
  
  desc "show_congressmen_from STATE", "show all the congressmen from a given STATE"
  def show_congressmen_from(state)
    state = state.upcase
    senators = Congressman.where('title = ? AND state = ?', 'Sen', state)
               .order('last_name')
    representatives = Congressman.where('title = ? AND state = ?', 'Rep', state)
                      .order('last_name')
    puts 'Senators:'
    senators.each do |senator|
      puts "\t#{senator.name} (#{senator.party.name})"
    end

    puts 'Representatives:'
    representatives.each do |representative|
      puts "\t#{representative.name} (#{representative.party.name})"
    end
  end

  desc "gender_stats_for GENDER", "show gender breakdowns for given GENDER"
  def gender_stats_for(gender)
    gender = gender.upcase

    tot_sen_num = 100
    tot_rep_num = 435

    sen_num = Congressman.where("title = 'Sen' AND in_office = 't' AND gender = ?", gender).count
    rep_num = Congressman.where("title = 'Rep' AND in_office = 't' AND gender = ?", gender).count
    sen_percent = ((sen_num.to_f/tot_sen_num) * 100).to_i
    rep_percent = ((rep_num.to_f/tot_rep_num) * 100).to_i

    gender_s = (gender == 'F') ? 'Female' : 'Male'
    puts "#{gender_s} Senators: #{sen_num} (#{sen_percent}%)"
    puts "#{gender_s} Representatives: #{rep_num} (#{rep_percent}%)"

  end

  desc "list", "lists all states along with active senators and representatives in decending order"
  def list

    states_representatives = Congressman.select('state', 'title', 'count(name) as count')
              .where('in_office = ? AND title = ?', true, 'Rep')
              .group('state')
              .order('count DESC')

    states_representatives.each do |state_representative|
      state = state_representative.state
      representatives = Congressman.where('state = ? and in_office = ? and title = ?', state, true, 'Rep').count
      puts "#{state}: 2 Senators, #{representatives} Representative(s)"
    end       

  end

  desc "totals", "the total number of senators and representatives"
  def totals
    representatives = Congressman.where('title = ?', 'Rep').count
    senators = Congressman.where('title = ?', 'Sen').count

    puts "Senators: #{senators}"
    puts "Representatives: #{representatives}"
  end

  desc "delete_inactive", "deletes congressmen not in office"
  def delete_inactive
    Congressman.where('in_office = ?', false).each { |inactive| inactive.delete }
  end

end
 
Congressomator.start(ARGV)
