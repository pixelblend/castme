get '/' do
  @shows = get_shows
  erb :rss
end

Show = Struct.new(:url, :name, :date, :description)

def get_shows
  shows_dir = File.join(File.dirname(__FILE__), 'public', 'shows')

  Dir[File.join(shows_dir, '*.mp3')].collect do |file|
    s = Show.new

    s.url = "shows/#{CGI::escape(File.basename(file))}"
    s.date = File.mtime(file)

    Mp3Info.open(file) do |mp3|
      s.name = mp3.tag.title || File.basename(file, '.mp3')
      s.description = [mp3.tag.title,mp3.tag.artist,mp3.tag1.comments].join("\n\r")
    end

    s
  end.sort{|x,y| x.date <=> y.date}
end
