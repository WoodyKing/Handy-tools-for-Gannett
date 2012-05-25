class SiteControl < ActiveRecord::Base
  establish_connection "icon_#{ Rails.env }"
  set_table_name "sctl"

  alias_attribute :ucp_library, :libucp
  alias_attribute :circ_library, :licir

  def self.web_pub_site(pub_code)
    SiteControl.find_by_pub(pub_code)
  end

  def self.image_path(gci_unit, pub_code)
    icon_pub = Publication.find(:first, :conditions => 
      { :gci_unit => gci_unit, :pub_code => pub_code }).icon_pub
    @image_path = { :mabu => self.mabu(icon_pub), :icbu => self.icbu(icon_pub) }
  end

  def self.icbu(icon_pub_code)
    self.web_pub_site(icon_pub_code).imgpth.split("&")[0] 
  end

  def self.mabu(icon_pub_code)
    self.web_pub_site(icon_pub_code).imgpth.split("&")[1]
  end

  # This is ideal for creating the default YAML for our sites
  def self.site_load
    table_name = "site_control"
    i = "000"
    File.open("#{Rails.root}/tmp/#{table_name}.yml", 'w') do |file|
      site_controls = SiteControl.all
      site_controls.each do |site_control|
        sc = site_control.imgpth.split("&")
        pubs = Publication.find_by_sql("select * from gics_prod.publications where substring(pub_flags,32,2) = '#{ site_control.pub }'")
        pubs.each do |pub|
          file.write("#{ pub.gci_unit }#{ pub.pub_code }:\n")
          file.write("  icbu: #{sc.first}\n")
          file.write("  mabu: #{sc.second}\n\n")
        end
      end
    end
  end
end