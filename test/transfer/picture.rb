require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../../lib/transfer'

url = [
"http://www.transfermarkt.co.uk/japan/leistungsdaten/verein/3435",
"http://www.transfermarkt.co.uk/japan-u22/leistungsdaten/verein/29810",
"http://www.transfermarkt.co.uk/uganda/leistungsdaten/verein/13497",
"http://www.transfermarkt.co.uk/egypt/leistungsdaten/verein/3672",
"http://www.transfermarkt.co.uk/nigeria/leistungsdaten/verein/3444",
"http://www.transfermarkt.co.uk/morocco/leistungsdaten/verein/3575",
"http://www.transfermarkt.co.uk/libya/leistungsdaten/verein/6602",
"http://www.transfermarkt.co.uk/zambia/leistungsdaten/verein/3703",
"http://www.transfermarkt.co.uk/algeria/leistungsdaten/verein/3614",
"http://www.transfermarkt.co.uk/ivory-coast/leistungsdaten/verein/3591",
"http://www.transfermarkt.co.uk/ghana/leistungsdaten/verein/3441",
"http://www.transfermarkt.co.uk/tunisia/leistungsdaten/verein/3670",
"http://www.transfermarkt.co.uk/senegal/leistungsdaten/verein/3499",
"http://www.transfermarkt.co.uk/cape-verde/leistungsdaten/verein/4311",
"http://www.transfermarkt.co.uk/cameroon/leistungsdaten/verein/3434",
"http://www.transfermarkt.co.uk/congo/leistungsdaten/verein/3702",
"http://www.transfermarkt.co.uk/dr-congo/leistungsdaten/verein/3854",
"http://www.transfermarkt.co.uk/mali/leistungsdaten/verein/3674",
"http://www.transfermarkt.co.uk/gabon/leistungsdaten/verein/5704",
"http://www.transfermarkt.co.uk/south-africa/leistungsdaten/verein/3806",
"http://www.transfermarkt.co.uk/guinea/leistungsdaten/verein/3856",
"http://www.transfermarkt.co.uk/burkina-faso/leistungsdaten/verein/5872",
"http://www.transfermarkt.co.uk/north-korea/leistungsdaten/verein/15457/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/south-korea/leistungsdaten/verein/3589/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/china/leistungsdaten/verein/5598/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/iraq/leistungsdaten/verein/3560/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/united-arab-emirates/leistungsdaten/verein/5147/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/saudi-arabia/leistungsdaten/verein/3807/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/oman/leistungsdaten/verein/14165/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/qatar/leistungsdaten/verein/14162/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/jordan/leistungsdaten/verein/15737/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/kuwait/leistungsdaten/verein/3432/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/syria/leistungsdaten/verein/13674/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/lebanon/leistungsdaten/verein/3586/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/thailand/leistungsdaten/verein/5676/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/iran/leistungsdaten/verein/3582/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/hong-kong/leistungsdaten/verein/15977/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/philippinen/leistungsdaten/verein/15234/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/australia/leistungsdaten/verein/3433/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/uzbekistan/leistungsdaten/verein/3563/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/palestine/leistungsdaten/verein/17758/plus/0?reldata=WMQ1%262014",
"http://www.transfermarkt.co.uk/hungary/leistungsdaten/verein/3468",
"http://www.transfermarkt.co.uk/northern-ireland/leistungsdaten/verein/5674",
"http://www.transfermarkt.co.uk/germany/leistungsdaten/verein/3262",
"http://www.transfermarkt.co.uk/belgium/leistungsdaten/verein/3382",
"http://www.transfermarkt.co.uk/portugal/leistungsdaten/verein/3300",
"http://www.transfermarkt.co.uk/spain/leistungsdaten/verein/3375",
"http://www.transfermarkt.co.uk/wales/leistungsdaten/verein/3864",
"http://www.transfermarkt.co.uk/england/leistungsdaten/verein/3299",
"http://www.transfermarkt.co.uk/austria/leistungsdaten/verein/3383",
"http://www.transfermarkt.co.uk/switzerland/leistungsdaten/verein/3384",
"http://www.transfermarkt.co.uk/netherlands/leistungsdaten/verein/3379",
"http://www.transfermarkt.co.uk/czech-republic/leistungsdaten/verein/3445",
"http://www.transfermarkt.co.uk/croatia/leistungsdaten/verein/3556",
"http://www.transfermarkt.co.uk/italy/leistungsdaten/verein/3376",
"http://www.transfermarkt.co.uk/slovakia/leistungsdaten/verein/3503",
"http://www.transfermarkt.co.uk/ukraine/leistungsdaten/verein/3699",
"http://www.transfermarkt.co.uk/russia/leistungsdaten/verein/3448",
"http://www.transfermarkt.co.uk/denmark/leistungsdaten/verein/3436",
"http://www.transfermarkt.co.uk/bosnia-h-/leistungsdaten/verein/3446",
"http://www.transfermarkt.co.uk/albania/leistungsdaten/verein/3561",
"http://www.transfermarkt.co.uk/norway/leistungsdaten/verein/3440",
"http://www.transfermarkt.co.uk/turkey/leistungsdaten/verein/3381",
"http://www.transfermarkt.co.uk/scotland/leistungsdaten/verein/3380",
"http://www.transfermarkt.co.uk/poland/leistungsdaten/verein/3442",
"http://www.transfermarkt.co.uk/sweden/leistungsdaten/verein/3557",
"http://www.transfermarkt.co.uk/slovenia/leistungsdaten/verein/3588",
"http://www.transfermarkt.co.uk/israel/leistungsdaten/verein/5547",
"http://www.transfermarkt.co.uk/ireland/leistungsdaten/verein/3509",
"http://www.transfermarkt.co.uk/serbia/leistungsdaten/verein/3438",
"http://www.transfermarkt.co.uk/finland/leistungsdaten/verein/3443",
"http://www.transfermarkt.co.uk/bulgaria/leistungsdaten/verein/3394",
"http://www.transfermarkt.co.uk/faroe-islands/leistungsdaten/verein/9173",
"http://www.transfermarkt.co.uk/estonia/leistungsdaten/verein/6133",
"http://www.transfermarkt.co.uk/armenia/leistungsdaten/verein/6219",
"http://www.transfermarkt.co.uk/belarus/leistungsdaten/verein/3450",
"http://www.transfermarkt.co.uk/latvia/leistungsdaten/verein/3555",
"http://www.transfermarkt.co.uk/azerbaijan/leistungsdaten/verein/8605",
"http://www.transfermarkt.co.uk/cyprus/leistungsdaten/verein/3668",
"http://www.transfermarkt.co.uk/lithuania/leistungsdaten/verein/3851",
"http://www.transfermarkt.co.uk/macedonia/leistungsdaten/verein/5148",
"http://www.transfermarkt.co.uk/moldova/leistungsdaten/verein/6090",
"http://www.transfermarkt.co.uk/kazakhstan/leistungsdaten/verein/9110",
"http://www.transfermarkt.co.uk/iceland/leistungsdaten/verein/3574",
"http://www.transfermarkt.co.uk/luxembourg/leistungsdaten/verein/3580",
"http://www.transfermarkt.co.uk/montenegro/leistungsdaten/verein/11953",
"http://www.transfermarkt.co.uk/liechtenstein/leistungsdaten/verein/5673",
"http://www.transfermarkt.co.uk/greece/leistungsdaten/verein/3378",
"http://www.transfermarkt.co.uk/georgia/leistungsdaten/verein/3669",
"http://www.transfermarkt.co.uk/romania/leistungsdaten/verein/3447",
"http://www.transfermarkt.co.uk/france/leistungsdaten/verein/3377",
"http://www.transfermarkt.co.uk/trinidad/leistungsdaten/verein/7149",
"http://www.transfermarkt.co.uk/panama/leistungsdaten/verein/3577",
"http://www.transfermarkt.co.uk/haiti/leistungsdaten/verein/14161",
"http://www.transfermarkt.co.uk/guatemala/leistungsdaten/verein/13342",
"http://www.transfermarkt.co.uk/el-salvador/leistungsdaten/verein/13951",
"http://www.transfermarkt.co.uk/st-vincent/leistungsdaten/verein/17762",
"http://www.transfermarkt.co.uk/mexico/leistungsdaten/verein/6303",
"http://www.transfermarkt.co.uk/usatm/leistungsdaten/verein/3505",
"http://www.transfermarkt.co.uk/costa-rica/leistungsdaten/verein/8497",
"http://www.transfermarkt.co.uk/honduras/leistungsdaten/verein/3590",
"http://www.transfermarkt.co.uk/jamaika/leistungsdaten/verein/3671",
"http://www.transfermarkt.co.uk/canada/leistungsdaten/verein/3510",
"http://www.transfermarkt.co.uk/new-zealand/leistungsdaten/verein/9171",
"http://www.transfermarkt.co.uk/argentina/leistungsdaten/verein/3437",
"http://www.transfermarkt.co.uk/brazil/leistungsdaten/verein/3439",
"http://www.transfermarkt.co.uk/chile/leistungsdaten/verein/3700",
"http://www.transfermarkt.co.uk/uruguay/leistungsdaten/verein/3449",
"http://www.transfermarkt.co.uk/ecuador/leistungsdaten/verein/5750",
"http://www.transfermarkt.co.uk/peru/leistungsdaten/verein/3584",
"http://www.transfermarkt.co.uk/paraguay/leistungsdaten/verein/3581",
"http://www.transfermarkt.co.uk/bolivia/leistungsdaten/verein/5233",
"http://www.transfermarkt.co.uk/venezuela/leistungsdaten/verein/3504",
"http://www.transfermarkt.co.uk/colombia/leistungsdaten/verein/3816"
]

for j in 12..(url.size-1)
  test_doc = Transfer.crawl(url[j])
  player_url = Transfer.get_player_url(test_doc)
  player_doc = Transfer.get_player_doc(player_url)
  p Transfer.get_player_picture(player_doc)
end

