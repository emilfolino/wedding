class Language < ActiveRecord::Base
  has_and_belongs_to_many :weddings

  def self.get_language_hash (wedding)
    languages = Hash.new
    LanguagesWeddings.get_languages(wedding).each do |language|
      languages[language.id] = language.name
    end
    return languages
  end

  def self.policy_class
    LanguagePolicy
  end
end
