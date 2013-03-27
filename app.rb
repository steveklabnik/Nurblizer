require 'sinatra/base'

class Nurblizer < Sinatra::Base
  set :nouns, File.open('nouns.txt').collect {|line| line.strip.downcase }

  def nurble(text)
    text = text.upcase
    words = text.downcase.gsub(/[^a-z ]/, '').split

    words.each do |w|
      unless settings.nouns.include? w
        replacement = %q{\1<span class="nurble">nurble</span>\2}
        text.gsub!(/(\b)#{w}(\b)/i, replacement)
      end
    end
    text.gsub(/\n/, '<br>')
  end


  get "/" do
    haml :index
  end

  get "/nurble" do
    haml :nurble, :locals => {
      :text => nurble(params["text"])
    }
  end
end
