module Jekyll
  class StationPageGenerator < Generator
    safe true

    def generate(site)
      stations = site.data['stations']

      stations.each do |station|
        site.collections['stations'].docs << StationPage.new(site, station)
      end
    end
  end

  class StationPage < Document
    def initialize(site, station)
      @site = site
      @station = station

      super(
        site.in_source_dir("_stations/station.html"),
        {
          :site => site,
          :collection => site.collections["stations"]
        }
      )

      self.data["station_id"] = station["station_id"]
      self.data["station_name"] = station["station_name"]
      self.data["station_stream_url"] = station["station_stream_url"]

      self.data["permalink"] = "/stations/#{station['station_id']}/"
    end
  end
end
