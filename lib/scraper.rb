class Scraper

  def initialize
    @stat_names = {
      '0' => 'match_played',
      '1' => 'goals_cored',
      '2' => 'yellow_cards',
      '3' => 'red_cards',
      '4' => 'assists',
      '5' => 'penalties',
      '6' => 'avarage_performance',
      '7' => 'avarage_fantasy_performance',
      '8' => 'initial_value',
      '9' => 'value'
    }
  end

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
    [player_names, player_urls]
  end

  def scrape_player_info(player_url)
    html = open(player_url)
    doc = Nokogiri::HTML(html)
    infos_on_page = doc.css('li.col-sm-12')
    infos = {}
    infos_on_page.each do |info|
      infos["#{info.children.first.text}"] = info.children.last.text
    end
    infos
  end

  def scrape_player_stats(player_url)
    html = open(player_url)
    doc = Nokogiri::HTML(html)
    stats_on_page = doc.css('p.nbig')
    stats = {}
    stats_on_page.each.with_index do |stat, i|
      stats["#{@stat_names["#{i}"]}"] = stat.text
    end
    stats['penalties'] = stats['penalties'].gsub(/su/, '/')
    stats_on_page2 = doc.css('p.nbig2')
    stats_on_page2.each.with_index(6) do |stat, i|
      break if i > 9
      stats["#{@stat_names["#{i}"]}"] = stat.text
    end
    stats
    binding.pry
  end

end

# https://www.fantacalcio.it/squadre/Atalanta/MURIEL/507
