require 'active_support/inflector'
require 'json'

# from https://github.com/palmdalian/json_wordlist/
words = JSON.parse(File.open('etc/wordlist_byPOS.json').read)
words['noun'] = words['noun'].filter { |noun| noun[0] == noun[0].downcase }
words.keys.each do |pos|
  define_method :"#{pos}" do ||
    words[pos].sample
  end

  define_method :"#{pos}s" do ||
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

100.times do
  parts = forms.sample.map do |pos|
    if pos.class == Symbol then
      next Object.send(pos)
    else
      next pos
    end
  end
  n_effects = rand(0..companies.length)
  effects = companies.shuffle[0..n_effects].map do |company|
    {
      :symbol => company['symbol'],
      :modifier => rand(-1.0..1.0),
    }
  end
  events.push({
    :description => parts.join(' '),
    :effects => effects,
  })
end
puts JSON.pretty_generate(events)