require 'active_support/inflector'
require 'json'

N_EVENTS = 200
SIM_TIME_LENGTH = 100
MAX_DURATION = 5

# from https://github.com/palmdalian/json_wordlist/
words = JSON.parse(File.open('etc/wordlist_byPOS.json').read)
words['noun'] = words['noun'].filter { |noun| noun[0] == noun[0].downcase }
words.keys.each do |pos|
  define_method :"#{pos}" do
    words[pos].sample
  end

  define_method :"#{pos}s" do
    words[pos].sample.pluralize
  end
end

companies = JSON.parse(File.open('config/init_companies.json').read)

forms = [
  [:adjective, :nouns, :verb, 'a', :noun],
  [:adjective, :nouns, :verb, 'a couple', :nouns],
  [:nouns, :verb, 'a', :noun],
  [:nouns, :verb, 'some', :nouns],
]

events = []

N_EVENTS.times do
  parts = forms.sample.map do |pos|
    next Object.send(pos) if pos.is_a? Symbol
    next pos
  end
  n_effects = rand(0..companies.length)
  sim_time = rand(1..SIM_TIME_LENGTH)
  duration = rand(1..MAX_DURATION)
  effects = companies.shuffle[0..n_effects].map do |company|
    {
      :symbol => company['symbol'],
      :modifier => rand(-1.0..1.0),
    }
  end
  events.push({
    :description => parts.join(' '),
    :sim_time => sim_time,
    :duration => duration,
    :effects => effects,
  })
end
puts JSON.pretty_generate(events)
