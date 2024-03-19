require "open-uri"

count = 0

pdf.font_families.update("AGaramondPro" => {
  :normal => Rails.root.join('public/fonts/AGaramondPro-Regular.ttf').to_s,
  :italic => Rails.root.join('public/fonts/AGaramondPro-Italic.ttf').to_s
})

emblem = Rails.root.join('public/emblem@600dpi.png').to_s
lavender = open("https://s3.eu-central-1.amazonaws.com/lisaochemil/lavender.jpg")

pdf.font "AGaramondPro", :style => :italic

@wedding_guests.each do |wedding_guest|
  pdf.start_new_page(:size => "A5", :layout => :landscape)
  pdf.move_down(150)

  if raw(wedding_guest.user.name).include? "&"
    text = @invitation_texts[wedding_guest.user.language_id].back_body
  else
    text = @invitation_texts[wedding_guest.user.language_id].single_back_body
  end

  pdf.text_box text, :at => [10, pdf.cursor], :align => :center,  :width => 200
  pdf.move_down(50)
  pdf.text_box @urls[wedding_guest.user.language_id] + "/" + wedding_guest.short_token, :at => [10, pdf.cursor], :align => :center,  :width => 200

  pdf.image lavender, :at => [325, 300], :width => 60
end

@wedding_guests.each do |wedding_guest|
  pdf.start_new_page(:size => "A5", :layout => :landscape)
  pdf.move_down(30)
  pdf.image emblem, :at => [50, pdf.cursor], :width => 125

  if raw(wedding_guest.user.name).include? "&"
    text = @invitation_texts[wedding_guest.user.language_id].front_body
  else
    text = @invitation_texts[wedding_guest.user.language_id].single_front_body
  end

  pdf.move_down(70)
  pdf.text_box @dears[wedding_guest.user.language_id] + " " + wedding_guest.user.name + ",", :at => [290, pdf.cursor], :align => :center,  :width => 250
  pdf.move_down(20)
  text_array = text.split("#BIG#")
  pdf.text_box text_array[0], :at => [290, pdf.cursor], :align => :center,  :width => 250
  pdf.move_down(30)
  pdf.font "AGaramondPro", :style => :italic, :size => 18
  pdf.text_box text_array[1], :at => [290, pdf.cursor], :align => :center,  :width => 250
  pdf.move_down(10)
  pdf.font "AGaramondPro", :style => :italic, :size => 12
  pdf.text_box text_array[2], :at => [290, pdf.cursor], :align => :center,  :width => 250
end