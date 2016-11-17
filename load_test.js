require 'ruby-jmeter'

test do
  threads count: 35 do
    visit name: ''
  end
end
