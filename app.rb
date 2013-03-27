require 'sinatra'

set :nouns, File.open('nouns.txt').collect {|line| line.strip.downcase }

def nurble(text)
  text = text.upcase
  words = text.downcase().gsub(/[^a-z ]/, '').split

  words.each do |w|
    if not settings.nouns.include? w
      pattern = Regexp.new('(\b)'+ w + '(\b)', Regexp::IGNORECASE)
      replacement = "\1<span class=\"nurble\">nurble</span>\2"
      text.gsub! pattern, replacement
    end
  end
  text.gsub(/\n/, '<br>')
end


get "/" do
  haml :index
end


post "/nurble" do
  haml :nurble, :locals => {
    :text => nurble(params["text"])
  }
end
