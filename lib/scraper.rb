require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
      student = Student.new
      student.name = card.css(".student-name").text
      student.location = card.css(".student-location").text
      student.profile_url = card.css("a").text
    end


   #binding.pry
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".student-card").each do |card|
      student = Student.new
      student.name = card.css(".student-name").text
      student.location = card.css(".student-location").text
      student.profile_url = card.css("a").text
    end

  end

end

Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
