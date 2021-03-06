require 'open-uri'
require 'kconv'
require 'nokogiri'
require 'mysql'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/sweden-u21/leistungsdaten/verein/8595/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/portugal-u21/leistungsdaten/verein/16374/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/germany-u21/leistungsdaten/verein/3817/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/denmark-u21/leistungsdaten/verein/16783/plus/0?reldata=U215%262014",
"http://www.transfermarkt.co.uk/portugal-u21/leistungsdaten/verein/16374/plus/0?reldata=U21Q%262015",
"http://www.transfermarkt.co.uk/fiji-u23/leistungsdaten/verein/35749/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/brazil-u23/leistungsdaten/verein/37018/plus/0?reldata=%262015",
"http://www.transfermarkt.co.uk/sudkorea-u23/startseite/verein/34950/saison_id/2015",
"http://www.transfermarkt.co.uk/irak-u23/startseite/verein/40739/saison_id/2015",
"http://www.transfermarkt.co.uk/iraq-u20/startseite/verein/39540",
"http://www.transfermarkt.co.uk/sudafrika-u23/leistungsdaten/verein/28649",
"http://www.transfermarkt.co.uk/algerien-u23/leistungsdaten/verein/34867",
"http://www.transfermarkt.co.uk/nigeria-u23/leistungsdaten/verein/31096",
"http://www.transfermarkt.co.uk/honduras-u23/startseite/verein/28376",
"http://www.transfermarkt.co.uk/mexico-u23/startseite/verein/16418?saison_id=2015",
"http://www.transfermarkt.co.uk/united-states-u23/startseite/verein/35707",
"http://www.transfermarkt.co.uk/mexico-u23/startseite/verein/16418"
]

national = [
"Sweden U23","Portugal U23","Germany U23","Denmark U23","Portugal U23",
"Fiji U23","Brazil U23","South Korea U23","Iraq U23","Iraq U23",
"South Africa U23","Algeria U23","Nigeria U23","Honduras U23","Mexico U23",
"USA U23","Mexico U23"
]

connection = Mysql::new("127.0.0.1", "root", "motokokusanagi", "soccer_player")

for j in 16..(url.size-1)
  k=0
  p national[j]
  p j*100/national.length
  test_doc = Transfer.crawl(url[j])
  minutes = Transfer.get_player_minutes(test_doc)
  player_url = Transfer.get_player_url(test_doc)

  while minutes[k] != nil do
    if ! /\d+/.match(minutes[k])
      minutes.delete_at(k)
      player_url.delete_at(k)
      k -= 1
    end
    k += 1
  end

  player_doc = Transfer.get_player_doc(player_url)
  team = Transfer.get_player_team(player_doc)
  position = Transfer.get_player_position(player_doc)
  age = Transfer.get_player_age(player_doc)
  height = Transfer.get_player_height(player_doc)
  p name = Transfer.get_player_name(player_doc)
  team_url = Transfer.get_team_url(player_doc)
  team_doc = Transfer.get_team_doc(team_url)
  team_national = Transfer.get_team_national(team_doc)
  division = Transfer.get_team_division(team_doc)

  st = connection.prepare("insert into transfer (name,age,height,position,national,area,team,team_national,division,minutes) values (?,?,?,?,?,?,?,?,?,?) on duplicate key update area=?,team=?,team_national=?,division=?,minutes=?")

  for i in 0..(team_url.size-1)
    st.execute name[i],age[i],height[i],position[i],national[j],"Olympic",team[i],team_national[i],division[i],minutes[i],"Olympic",team[i],team_national[i],division[i],minutes[i]
  end
end

st.close()
connection.close()
