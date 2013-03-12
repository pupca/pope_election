File.open("popes.txt", "r") do |file|
  file.each do |line|
    line = line.split("-")
    Pope.create(:name => line[0].strip, :born => line[1].strip, :title => line[2].strip)
    puts "warning #{line}" unless line[4].nil?
  end
end