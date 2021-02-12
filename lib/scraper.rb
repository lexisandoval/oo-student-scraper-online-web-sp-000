require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each do |student|
      students_info = {}
      students_info[:name] = student.css(".student-name").text
      students_info[:location] = student.css(".student-location").text
      students_info[:profile_url] = student.css("a").attribute("href").value
      students << students_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}

    doc.css(".main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    end

    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".description-holder p").text

    student_profile
  end
end
