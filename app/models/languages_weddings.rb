class LanguagesWeddings < ActiveRecord::Base
  belongs_to :language
  belongs_to :wedding

  def self.get_languages (wedding)
    wedding_languages = LanguagesWeddings.where(wedding: wedding)
    languages = Array.new
    wedding_languages.each do |wedding_language|
      languages.push(wedding_language.language)
    end

    return languages
  end
end
