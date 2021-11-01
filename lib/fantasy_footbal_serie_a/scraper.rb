class FantasyFootballSerieA::Scraper

  def initialize
    @stat_names = {
      '0' => 'match_played',
      '1' => 'goals',
      '2' => 'yellow_cards',
      '3' => 'red_cards',
      '4' => 'assists',
      '5' => 'penalties',
      '6' => 'avarage_performance',
      '7' => 'avarage_fantasy_performance',
      '8' => 'initial_price',
      '9' => 'price'
    }
  end

  def update_all
    scrape_teams
  end

  def update_player(player)
    updated_attrs = scrape_player_details(player.url)
    update_player_attributes(player, updated_attrs)
    player.save
  end

  private

  def scrape_teams
    reset_db
    html = URI.open('https://www.fantacalcio.it/squadre')
    doc = Nokogiri::HTML(html)
    teams = doc.css('.headline-content')
    teams.each do |t|
      team = FantasyFootballSerieA::Team.create(name: t.text, url: t.attributes['href'].value)
      puts "getting #{team.name}'s' players details"
      scrape_players(team.url, team)
    end
  end

  def scrape_players(team_url, team)
    html = URI.open(team_url)
    doc = Nokogiri::HTML(html)
    players = doc.css('.table.tabledt').css('tbody').css('a')
    players.each do |player|
      player_url = player.attributes['href'].value
      attributes = scrape_player_details(player_url)
      attributes[:name] = player.text
      attributes[:url] = player_url
      player = FantasyFootballSerieA::Player.create(attributes)
      team.players << player
    end
  end

  def scrape_player_details(player_url)
    html = URI.open(player_url)
    doc = Nokogiri::HTML(html)
    details = get_details(doc)
    infos = get_infos(doc)
    {
      role: infos['Ruolo Classic'],
      dob: infos['Data di nascita'],
      height: infos['Altezza'].split(' ').first.to_i,
      weight: get_weight(infos['Peso']),
      nationality: infos['Nazionalità'],
      shirt_number: infos['Numero maglia'].to_i,
      avarage_performance: details['avarage_performance'],
      avarage_fantasy_performance: details['avarage_fantasy_performance'],
      match_played: details['match_played'].to_i,
      goals: details['goals'].to_i,
      yellow_cards: details['yellow_cards'].to_i,
      red_cards: details['red_cards'].to_i,
      assists: details['assists'].to_i,
      penalties: details['penalties'],
      initial_price: details['initial_price'].to_i,
      price: details['price'].to_i
    }
  end

  def get_details(doc)
    details_on_page = doc.css('p.nbig')
    details = {}
    details_on_page.each.with_index do |stat, i|
      details["#{@stat_names["#{i}"]}"] = stat.text
    end
    details['penalties'] = details['penalties'].gsub(/su/, '/')
    details_on_page2 = doc.css('p.nbig2')
    details_on_page2.each.with_index(6) do |stat, i|
      break if i > 9 # all informations after are not useful for this CLI
      details["#{@stat_names["#{i}"]}"] = stat.text
    end
    details
  end

  def get_infos(doc)
    infos = {}
    infos_on_page = doc.css('li.col-sm-12')
    infos_on_page.each do |info|
      infos["#{info.children.first.text}"] = info.children.last.text
    end
    infos
  end

  def get_weight(weight)
    if weight.match(/\d+ Kg/)
      weight.split(' ').first.to_i
    else
      nil
    end
  end

  def update_player_attributes(player, attrs)
    player.role = attrs[:role]
    player.dob = attrs[:dob]
    player.height = attrs[:height]
    player.weight = attrs[:weight]
    player.nationality = attrs[:nationality]
    player.shirt_number = attrs[:shirt_number]
    player.avarage_performance = attrs[:avarage_performance]
    player.avarage_fantasy_performance = attrs[:avarage_fantasy_performance]
    player.match_played = attrs[:match_played]
    player.goals = attrs[:goals]
    player.yellow_cards = attrs[:yellow_cards]
    player.red_cards = attrs[:red_cards]
    player.assists = attrs[:assists]
    player.penalties = attrs[:penalties]
    player.initial_price = attrs[:initial_price]
    player.price = attrs[:price]
  end

  def reset_db
    Rake::Task['db:drop'].invoke
    Rake::Task['db:migrate'].invoke
  end

end

