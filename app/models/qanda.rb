class Qanda < ActiveRecord::Base
  belongs_to :wedding
  belongs_to :user

  def self.indexed_qandas (wedding)
    qandas = Qanda.where(wedding: wedding).where(parent_id: 0)

    return_arr = []

    qandas.each do |qanda|
      arr = Hash.new
      arr["id"] = qanda.id
      arr["body"] = qanda.body
      arr["answers"] = Qanda.where(wedding: wedding).where(parent_id: qanda.id)
      return_arr.push(arr)
    end

    return return_arr
  end


  def self.policy_class
    QandaPolicy
  end
end
