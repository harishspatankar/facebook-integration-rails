class MatchRecordsController < ApplicationController
  
  before_action :get_match_records, only: [:index]

  def index
    
  end

  def generate_images
    match_records = MatchRecord.where(id: params[:match_records])
    @image = IMGKit.new(get_string_format(match_records).to_s, :quality => 100)
    @image.stylesheets << '/home/harish/PracticeProjects/facebook-integration-rails/app/assets/stylesheets/match_records.css'
    send_data(@image.to_jpg, :type => "image/jpeg", :disposition => 'inline')
  end

  def get_match_records
    @match_record = MatchRecord.all.select(:id, :home_team, :opponent, :match_date, :match_type, :result, :home_score, :opponent_score)
  end

  def get_string_format(match_records)
    "<html>" <<
    "<head>" <<
    "<meta name='viewport' content='width=device-width, initial-scale=1'>" <<
    "<title>Match Records</title>" <<
    "</head>" <<
    "<body>" <<
    "<div class='row'>" <<
    convert_match_records_to_string(match_records) <<
    "</div>" <<
    "</body>" <<
    "</html>"
  end

  def convert_match_records_to_string(match_records)
    middle_string = ""
    match_records.each do |match_record|
      middle_string << generate_loop_string(match_record)
    end
    middle_string
  end

  def generate_loop_string(match_record)
    "<div class='column'>" <<
    "<div class='card'>" <<
    "<div class='card_title'>" <<
    "#{match_record.home_team} Vs #{match_record.opponent}" <<
    "</div>" <<
    "<p>Date: #{match_record.match_date}</p>" <<
    "<p>Type: #{match_record.match_type}</p>" <<
    "<p class='result'>Result: <b><span class='result_type_win'>#{match_record.result}</span></b></p>" <<
    "<p>#{match_record.home_team} (#{match_record.home_score}) #{match_record.opponent} (#{match_record.opponent_score})" <<
    "</div>" <<
    "</div>"
  end

end
