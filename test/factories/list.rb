Factory.define :empty_list, :class => List do |l|
  l.name "List #{rand.to_s[0,10]}"
end