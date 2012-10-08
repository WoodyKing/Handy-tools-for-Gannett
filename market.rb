class Market < GicsFile
  def self.markets_load
    table_name = "site_control"
    i = "000"
    File.open("#{Rails.root}/tmp/markets.yml", 'w') do |file|
      markets = Market.select("distinct gci_unit, library").order("gci_unit")
      markets.each do |market|
          file.write("icon#{ market.gci_unit }:\n")
          file.write("  schema: #{market.library}\n")
          file.write("  <<: *defaults\n\n")
      end
    end
  end
end
