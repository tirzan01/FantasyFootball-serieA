class Scraper

  def scrape_team
    html = open('https://www.fantacalcio.it/squadre')
    doc = Nokogiri::HTML(html)
    teams = doc.css('.headline-content')
    team_names = []
    team_urls = []
    teams.each do |t|
      team_names << t.text
      team_urls << t.attributes['href'].value
    end
    [team_names, team_urls]
  end

  def scrape_players(team_url)
    html = open(team_url)
    doc = Nokogiri::HTML(html)
    player_names = []
    player_urls = []
    players = doc.css('.table.tabledt').css('tbody').css('a')
    players.each do |player|
      player_names << player.text
      player_urls << player.attributes['href'].value
    end
    binding.pry
  end

  def scrape_player_info(player_url)
    html = open(player_url)
    doc = Nokogiri::HTML(html)
  end

  def scrape_player_stats(player_url)
    
  end

  def scrape_player_last_match_performance(player_url)
    
  end

  def scrape_player_stats(player_url)
    
  end

end

# https://www.fantacalcio.it/squadre/Atalanta/MURIEL/507